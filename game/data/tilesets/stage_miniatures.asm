TILESET_STAGE_MINIATURES_BANK_NUMBER = CURRENT_BANK_NUMBER

tileset_stage_miniatures:

; Tileset's size in tiles (zero means 256)
.byt (tileset_stage_miniatures_end-tileset_stage_miniatures_tiles)/16

tileset_stage_miniatures_tiles:

; TILES $61 to $64 - The Pit stage miniature
;
; Full picture layout
; $61 $61 $61 $61
; $61 $64 $61 $61
; $62 $61 $61 <62
; $63 $61 <64 <63
;
;  $XX - normal tile
;  <XX - horizontally flipped tile
TILE_MINI_STAGE_PIT_0 = (*-tileset_stage_miniatures_tiles)/16
.byt %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111
.byt %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111
TILE_MINI_STAGE_PIT_1 = (*-tileset_stage_miniatures_tiles)/16
.byt %11111111, %11111111, %11111111, %00000000, %11111111, %11111111, %11111111, %11111111
.byt %11111111, %11111111, %11111111, %11111111, %00000000, %00000000, %00000000, %00000000
TILE_MINI_STAGE_PIT_2 = (*-tileset_stage_miniatures_tiles)/16
.byt %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111
.byt %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000
TILE_MINI_STAGE_PIT_3 = (*-tileset_stage_miniatures_tiles)/16
.byt %11111111, %11000001, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111
.byt %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111

; TILES $67 to $6d - Flatland stage miniature
;
; Full picture layout
; $67 $67 $67 $67
; $67 $68 $67 $67
; $69 $6a $6b <69
; $6c $6d $6d <6c
;
;  $XX - normal tile
;  <XX - horizontally flipped tile
TILE_MINI_STAGE_FLATLAND_0 = (*-tileset_stage_miniatures_tiles)/16
.byt %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111
.byt %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111
TILE_MINI_STAGE_FLATLAND_1 = (*-tileset_stage_miniatures_tiles)/16
.byt %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11110011
.byt %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111
TILE_MINI_STAGE_FLATLAND_2 = (*-tileset_stage_miniatures_tiles)/16
.byt %11111111, %11111111, %11111111, %11110000, %11111111, %11111111, %11111111, %11111111
.byt %11111111, %11111111, %11111111, %11111111, %11110000, %11110000, %11110000, %11110000
TILE_MINI_STAGE_FLATLAND_3 = (*-tileset_stage_miniatures_tiles)/16
.byt %11100001, %11100001, %11111111, %00000000, %11111111, %11111111, %11111111, %11111111
.byt %11111111, %11111111, %11110011, %11111111, %00000000, %00000000, %00000000, %00000000
TILE_MINI_STAGE_FLATLAND_4 = (*-tileset_stage_miniatures_tiles)/16
.byt %11111111, %11111111, %11111111, %00000000, %11111111, %11111111, %11111111, %11111111
.byt %11111111, %11111111, %11111111, %11111111, %00000000, %00000000, %00000000, %00000000
TILE_MINI_STAGE_FLATLAND_5 = (*-tileset_stage_miniatures_tiles)/16
.byt %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111
.byt %11110000, %11110000, %11110000, %11110000, %11110000, %11110000, %11110000, %11110000
TILE_MINI_STAGE_FLATLAND_6 = (*-tileset_stage_miniatures_tiles)/16
.byt %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111
.byt %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000

; TILES $6e to $73 - The Hunt stage miniature
;
; Full picture layout
; $71 $71 $71 $71
; $71 $71 $71 $71
; $6e $6f $70 v6f
; $71 $72 $73 $71
;
;  $XX - normal tile
;  vXX - vertically  flipped tile
TILE_MINI_STAGE_HUNT_0 = (*-tileset_stage_miniatures_tiles)/16
.byt %11111111, %11111111, %11111111, %11111111, %11111111, %11111100, %11111111, %11111111
.byt %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111
TILE_MINI_STAGE_HUNT_1 = (*-tileset_stage_miniatures_tiles)/16
.byt %11111111, %11111111, %11111111, %11111111, %11111111, %00001111, %11111111, %11111111
.byt %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111
TILE_MINI_STAGE_HUNT_2 = (*-tileset_stage_miniatures_tiles)/16
.byt %11111111, %11111111, %11111100, %11111111, %11111111, %11111111, %10011111, %00001111
.byt %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111
TILE_MINI_STAGE_HUNT_3 = (*-tileset_stage_miniatures_tiles)/16
.byt %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111
.byt %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111
TILE_MINI_STAGE_HUNT_4 = (*-tileset_stage_miniatures_tiles)/16
.byt %11111111, %11111111, %00000000, %11111111, %11111111, %11111111, %11111111, %11111111
.byt %11111111, %11111111, %11111111, %00000000, %00000000, %00000000, %00000000, %00000000
TILE_MINI_STAGE_HUNT_5 = (*-tileset_stage_miniatures_tiles)/16
.byt %00001111, %11111111, %00000000, %11111111, %11111111, %11111111, %11111111, %11111111
.byt %11111111, %10011111, %11111111, %00000000, %00000000, %00000000, %00000000, %00000000

; TILES $76 to $7c - Sky Ride stage miniature
;
; Full picture layout
; $76 $76 $76 $76
; $76 $77 <77 $76
; $78 <78 $79 <78
; $7a $7b $7c <7a
;
;  $XX - normal tile
;  <XX - horizontally flipped tile
TILE_MINI_STAGE_SKYRIDE_0 = (*-tileset_stage_miniatures_tiles)/16
.byt %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111
.byt %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111
TILE_MINI_STAGE_SKYRIDE_1 = (*-tileset_stage_miniatures_tiles)/16
.byt %11111111, %11111111, %11111111, %11111111, %11111111, %11000000, %11111111, %11111111
.byt %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111
TILE_MINI_STAGE_SKYRIDE_2 = (*-tileset_stage_miniatures_tiles)/16
.byt %11111111, %11111111, %11111111, %11100000, %11111111, %11111111, %11111111, %11111111
.byt %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111
TILE_MINI_STAGE_SKYRIDE_3 = (*-tileset_stage_miniatures_tiles)/16
.byt %11111111, %11111111, %11111111, %11100000, %11111111, %11111111, %11111111, %11111111
.byt %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111
TILE_MINI_STAGE_SKYRIDE_4 = (*-tileset_stage_miniatures_tiles)/16
.byt %11111111, %11111111, %11111000, %11111111, %11111111, %11111111, %11111111, %11111111
.byt %11111111, %11111111, %11111111, %11111000, %11111000, %11111000, %11111000, %11111000
TILE_MINI_STAGE_SKYRIDE_5 = (*-tileset_stage_miniatures_tiles)/16
.byt %11111111, %11111111, %00000000, %11111111, %11111111, %11111111, %11111111, %11111111
.byt %11111111, %11111111, %11111111, %00000000, %00000000, %00000000, %00000000, %00000000
TILE_MINI_STAGE_SKYRIDE_6 = (*-tileset_stage_miniatures_tiles)/16
.byt %11111111, %11111111, %00000000, %11111111, %11111111, %11111111, %11111111, %11111111
.byt %11111111, %11111111, %11111111, %00000000, %00000000, %00000000, %00000000, %00000000

tileset_stage_miniatures_end: