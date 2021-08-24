MENU_MODE_SELECTION_SCREEN_BANK = CURRENT_BANK_NUMBER

.(
CA = $dc + TILE_ALPHANUM_A
CB = $dc + TILE_ALPHANUM_B
CC = $dc + TILE_ALPHANUM_C
CD = $dc + TILE_ALPHANUM_D
CE = $dc + TILE_ALPHANUM_E
CF = $dc + TILE_ALPHANUM_F
CG = $dc + TILE_ALPHANUM_G
CH = $dc + TILE_ALPHANUM_H
CI = $dc + TILE_ALPHANUM_I
CJ = $dc + TILE_ALPHANUM_J
CK = $dc + TILE_ALPHANUM_K
CL = $dc + TILE_ALPHANUM_L
CM = $dc + TILE_ALPHANUM_M
CN = $dc + TILE_ALPHANUM_N
CO = $dc + TILE_ALPHANUM_O
CP = $dc + TILE_ALPHANUM_P
CQ = $dc + TILE_ALPHANUM_Q
CR = $dc + TILE_ALPHANUM_R
CS = $dc + TILE_ALPHANUM_S
CT = $dc + TILE_ALPHANUM_T
CU = $dc + TILE_ALPHANUM_U
CV = $dc + TILE_ALPHANUM_V
CW = $dc + TILE_ALPHANUM_W
CX = $dc + TILE_ALPHANUM_X
CY = $dc + TILE_ALPHANUM_Y
CZ = $dc + TILE_ALPHANUM_Z

&menu_mode_selection_palette:
; Background
;    0-sky/inactive_box, 1-active_box,       2-title,         3-unused
.byt $21,$0f,$02,$11,    $21,$0f,$08,$28,    $21,$0f,$28,$20, $21,$00,$00,$00
; Sprites
;    0-unused,           1-unused,           2-unused,        3-clouds
.byt $21,$00,$00,$00,    $21,$00,$00,$00,    $21,$00,$00,$00, $21,$0f,$00,$31

&nametable_mode_selection:
.byt $00,$68
.byt
.byt
.byt                                           $01, $02, $03, $04,  $05, $06, $07, $08,  ZIPZ,$05, $06, $09,  $0a, $0b, $0c, $07,  $08, $00,$0f
;    -------------------  -------------------  -------------------  -------------------  -------------------  -------------------  -------------------  -------------------
.byt                                           $0d, $0e, $0f, $10,  $11, $12, $13, $14,  ZIPZ,$11, $12, $15,  $16, $17, $18, $13,  $14, $00,$6b
.byt
.byt
.byt
;    -------------------  -------------------  -------------------  -------------------  -------------------  -------------------  -------------------  -------------------
.byt                      $19, $1a, $1a, $1b,  $1c, $1d, $1e, $1f,  $20, $21, $22, $23,  $00,$02,  $19, $1a,  $1a, $1b, $1c, $1d,  $1e, $1f, $20, $21,  $22, $23, $00,$06
.byt                      $24, $25, $26,  CL,   CO,  CC,  CA,  CL,  $26, $26, $26, $27,  $00,$02,  $24, $25,  $26,  CO,  CN,  CL,   CI,  CN,  CE, $26,  $26, $27, $00,$06
.byt                      $28, $29, $26, $26,  $26, $2a, $2b, $26,  $26, $2c, $26, $2d,  $00,$02,  $28, $29,  $26, $26, $2a, $2e,  $2f, $30, $26, $2c,  $26, $2d, $00,$06
.byt                      $31, $26, $26, $26,  $2a, $32, $33, $2b,  $26, $34, $35, $36,  $00,$02,  $31, $26,  $26, $26, $37, $38,  $39, $3a, $26, $34,  $35, $36, $00,$06
;    -------------------  -------------------  -------------------  -------------------  -------------------  -------------------  -------------------  -------------------
.byt                      $3b, $26, $3c, $26,  $3d, $3e, $3f, $40,  $26, $26, $41, $42,  $00,$02,  $3b, $26,  $3c, $26, $43, $44,  $45, $46, $26, $26,  $41, $42, $00,$06
.byt                      $47, $48, $49, $4a,  $4b, $4c, $4d, $4e,  $26, $26, $26, $4f,  $00,$02,  $47, $48,  $49, $4a, $50, $51,  $52, $53, $26, $26,  $26, $4f, $00,$06
.byt                      $54, $26, $26, $26,  $26, $55, $56, $26,  $26, $57, $58, $59,  $00,$02,  $54, $26,  $26, $26, $5a, $5b,  $5c, $5d, $26, $57,  $58, $59, $00,$06
.byt                      $5e, $5f, $60, $61,  $62, $63, $64, $65,  $66, $67, $68, $69,  $00,$02,  $5e, $5f,  $60, $61, $62, $63,  $64, $65, $66, $67,  $68, $69, $00,$2d
;    -------------------  -------------------  -------------------  -------------------  -------------------  -------------------  -------------------  -------------------
.byt
.byt                                                          $19,  $1a, $1a, $1b, $1c,  $1d, $1e, $1f, $20,  $21, $22, $23, $00,$14
.byt                                                          $24,  $25, $26,  CS,  CU,   CP,  CP,  CO,  CR,   CT, $26, $27, $00,$14
.byt                                                          $5e,  $5f, $60, $61, $62,  $6a, $64, $65, $66,  $67, $68, $69, $00,$d4
;    -------------------  -------------------  -------------------  -------------------  -------------------  -------------------  -------------------  -------------------
.byt
.byt
.byt
.byt
;    -------------------  -------------------  -------------------  -------------------  -------------------  -------------------  -------------------  -------------------
.byt
.byt
.byt                                                          $6b,  $6c, $6d, $6e, $6e,  $00,$02,  $6e, $6f,  $70, $6c, $6f, $00,$6b
.byt
;    -------------------  -------------------  -------------------  -------------------  -------------------  -------------------  -------------------  -------------------
.byt
.byt
.byt 
nametable_mode_selection_attributes:
.byt           $a0, $a0, $a0, $a0, $a0,      ZIPNT_ZEROS(1+2)
.byt           $0a, $0a, $0a, $0a, $0a,      ZIPNT_ZEROS(1+1)
.byt      $55, $55, $55,                     ZIPNT_ZEROS(4+1)
.byt      $55, $55, $55,                     ZIPNT_ZEROS(4+8*4)
.byt
.byt
.byt
.byt
nametable_mode_selection_end:
.byt ZIPNT_END

.)