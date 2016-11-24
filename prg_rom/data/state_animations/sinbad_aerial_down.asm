anim_sinbad_aerial_down_left:
; Frame 1
ANIM_FRAME_BEGIN(4)
ANIM_HURTBOX($fc, $08, $00, $0f) ; left, right, top, bottom
ANIM_HITBOX($01, $03, $fd00, $0100, $fffb, $000a, $f4, $00, $06, $0b) ; enabled, damages, base_h, base_v, force_h, force_v, left, right, top, bottom
ANIM_SPRITE($06, TILE_SCIMITAR_BLADE, $01, $f4) ; Y, tile, attr, X
ANIM_SPRITE($06, TILE_SCIMITAR_HANDLE, $01, $fc)
ANIM_SPRITE($00, TILE_SIDE_TILT_SINBAD_3_1, $00, $f8)
ANIM_SPRITE($00, TILE_SIDE_TILT_SINBAD_3_2, $00, $00)
ANIM_SPRITE($08, TILE_SIDE_TILT_SINBAD_3_3, $00, $00)
ANIM_FRAME_END
; Frame 2
ANIM_FRAME_BEGIN(4)
ANIM_HURTBOX($00, $07, $02, $0f)
ANIM_HITBOX($00, $03, $fd00, $0100, $fffb, $000a, $fa, $05, $0e, $15)
ANIM_SPRITE($0e, TILE_ANGLED_DOWN_SCIMITAR_BLADE, $01, $fa) ; Y, tile, attr, X
ANIM_SPRITE($0e, TILE_ANGLED_DOWN_SCIMITAR_HANDLE, $01, $02)
ANIM_SPRITE($00, TILE_LANDING_SINBAD_2_TOP, $00, $00)
ANIM_SPRITE($08, TILE_LANDING_SINBAD_2_BOT, $00, $00)
ANIM_FRAME_END
; Frame 3
ANIM_FRAME_BEGIN(4)
ANIM_HURTBOX($00, $07, $01, $0f)
ANIM_HITBOX($00, $03, $fd00, $0100, $fffb, $000a, $04, $09, $0b, $16)
ANIM_SPRITE($07, TILE_VERTICAL_SCIMITAR_HANDLE, $c1, $04) ; Y, tile, attr, X
ANIM_SPRITE($0f, TILE_VERTICAL_SCIMITAR_BLADE, $c1, $04)
ANIM_SPRITE($00, TILE_LANDING_SINBAD_1_TOP, $00, $00)
ANIM_SPRITE($08, TILE_LANDING_SINBAD_1_BOT, $00, $00)
ANIM_FRAME_END
; End of animation
ANIM_ANIMATION_END

anim_sinbad_aerial_down_right:
; Frame 1
ANIM_FRAME_BEGIN(4)
ANIM_HURTBOX($f7, $03, $00, $0f)
ANIM_HITBOX($01, $03, $0300, $0100, $0005, $000a, $ff, $0b, $06, $0b)
ANIM_SPRITE($08, TILE_SIDE_TILT_SINBAD_3_3, $40, $f8)
ANIM_SPRITE($00, TILE_SIDE_TILT_SINBAD_3_2, $40, $f8)
ANIM_SPRITE($00, TILE_SIDE_TILT_SINBAD_3_1, $40, $00)
ANIM_SPRITE($06, TILE_SCIMITAR_HANDLE, $41, $fc)
ANIM_SPRITE($06, TILE_SCIMITAR_BLADE, $41, $04)
ANIM_FRAME_END
; Frame 2
ANIM_FRAME_BEGIN(4)
ANIM_HURTBOX($f8, $ff, $02, $0f)
ANIM_HITBOX($00, $03, $0300, $0100, $0005, $000a, $fa, $05, $0e, $15)
ANIM_SPRITE($08, TILE_LANDING_SINBAD_2_BOT, $40, $f8)
ANIM_SPRITE($00, TILE_LANDING_SINBAD_2_TOP, $40, $f8)
ANIM_SPRITE($0e, TILE_ANGLED_DOWN_SCIMITAR_HANDLE, $41, $f6)
ANIM_SPRITE($0e, TILE_ANGLED_DOWN_SCIMITAR_BLADE, $41, $fe)
ANIM_FRAME_END
; Frame 3
ANIM_FRAME_BEGIN(4)
ANIM_HURTBOX($f8, $ff, $01, $0f)
ANIM_HITBOX($00, $03, $0300, $0100, $0005, $000a, $f6, $fb, $0b, $16)
ANIM_SPRITE($08, TILE_LANDING_SINBAD_1_BOT, $40, $f8)
ANIM_SPRITE($00, TILE_LANDING_SINBAD_1_TOP, $40, $f8)
ANIM_SPRITE($0f, TILE_VERTICAL_SCIMITAR_BLADE, $81, $f4)
ANIM_SPRITE($07, TILE_VERTICAL_SCIMITAR_HANDLE, $81, $f4)
ANIM_FRAME_END
; End of animation
ANIM_ANIMATION_END