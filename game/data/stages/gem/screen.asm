stage_gem_palette_data:
; Background
.byt $0f,$07,$16,$27, $0f,$11,$21,$20, $0f,$07,$17,$28, $0f,$04,$14,$24
; Sprites
.byt $0f,$08,$1a,$20, $0f,$08,$10,$37, $0f,$08,$16,$10, $0f,$08,$28,$37

nametable_stage_gem:
.byt $00,$9d
.byt
.byt
.byt
;    -------------------  -------------------  -------------------  -------------------  -------------------  -------------------  -------------------  -------------------
.byt                                                                                                                                                         $03, $00,$1f
.byt                                                                                                                                                         $02, $00,$1f
.byt                                                                                                                                                         $01, $00,$1f
.byt                                                                                                                                                         $02, $00,$05
;    -------------------  -------------------  -------------------  -------------------  -------------------  -------------------  -------------------  -------------------
.byt                $03,  $00,$19,                                                                                                                           $01, $00,$05
.byt                $02,  $00,$19,                                                                                                                           $02, $00,$05
.byt                $01,  $00,$19,                                                                                                                           $01, $00,$05
.byt                $02,  $00,$19,                                                                                                                           $02, $00,$05
;    -------------------  -------------------  -------------------  -------------------  -------------------  -------------------  -------------------  -------------------
.byt                $01,  $00,$19,                                                                                                                           $01, $00,$05
.byt                $02,  $00,$19,                                                                                                                           $02, $00,$05
.byt                $01,  $00,$19,                                                                                                                           $01, $00,$05
.byt                $02,  $00,$13,                                                                                           $04,  $05, $20, $06, $07,  ZIPZ,$02, $00,$05
;    -------------------  -------------------  -------------------  -------------------  -------------------  -------------------  -------------------  -------------------
.byt                $01,  $00,$05,                  $0f, $00,$0d,                                                            $08,  $0a, $09, $09, $0b,  ZIPZ,$01, $00,$05
.byt                $02,  ZIPZ,$06, $07, $06,  $04, $05, $00,$0e,                                                                  $13, $12, $0c, $0d,  ZIPZ,$02, $00,$05
.byt                $01,  ZIPZ,$08, $09, $0a,  $09, $0b, $00,$0d,                                                            $10,  $14, $16, $13, $00,$02,   $01, $00,$05
.byt                $02,  ZIPZ,$10, $0c, $0d,  $0e, $00,$0d,                                                            $12, $13,  $0e, $10, $00,$03,        $02, $00,$05
;    -------------------  -------------------  -------------------  -------------------  -------------------  -------------------  -------------------  -------------------
.byt                $01,  $00,$02,  $16, $13,  $14, $12, $00,$0b,                                                  $16, $13, $13,  $14, $00,$04,             $01, $00,$05
.byt                $02,  $00,$03,       $0c,  $13, $16, $10, ZIPZ, $06, $07, $00,$02,   $04, $05, ZIPZ,$06,  ZIPZ,$0c, $0c, $0d,  $12, $00,$04,             $02, $00,$05
.byt                $01,  $00,$02,  $17, $18,  $19, $18, $19, $18,  $18, $19, $19, $18,  $18, $19, $19, $18,  $19, $18, $18, $19,  $19, $1a, $00,$03,        $01, $00,$05
.byt                $02,  $00,$02,  $1b, $2c,  $1d, $1c, $1d, $1c,  $1d, $2c, $1d, $1c,  $1e, $1c, $2c, $1c,  $1d, $1c, $1d, $1c,  $1d, $1f, $00,$03,        $02, $00,$05
;    -------------------  -------------------  -------------------  -------------------  -------------------  -------------------  -------------------  -------------------
.byt                $01,  $00,$02,  $21, $25,  $22, $d1, $d2, $22,  $29, $26, $25, $24,  $2c, $1e, $25, $1e,  $22, $d6, $d7, $22,  $26, $27, $00,$03,        $01, $00,$02
.byt $20, $20, $20, $02,  $20, $20, $1b, $1e,  $22, $d3, $d4, $22,  $29, $2a, $29, $2a,  $23, $24, $2c, $24,  $22, $d8, $d9, $22,  $1e, $1f, $20, $20,  $20, $02, $20, $20
.byt $28, $28, $28, $28,  $28, $28, $21, $2c,  $22, $22, $22, $e5,  $2c, $23, $26, $25,  $2c, $2a, $1e, $2f,  $22, $22, $22, $e5,  $2c, $27, $28, $28,  $28, $28, $28, $28
.byt $2d, $2d, $2d, $2d,  $2d, $2d, $1b, $2e,  $2f, $25, $23, $24,  $25, $2c, $2a, $29,  $2a, $2e, $2f, $2c,  $29, $26, $23, $26,  $1e, $1f, $2d, $2d,  $2d, $2d, $2d, $2d
;    -------------------  -------------------  -------------------  -------------------  -------------------  -------------------  -------------------  -------------------
.byt $2d, $2d, $2d, $2d,  $2d, $2d, $21, $30,  $31, $2c, $29, $2a,  $29, $1e, $25, $26,  $2c, $30, $31, $25,  $2c, $2a, $2c, $2a,  $29, $27, $2d, $2d,  $2d, $2d, $2d, $2d
.byt $2d, $2d, $2d, $2d,  $2d, $2d, $1b, $1e,  $26, $1e, $23, $24,  $25, $26, $2a, $2b,  $23, $26, $25, $29,  $1e, $25, $1e, $25,  $26, $1f, $2d, $2d,  $2d, $2d, $2d, $2d
nametable_stage_gem_attributes:
.byt ZIPNT_ZEROS(8)
.byt ZIPNT_ZEROS(8)
.byt ZIPNT_ZEROS(8)
.byt ZIPNT_ZEROS(5),                                        %10000000, %01101010
.byt ZIPNT_ZEROS(1+1)
.byt            %10101010, %00100001, ZIPNT_ZEROS(2),       %10001000, %10101010
.byt ZIPNT_ZEROS(1+1)
.byt            %10101010, %10101010, %10101010, %10100101, %10101010, %10101010
.byt ZIPNT_ZEROS(1)
.byt %10100010, %10101010, %10101010, %10101010, %10101010, %10101010, %10101010, %10101000
.byt %10101010, %10101010, %10101010, %10101010, %10101010, %10101010, %10101010, %10101010
nametable_stage_gem_end:
.byt ZIPNT_END
