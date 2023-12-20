+CHARSET_QR_CODE_BANK_NUMBER = CURRENT_BANK_NUMBER

;
; This is actually tiles of 4x4 pixels. Main use is drawing QR codes, but could find other uses.
;

+charset_qr_code:

; Tileset's size in tiles (zero means 256)
.byt (charset_qr_code_end-charset_qr_code_tiles)/8

charset_qr_code_tiles:
.byt %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000
.byt %00000000, %00000000, %00000000, %00000000, %00001111, %00001111, %00001111, %00001111
.byt %00000000, %00000000, %00000000, %00000000, %11110000, %11110000, %11110000, %11110000
.byt %00000000, %00000000, %00000000, %00000000, %11111111, %11111111, %11111111, %11111111
.byt %00001111, %00001111, %00001111, %00001111, %00000000, %00000000, %00000000, %00000000
.byt %00001111, %00001111, %00001111, %00001111, %00001111, %00001111, %00001111, %00001111
.byt %00001111, %00001111, %00001111, %00001111, %11110000, %11110000, %11110000, %11110000
.byt %00001111, %00001111, %00001111, %00001111, %11111111, %11111111, %11111111, %11111111
.byt %11110000, %11110000, %11110000, %11110000, %00000000, %00000000, %00000000, %00000000
.byt %11110000, %11110000, %11110000, %11110000, %00001111, %00001111, %00001111, %00001111
.byt %11110000, %11110000, %11110000, %11110000, %11110000, %11110000, %11110000, %11110000
.byt %11110000, %11110000, %11110000, %11110000, %11111111, %11111111, %11111111, %11111111
.byt %11111111, %11111111, %11111111, %11111111, %00000000, %00000000, %00000000, %00000000
.byt %11111111, %11111111, %11111111, %11111111, %00001111, %00001111, %00001111, %00001111
.byt %11111111, %11111111, %11111111, %11111111, %11110000, %11110000, %11110000, %11110000
.byt %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111
charset_qr_code_end:
