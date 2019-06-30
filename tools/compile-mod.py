#!/usr/bin/env python
from stblib import ensure
import json
import os
import stblib.asmformat.tiles
import stblib.jsonformat
import sys
import textwrap

def text_asm(text, size, space_tile):
	"""
	Convert a string to a fixed-size sequence of tile indexes in assembly
	"""
	assert len(text) <= size

	padded_text = text.center(size)
	tiled_text = stblib.utils.str_to_tile_index(padded_text, special_cases = {' ':space_tile})
	assert len(tiled_text) == size

	res = ''
	for i in range(len(tiled_text)):
		char_index = tiled_text[i]
		res += stblib.utils.uintasm8(char_index)
		if i != size - 1:
			res += ', '

	return res

def generate_character(char, game_dir):
	name_upper = char.name.upper()

	# Create destination directories
	rel_char_dir = 'game/data/characters/{}'.format(char.name)
	rel_anim_dir = '{}/animations'.format(rel_char_dir)
	char_dir = '{}/{}'.format(game_dir, rel_char_dir)
	anim_dir = '{}/{}'.format(game_dir, rel_anim_dir)
	os.makedirs(char_dir)
	os.makedirs(anim_dir)

	# Label names that are used in multiple places
	tileset_label_name = '{}_chr_tiles'.format(char.name)
	primary_palettes_label_name = '{}_character_palettes'.format(char.name)
	alternate_palettes_label_name = '{}_character_alternate_palettes'.format(char.name)
	weapon_palettes_label_name = '{}_weapon_palettes'.format(char.name)
	character_names_label_name = '{}_character_names'.format(char.name)
	weapon_names_label_name = '{}_weapon_names'.format(char.name)
	properties_table_label_name = '{}_properties'.format(char.name)

	# Create character's master file
	master_file_path = '{}/{}.asm'.format(char_dir, char.name)
	with open(master_file_path, 'w') as master_file:
		master_file.write(textwrap.dedent("""\
			{name_upper}_BANK_NUMBER = CURRENT_BANK_NUMBER

			#include "{rel_char_dir}/chr_tiles.asm"
			#include "{rel_char_dir}/animations/animations.asm"
			#include "{rel_char_dir}/character_colors.asm"
			#include "{rel_char_dir}/properties.asm"
			#include "{rel_char_dir}/state_events.asm"
			#include "{rel_char_dir}/player_states.asm"
		""".format_map(locals())))

	# Tileset file
	chr_tiles_file_path = '{}/chr_tiles.asm'.format(char_dir)
	with open(chr_tiles_file_path, 'w') as chr_tiles_file:
		# Tileset label
		chr_tiles_file.write('{}:\n\n'.format(tileset_label_name))

		# Tiles in binary form, each with a label containing its index
		index_expression = '(*-{})/16'.format(tileset_label_name)
		for tile_index in range(len(char.tileset.tilenames)):
			tile = char.tileset.tiles[tile_index]
			tile_name = char.tileset.tilenames[tile_index]

			# Label containing tile's index
			chr_tiles_file.write('{} = {}\n'.format(tile_name, index_expression))

			# Tile data
			chr_tiles_file.write('{}\n\n'.format(stblib.asmformat.tiles.tile_to_asm(tile)))

		# Tileset footer
		chr_tiles_file.write(textwrap.dedent("""\
			{name_upper}_SPRITE_TILES_NUMBER = {index_expression}
			#print {name_upper}_SPRITE_TILES_NUMBER
			#if {name_upper}_SPRITE_TILES_NUMBER > 96
			#error too many sprites for character {name_upper}
			#endif
		""".format_map(locals())))

	# Palettes file
	character_colors_file_path = '{}/character_colors.asm'.format(char_dir)
	with open(character_colors_file_path, 'w') as character_colors_file:
		def write_palettes_table(palettes, label_name, description):
			def _c(i):
				return stblib.utils.intasm8(palette.colors[i])
			character_colors_file.write('; {}\n'.format(description))
			character_colors_file.write('{}:\n'.format(label_name))
			for palette in palettes:
				character_colors_file.write('.byt {}, {}, {}\n'.format(_c(0), _c(1), _c(2)))
			character_colors_file.write('\n')

		def write_palette_names_table(names, label_name, description):
			character_colors_file.write('; {}\n'.format(description))
			character_colors_file.write('{}:\n'.format(label_name))
			for name in names:
				character_colors_file.write('.byt {} ; {}\n'.format(text_asm(name, 8, 2), name))
			character_colors_file.write('\n')

		# Primary palettes
		write_palettes_table(
			char.color_swaps.primary_colors,
			primary_palettes_label_name,
			'Main palette for character'
		)

		# Alternate palettes
		write_palettes_table(
			char.color_swaps.alternate_colors,
			alternate_palettes_label_name,
			'Alternate palette to use to reflect special state'
		)

		# Primary palettes names
		write_palette_names_table(
			char.color_swaps.primary_names,
			character_names_label_name,
			'Character palette name'
		)

		# Secondary palettes
		write_palettes_table(
			char.color_swaps.secondary_colors,
			weapon_palettes_label_name,
			'Secondary palette for character'
		)

		# Secondary palettes names
		write_palette_names_table(
			char.color_swaps.secondary_names,
			weapon_names_label_name,
			'Weapon palette name'
		)

	# Character properties
	properties_file_path = '{}/properties.asm'.format(char_dir)
	with open(properties_file_path, 'w') as properties_file:
		# Propeties table's label
		properties_file.write('{}:\n'.format(properties_table_label_name))

		# Standard animations
		properties_file.write('VECTOR({})\n'.format(char.victory_animation.name))
		properties_file.write('VECTOR({})\n'.format(char.defeat_animation.name))
		properties_file.write('VECTOR({})\n'.format(char.menu_select_animation.name))

		# Character name
		properties_file.write('.byt {} ; {}\n'.format(text_asm(char.name, 10, 2), char.name))
		properties_file.write('.byt {} ; {}\n'.format(text_asm(char.weapon_name, 10, 2), char.weapon_name))

	# State events
	state_events_file_path = '{}/state_events.asm'.format(char_dir)
	with open(state_events_file_path, 'w') as state_events_file:
		# State count
		state_events_file.write('{}_NUM_STATES = {}\n\n'.format(name_upper, len(char.states)))

		# Routines tables
		for routine_type in ['start', 'update', 'offground', 'onground', 'input', 'onhurt']:
			state_events_file.write('{}_state_{}_routines:\n'.format(char.name, routine_type))
			for state in char.states:
				routine_name = getattr(state, '{}_routine'.format(routine_type))
				ensure(routine_name is not None or routine_type is 'start', 'in {}\'s state {}, missing {} routine'.format(char.name, state.name, routine_type))

				if routine_name is not None:
					state_events_file.write('STATE_ROUTINE({}) ; {}\n'.format(routine_name, state.name))
			state_events_file.write('\n')

	# Character's logic
	player_states_file_path = '{}/player_states.asm'.format(char_dir)
	with open(player_states_file_path, 'w') as player_states_file:
		player_states_file.write(char.sourcecode)

	# Animations
	rel_animations_path = []
	def write_animation_file(anim):
		rel_anim_file_path = '{}/{}.asm'.format(rel_anim_dir, anim.name)
		anim_file_path = '{}/{}'.format(game_dir, rel_anim_file_path)

		with open(anim_file_path, 'w') as anim_file:
			anim_file.write(anim.serialize())
		rel_animations_path.append(rel_anim_file_path)

	write_animation_file(char.victory_animation)
	write_animation_file(char.defeat_animation)
	write_animation_file(char.menu_select_animation)
	for anim in char.animations:
		write_animation_file(anim)

	master_animations_file_path = '{}/animations.asm'.format(anim_dir)
	with open(master_animations_file_path, 'w') as master_animations_file:
		for rel_anim_file_path in rel_animations_path:
			master_animations_file.write('#include "{}"\n'.format(rel_anim_file_path))

