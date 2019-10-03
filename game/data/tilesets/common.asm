TILESET_COMMON_BANK_NUMBER = CURRENT_BANK_NUMBER

tileset_common:

; Tileset's size in tiles (zero means 256)
.byt (tileset_common_end-*)/16

tileset_common_tiles:

;TODO TILE_PLAYER_* tiles are a temporary hack, ultimately they should be removed
;     and constructed at game startup, depending on played characters

; Sinbad icon
TILE_PLAYER_A_ICON = 209
.byt %00111000, %01111100, %10100110, %10110110, %10001110, %10010001, %01000001, %00111110
.byt %00000000, %00000000, %01111100, %01111100, %01110000, %01101110, %00111110, %00000000

; 4 TILES - Sinbad portrait
; Pattern
;  1 2
;  3 4
TILE_PLAYER_A_PORTRAIT_NW = 210
.byt %00000011, %00000111, %11001111, %10101111, %01011100, %01000101, %00110011, %11100011
.byt %00000000, %00000000, %00000000, %01000000, %00100011, %00111010, %00001101, %00011101

TILE_PLAYER_A_PORTRAIT_NE = 211
.byt %11100000, %11110000, %11111000, %11111100, %00000100, %10000100, %11101110, %11111110
.byt %00000000, %00000000, %00000000, %00000000, %11111000, %01111000, %10010100, %11001100

TILE_PLAYER_A_PORTRAIT_SW = 212
.byt %00101001, %01010000, %01010001, %00100001, %00100001, %00010010, %00001000, %00000111
.byt %00010110, %00101111, %00101110, %00011110, %00011110, %00001101, %00000111, %00000000

TILE_PLAYER_A_PORTRAIT_SE = 213
.byt %11101110, %10000010, %11000111, %11000111, %11111111, %00000001, %00000010, %11111100
.byt %00010000, %01111100, %10111010, %10111010, %00000000, %11111110, %11111100, %00000000

; Sinbad icon
TILE_PLAYER_B_ICON = 214
.byt %00111000, %01111100, %10100110, %10110110, %10001110, %10010001, %01000001, %00111110
.byt %00000000, %00000000, %01111100, %01111100, %01110000, %01101110, %00111110, %00000000

; 4 TILES - Sinbad portrait
; Pattern
;  1 2
;  3 4
TILE_PLAYER_B_PORTRAIT_NW = 215
.byt %00000011, %00000111, %11001111, %10101111, %01011100, %01000101, %00110011, %11100011
.byt %00000000, %00000000, %00000000, %01000000, %00100011, %00111010, %00001101, %00011101

TILE_PLAYER_B_PORTRAIT_NE = 216
.byt %11100000, %11110000, %11111000, %11111100, %00000100, %10000100, %11101110, %11111110
.byt %00000000, %00000000, %00000000, %00000000, %11111000, %01111000, %10010100, %11001100

TILE_PLAYER_B_PORTRAIT_SW = 217
.byt %00101001, %01010000, %01010001, %00100001, %00100001, %00010010, %00001000, %00000111
.byt %00010110, %00101111, %00101110, %00011110, %00011110, %00001101, %00000111, %00000000

TILE_PLAYER_B_PORTRAIT_SE = 218
.byt %11101110, %10000010, %11000111, %11000111, %11111111, %00000001, %00000010, %11111100
.byt %00010000, %01111100, %10111010, %10111010, %00000000, %11111110, %11111100, %00000000

; 11 TILES - Numeric font
;
; Available characters, in order:
; "0123456789%"
TILE_CHAR_0 = 219
.byt %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111
.byt %11111111, %11000011, %10011001, %10011101, %10011101, %10011001, %11000011, %11111111
TILE_CHAR_1 = 220
.byt %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111
.byt %11111111, %11111011, %11110011, %11100011, %10010011, %11110011, %11110111, %11111111
TILE_CHAR_2 = 221
.byt %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111
.byt %11111111, %10000011, %00111001, %10011001, %11110011, %11000111, %10000001, %11111111
TILE_CHAR_3 = 222
.byt %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111
.byt %11111111, %10000011, %00111001, %10011001, %11110011, %10011001, %11000011, %11111111
TILE_CHAR_4 = 223
.byt %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111
.byt %11111111, %11110011, %11100111, %11001111, %10010011, %11000001, %11110011, %11111111
TILE_CHAR_5 = 224
.byt %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111
.byt %11111111, %00000001, %00111001, %00111111, %00000011, %11111001, %00000011, %11111111
TILE_CHAR_6 = 225
.byt %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111
.byt %11111111, %11000011, %00011001, %00111111, %00000011, %00111001, %10000011, %11111111
TILE_CHAR_7 = 226
.byt %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111
.byt %11111111, %10000011, %00111001, %11110011, %10000011, %11100111, %11101111, %11111111
TILE_CHAR_8 = 227
.byt %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111
.byt %11111111, %11000011, %10011001, %10010011, %11000011, %11001001, %11100011, %11111111
TILE_CHAR_9 = 228
.byt %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111
.byt %11111111, %10000011, %00111001, %10011001, %11000001, %11111001, %10000011, %11111111
TILE_CHAR_PCT = 229
.byt %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111
.byt %11111111, %10111001, %01010011, %10100111, %11001011, %11000101, %10011011, %11111111

