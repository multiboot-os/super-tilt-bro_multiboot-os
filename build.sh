#!/bin/bash

set -e

xa_bin="${XA_BIN:-xa}"
cc_bin="${CC_BIN:-6502-gcc}"
root_dir=`readlink -m $(dirname "$0")`
log_file="${root_dir}/build.log"

c_optim="-O3"
c_compat="-fdelete-null-pointer-checks -fno-isolate-erroneous-paths-dereference" # We may want to dereference address zero at times
c_flags="$c_optim $c_compat"

# Print a message in console and log file
say() {
	echo "$@"
	echo "$@" >> "$log_file"
}

# Print a message in log file
log() {
	echo "$@" >> "$log_file"
}

# Execute a command while logging its output
cmd() {
	echo >> "$log_file"
	echo "+ $@" >> "$log_file"
	$@ >> "$log_file" 2>&1
}

# Execute a command while logging its output only if it fails
exe() {
	echo "+ $@" >> "$log_file.err"
	$@ >> "$log_file.err" 2>&1
	rm "$log_file.err"
}

#TODO check dependencies (python >= 3.2, xa, pillow)

# Clean old build log
cd "${root_dir}"
rm -f "$log_file"

# Clean generated files
# TODO do not hardcode character names here
say "Clean ..."
log "========="

cmd rm -rf "${root_dir}"/game/data/characters/{sinbad,kiki,characters-index.asm} "${root_dir}"/game/data/tilesets/ruins.asm

for f in `find . -name '*.build.asm'`; do
	cmd rm "$f"
done

# Compile game mod
log
say "Compile game mod ..."
log "===================="
PYTHONPATH="${root_dir}/tools:$PYTHONPATH" cmd "${root_dir}/tools/compile-mod.py" "${root_dir}/game-mod/mod.json" "${root_dir}"

# Compile C files
log
say "Compile C files ..."
log "==================="

for c_source in `find . -name '*.c'`; do
	asm_source="`dirname "$c_source"`/`basename "$c_source" .c`.built.asm"
	"$cc_bin" $c_source -S -I game/ $c_flags -o "$asm_source"
	tools/asm_converter.py "$asm_source"
done

# Assemble the game
log
say "Assemble the game ..."
log "====================="
cmd "$xa_bin" tilt.asm -C -o 'Super_Tilt_Bro_(E).nes' -P /tmp/rainbow.lst
exe "$xa_bin" -DSERVER_BYTECODE -DNO_INES_HEADER tilt.asm -C -o 'server_bytecode.nes' -P /tmp/bytecode.lst
exe "$xa_bin" -DNETWORK_AI tilt.asm -C -o 'tilt_ai_(E).nes'
exe "$xa_bin" -DNO_NETWORK tilt.asm -C -o 'tilt_no_network_(E).nes'
exe "$xa_bin" -DMAPPER_RAINBOW512 tilt.asm -C -o 'tilt_rainbow512_(E).nes'
exe "$xa_bin" -DNO_NETWORK -DMAPPER_UNROM512 tilt.asm -C -o 'tilt_no_network_unrom512_(E).nes'
exe "$xa_bin" -DNO_NETWORK -DMAPPER_UNROM tilt.asm -C -o 'tilt_no_network_unrom_(E).nes'

say
say "======================="
say "Game built successfuly."
say "======================="