def generate_characters_index(characters, game_dir):
	characters_index_file_path = '{}/game/data/characters/characters-index.asm'.format(game_dir)
	with open(characters_index_file_path, 'w') as characters_index_file:
		def _w(s):
			characters_index_file.write(s)

		def _w_table(desc, name, value):
			if desc is not None and len(desc) > 0:
				_w('; {}\n'.format(desc))
			_w('{}:\n'.format(name))
			for char in characters:
				_w('.byt {} ; {}\n'.format(value(char), char.name.capitalize()))
			_w('\n')

		def _w_routine_table(routine_type):
			_w_table(
				'',
				'characters_{}_routines_table_lsb'.format(routine_type),
				lambda c: '<{}_state_{}_routines'.format(c.name, routine_type)
			)
			_w_table(
				'',
				'characters_{}_routines_table_msb'.format(routine_type),
				lambda c: '>{}_state_{}_routines'.format(c.name, routine_type)
			)

		_w('; Number of characters referenced in following tables\n')
		_w('CHARACTERS_NUMBER = {}\n\n'.format(len(characters)))

		_w_table(
			'Bank in which each character is stored',
			'characters_bank_number',
			lambda c: '{}_BANK_NUMBER'.format(c.name.upper())
		)
		_w_table(
			'Begining of tiles data for each character',
			'characters_tiles_data_lsb',
			lambda c: '<{}_chr_tiles'.format(c.name)
		)
		_w_table(
			'',
			'characters_tiles_data_msb',
			lambda c: '>{}_chr_tiles'.format(c.name)
		)
		_w_table(
			'Number of CHR tiles per character',
			'characters_tiles_number',
			lambda c: '{}_SPRITE_TILES_NUMBER'.format(c.name.upper())
		)
		_w_table(
			'Character properties',
			'characters_properties_lsb',
			lambda c: '<{}_properties'.format(c.name)
		)
		_w_table(
			'',
			'characters_properties_msb',
			lambda c: '>{}_properties'.format(c.name)
		)
		_w_table(
			'Colorswap information',
			'characters_palettes_names_lsb',
			lambda c: '<{}_character_names'.format(c.name)
		)
		_w_table(
			'',
			'characters_palettes_names_msb',
			lambda c: '>{}_character_names'.format(c.name)
		)
		_w_table(
			'',
			'characters_palettes_lsb',
			lambda c: '<{}_character_palettes'.format(c.name)
		)
		_w_table(
			'',
			'characters_palettes_msb',
			lambda c: '>{}_character_palettes'.format(c.name)
		)
		_w_table(
			'',
			'characters_alternate_palettes_lsb',
			lambda c: '<{}_character_alternate_palettes'.format(c.name)
		)
		_w_table(
			'',
			'characters_alternate_palettes_msb',
			lambda c: '>{}_character_alternate_palettes'.format(c.name)
		)
		_w_table(
			'',
			'characters_weapon_names_lsb',
			lambda c: '<{}_weapon_names'.format(c.name)
		)
		_w_table(
			'',
			'characters_weapon_names_msb',
			lambda c: '>{}_weapon_names'.format(c.name)
		)
		_w_table(
			'',
			'characters_weapon_palettes_lsb',
			lambda c: '<{}_weapon_palettes'.format(c.name)
		)
		_w_table(
			'',
			'characters_weapon_palettes_msb',
			lambda c: '>{}_weapon_palettes'.format(c.name)
		)

		_w('; Begining of character\'s jump tables\n')
		for routine_type in ['start', 'update', 'offground', 'onground', 'input', 'onhurt']:
			_w_routine_table(routine_type)

def main():
	# Parse command line
	if len(sys.argv) < 3 or sys.argv[1] == '-h' or sys.argv[1] == '--help':
		print('Compile a game mod stored in JSON format to Super Tilt Bro. source files')
		print('')
		print('usage: {} game-mod-path super-tilt-bro-path')
		print('')
		return 1

	mod_file = sys.argv[1]
	ensure(os.path.isfile(mod_file), 'file not found: "{}"'.format(mod_file))

	game_dir = sys.argv[2]
	ensure(os.path.isdir(game_dir), 'directory not found: "{}"'.format(game_dir))
	game_dir = os.path.abspath(game_dir)
	if os.path.basename(game_dir) == 'game':
		gamedir = os.path.dirname(gamedir)
	ensure(os.path.isdir('{}/game'.format(game_dir)), '"game/" folder not found in source directory "{}"'.format(game_dir))

	# Parse mod
	with open(mod_file, 'r') as f:
		mod_dict = stblib.jsonformat.json_to_dict(f, os.path.dirname(mod_file))
	mod = stblib.dictformat.import_from_dict(mod_dict)
	mod.check()

	# Generate characters
	char_to_bank = {}
	current_bank = 0
	for character in mod.characters:
		if character.name not in char_to_bank:
			char_to_bank[character.name] = current_bank
			current_bank += 1

		generate_character(character, game_dir)

	# Generate common files
	generate_characters_index(mod.characters, game_dir)

	#TODO Banks master files

	return 0

if __name__ == '__main__':
	sys.exit(main())