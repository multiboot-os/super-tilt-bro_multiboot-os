#!/usr/bin/env python

import stblib.stages
from stblib.utils import asmint, asmsint8, asmsint16, intasm8, intasm16, uintasm8

def stage_to_asm(stage):
	"""
	Serialize a stage to assembly.
	"""
	serialized = ''

	# Header specific to Break th Target mode
	if len(stage.targets) != 0:
		serialized += '{}_data_header:\n'.format(stage.name)
		for target in stage.targets:
			serialized += 'ARCADE_TARGET({}, {})\n'.format(uintasm8(target.left), uintasm8(target.top))
		for x in range(len(stage.targets), 10):
			serialized += 'ARCADE_TARGET($fe, $fe)\n'

	# Common stage data
	serialized += stage.serialize_layout()

	return serialized