; 26 TILES - Alphabetical font
TILE_CHAR_A = 230
.byt %00000000, %00111100, %01100110, %11000110, %11110110, %11111110, %11000110, %01000010
.byt %11111111, %11000011, %10011001, %00111001, %00001001, %00000001, %00111001, %10111101
TILE_CHAR_B = 231
.byt %00000000, %01111100, %11000110, %11110110, %11111100, %11000110, %11100110, %01011100
.byt %11111111, %10000011, %00111001, %00001001, %00000011, %00111001, %00011001, %10100011
TILE_CHAR_C = 232
.byt %00000000, %00111000, %01111100, %11100110, %11000000, %11000000, %01100110, %00111100
.byt %11111111, %11000111, %10000011, %00011001, %00111111, %00111111, %10011001, %11000011
TILE_CHAR_D = 233
.byt %00000000, %11111000, %11001100, %11000110, %11000110, %11000110, %11100100, %10111000
.byt %11111111, %00000111, %00110011, %00111001, %00111001, %00111001, %00011011, %01000111
TILE_CHAR_E = 234
.byt %00000000, %01111100, %11000110, %11000000, %11110000, %11000000, %01100000, %00111100
.byt %11111111, %10000011, %00111001, %00111111, %00001111, %00111111, %10011111, %11000011
TILE_CHAR_F = 235
.byt %00000000, %01111100, %11000110, %11000000, %11110000, %11111000, %11000000, %01000000
.byt %11111111, %10000011, %00111001, %00111111, %00001111, %00000111, %00111111, %10111111
TILE_CHAR_G = 236
.byt %00000000, %00111100, %01100110, %11000000, %11011110, %11000110, %01100110, %00111100
.byt %11111111, %11000011, %10011001, %00111111, %00100001, %00111001, %10011001, %11000011
TILE_CHAR_H = 237
.byt %00000000, %11000110, %11000110, %11110110, %11111110, %11000110, %11000110, %01000010
.byt %11111111, %00111001, %00111001, %00001001, %00000001, %00111001, %00111001, %10111101
TILE_CHAR_I = 238
.byt %00000000, %10000000, %01111110, %00011000, %00110000, %00110000, %10110000, %01111110
.byt %11111111, %01111111, %10000001, %11100111, %11001111, %11001111, %01001111, %10000001
TILE_CHAR_J = 239
.byt %00000000, %11000000, %01111110, %00011000, %00011000, %10001100, %11001100, %01111000
.byt %11111111, %00111111, %10000001, %11100111, %11100111, %01110011, %00110011, %10000111
TILE_CHAR_K = 240
.byt %00000000, %01100000, %01100110, %11001100, %11111000, %11110000, %11011000, %10011100
.byt %11111111, %10011111, %10011001, %00110011, %00000111, %00001111, %00100111, %01100011
TILE_CHAR_L = 241
.byt %00000000, %00110000, %01110000, %01100000, %11000000, %11000000, %11000110, %01111100
.byt %11111111, %11001111, %10001111, %10011111, %00111111, %00111111, %00111001, %10000011
TILE_CHAR_M = 242
.byt %00000000, %01000100, %11101110, %11111110, %11010110, %11000110, %11000110, %01000010
.byt %11111111, %10111011, %00010001, %00000001, %00101001, %00111001, %00111001, %10111101
TILE_CHAR_N = 243
.byt %00000000, %11000010, %11100110, %11110110, %11011110, %11001110, %11001110, %01000100
.byt %11111111, %00111101, %00011001, %00001001, %00100001, %00110001, %00110001, %10111011
TILE_CHAR_O = 244
.byt %00000000, %00111100, %01100110, %01100110, %11000110, %11001110, %11001100, %01110000
.byt %11111111, %11000011, %10011001, %10011001, %00111001, %00110001, %00110011, %10001111
TILE_CHAR_P = 245
.byt %00000000, %11111100, %01100110, %11100110, %11110110, %11011100, %11000000, %01000000
.byt %11111111, %00000011, %10011001, %00011001, %00001001, %00100011, %00111111, %10111111
TILE_CHAR_Q = 246
.byt %00000000, %00111100, %01100110, %01100110, %11011010, %11001100, %11001100, %01110110
.byt %11111111, %11000011, %10011001, %10011001, %00100101, %00110011, %00110011, %10001001
TILE_CHAR_R = 247
.byt %00000000, %00111100, %01100110, %11000110, %11111100, %11011000, %11001100, %01000110
.byt %11111111, %11000011, %10011001, %00111001, %00000011, %00100111, %00110011, %10111001
TILE_CHAR_S = 248
.byt %00000000, %00111100, %01100110, %01100000, %00111000, %10001100, %11001100, %01111000
.byt %11111111, %11000011, %10011001, %10011111, %11000111, %01110011, %00110011, %10000111
TILE_CHAR_T = 249
.byt %00000000, %11111100, %01111110, %00011000, %00011000, %00011000, %00011000, %00001000
.byt %11111111, %00000011, %10000001, %11100111, %11100111, %11100111, %11100111, %11110111
TILE_CHAR_U = 250
.byt %00000000, %00100010, %01100110, %01100110, %11000110, %11000110, %01100110, %00111100
.byt %11111111, %11011101, %10011001, %10011001, %00111001, %00111001, %10011001, %11000011
TILE_CHAR_V = 251
.byt %00000000, %10000010, %11000110, %11001100, %11001100, %01001000, %00101000, %00010000
.byt %11111111, %01111101, %00111001, %00110011, %00110011, %10110111, %11010111, %11101111
TILE_CHAR_W = 252
.byt %00000000, %10000100, %11000110, %11010110, %11010110, %11110110, %01111110, %00101100
.byt %11111111, %01111011, %00111001, %00101001, %00101001, %00001001, %10000001, %11010011
TILE_CHAR_X = 253
.byt %00000000, %01000110, %01101100, %00111000, %00110000, %00111000, %01101100, %11000100
.byt %11111111, %10111001, %10010011, %11000111, %11001111, %11000111, %10010011, %00111011
TILE_CHAR_Y = 254
.byt %00000000, %01000010, %11000110, %01101100, %00111000, %00011000, %00011000, %00010000
.byt %11111111, %10111101, %00111001, %10010011, %11000111, %11100111, %11100111, %11101111
TILE_CHAR_Z = 255
.byt %00000000, %11111100, %01111110, %00001100, %00011000, %01110000, %11000010, %01111110
.byt %11111111, %00000011, %10000001, %11110011, %11100111, %10001111, %00111101, %10000001

tileset_common_end:
