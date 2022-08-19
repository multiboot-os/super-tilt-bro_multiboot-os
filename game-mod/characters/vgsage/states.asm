!define "char_name" {vgsage}
!define "char_name_upper" {VGSAGE}

;
; States index
;

VGSAGE_STATE_THROWN = PLAYER_STATE_THROWN                             ;  0
VGSAGE_STATE_RESPAWN_INVISIBLE = PLAYER_STATE_RESPAWN                 ;  1
VGSAGE_STATE_INNEXISTANT = PLAYER_STATE_INNEXISTANT                   ;  2
VGSAGE_STATE_SPAWN = PLAYER_STATE_SPAWN                               ;  3
VGSAGE_STATE_IDLE = PLAYER_STATE_STANDING                             ;  4
VGSAGE_STATE_RUNNING = PLAYER_STATE_RUNNING                           ;  5
VGSAGE_STATE_RESPAWN_PLATFORM = CUSTOM_PLAYER_STATES_BEGIN + 0        ;  6
VGSAGE_STATE_JUMPING = CUSTOM_PLAYER_STATES_BEGIN + 1                 ;  7
VGSAGE_STATE_WALLJUMPING = CUSTOM_PLAYER_STATES_BEGIN + 2             ;  8
VGSAGE_STATE_FALLING = CUSTOM_PLAYER_STATES_BEGIN + 3                 ;  9
VGSAGE_STATE_HELPLESS = CUSTOM_PLAYER_STATES_BEGIN + 4                ;  a
VGSAGE_STATE_LANDING = CUSTOM_PLAYER_STATES_BEGIN + 5                 ;  b
VGSAGE_STATE_CRASHING = CUSTOM_PLAYER_STATES_BEGIN + 6                ;  c
VGSAGE_STATE_SHIELDING = CUSTOM_PLAYER_STATES_BEGIN + 7               ;  d
VGSAGE_STATE_SHIELDLAG = CUSTOM_PLAYER_STATES_BEGIN + 8               ;  e
VGSAGE_STATE_JABBING = CUSTOM_PLAYER_STATES_BEGIN + 9                 ;  f
VGSAGE_STATE_UP_TILT = CUSTOM_PLAYER_STATES_BEGIN + 10                ; 10
VGSAGE_STATE_DOWN_TILT = CUSTOM_PLAYER_STATES_BEGIN + 11              ; 11
VGSAGE_STATE_SIDE_TILT = CUSTOM_PLAYER_STATES_BEGIN + 12              ; 12
VGSAGE_STATE_AERIAL_NEUTRAL = CUSTOM_PLAYER_STATES_BEGIN + 13         ; 13
VGSAGE_STATE_AERIAL_UP = CUSTOM_PLAYER_STATES_BEGIN + 14              ; 14
VGSAGE_STATE_AERIAL_DOWN = CUSTOM_PLAYER_STATES_BEGIN + 15            ; 15
VGSAGE_STATE_AERIAL_SIDE = CUSTOM_PLAYER_STATES_BEGIN + 16            ; 16
VGSAGE_STATE_SPECIAL_NEUTRAL_STEP_0 = CUSTOM_PLAYER_STATES_BEGIN + 17 ; 17
VGSAGE_STATE_SPECIAL_NEUTRAL_STEP_1 = CUSTOM_PLAYER_STATES_BEGIN + 18 ; 18
VGSAGE_STATE_SPECIAL_NEUTRAL_STEP_2 = CUSTOM_PLAYER_STATES_BEGIN + 19 ; 19
VGSAGE_STATE_SPECIAL_NEUTRAL_STEP_3 = CUSTOM_PLAYER_STATES_BEGIN + 20 ; 1a
VGSAGE_STATE_SPECIAL_NEUTRAL_STEP_4 = CUSTOM_PLAYER_STATES_BEGIN + 21 ; 1b
VGSAGE_STATE_SPECIAL_NEUTRAL_STEP_5 = CUSTOM_PLAYER_STATES_BEGIN + 22 ; 1c

;
; Gameplay constants
;

                            ; sinbad pepper kiki
VGSAGE_AERIAL_SPEED = $00d0 ; 0100 0100 0100
VGSAGE_AERIAL_DIRECTIONAL_INFLUENCE_STRENGTH = $80 ; 80 80 80
VGSAGE_AIR_FRICTION_STRENGTH = 21 ; 7 7 7
VGSAGE_FASTFALL_SPEED = $0600 ; 500 600 400
VGSAGE_GROUND_FRICTION_STRENGTH = $40 ; 40 40 40
VGSAGE_JUMP_POWER = $0400 ; 480 540 480
VGSAGE_JUMP_SHORT_HOP_POWER = $0102 ; 102 102 102
VGSAGE_JUMP_SHORT_HOP_EXTRA_TIME_PAL = 4 ; 4 4 4 ; Number of frames after jumpsquat at which shorthop is handled
VGSAGE_JUMP_SHORT_HOP_EXTRA_TIME_NTSC = 5 ; 5 5 5
VGSAGE_JUMP_SQUAT_DURATION_PAL = 4 ; 4 4 4
VGSAGE_JUMP_SQUAT_DURATION_NTSC = 5 ; 5 5 5
VGSAGE_LANDING_MAX_VELOCITY = $0200 ; 200 200 200
VGSAGE_MAX_NUM_AERIAL_JUMPS = 1 ; 1 1 1
VGSAGE_MAX_WALLJUMPS = 1 ; 1 1 1
VGSAGE_RUNNING_INITIAL_VELOCITY = $0280 ; 100 100 100
VGSAGE_RUNNING_MAX_VELOCITY = $0120 ; 200 180 180
VGSAGE_RUNNING_ACCELERATION = $10 ; 40 40 40
VGSAGE_TECH_SPEED = $0380 ; 400 400 400
VGSAGE_WALL_JUMP_SQUAT_END = 4 ; 4 4 4
VGSAGE_WALL_JUMP_VELOCITY_V = $0480 ; 480 480 3c0
VGSAGE_WALL_JUMP_VELOCITY_H = $0100 ; 100 100 80

;
; Constants data
;

!include "characters/std_constant_tables.asm"

;
; Implementation
;

vgsage_init:
vgsage_global_onground:
.(
	; Initialize walljump counter
	lda #VGSAGE_MAX_WALLJUMPS
	sta player_a_walljump, x
	rts
.)

; Input table for aerial moves, special values are
;  fast_fall - mandatorily on INPUT_NONE to take effect on release of DOWN
;  jump      - automatically choose between aerial jump or wall jump
;  no_input  - expected default
!define "VGSAGE_AERIAL_INPUTS_TABLE" {
	.(
		controller_inputs:
		.byt CONTROLLER_INPUT_NONE,               CONTROLLER_INPUT_SPECIAL_RIGHT
		.byt CONTROLLER_INPUT_SPECIAL_LEFT,       CONTROLLER_INPUT_JUMP
		.byt CONTROLLER_INPUT_JUMP_RIGHT,         CONTROLLER_INPUT_JUMP_LEFT
		.byt CONTROLLER_INPUT_ATTACK_LEFT,        CONTROLLER_INPUT_ATTACK_RIGHT
		.byt CONTROLLER_INPUT_DOWN_TILT,          CONTROLLER_INPUT_ATTACK_UP
		.byt CONTROLLER_INPUT_JAB,                CONTROLLER_INPUT_SPECIAL
		.byt CONTROLLER_INPUT_SPECIAL_UP,         CONTROLLER_INPUT_SPECIAL_DOWN
		.byt CONTROLLER_INPUT_ATTACK_UP_RIGHT,    CONTROLLER_INPUT_ATTACK_UP_LEFT
		.byt CONTROLLER_INPUT_SPECIAL_UP_RIGHT,   CONTROLLER_INPUT_SPECIAL_UP_LEFT
		.byt CONTROLLER_INPUT_ATTACK_DOWN_RIGHT,  CONTROLLER_INPUT_ATTACK_DOWN_LEFT
		.byt CONTROLLER_INPUT_SPECIAL_DOWN_RIGHT, CONTROLLER_INPUT_SPECIAL_DOWN_LEFT
		controller_callbacks_lo:
		.byt <fast_fall,                   <vgsage_start_side_special
		.byt <vgsage_start_side_special,   <jump
		.byt <jump,                        <jump
		.byt <vgsage_start_aerial_side,    <vgsage_start_aerial_side
		.byt <vgsage_start_aerial_down,    <vgsage_start_aerial_up
		.byt <vgsage_start_aerial_neutral, <vgsage_start_aerial_spe
		.byt <vgsage_start_spe_up,         <vgsage_start_spe_down
		.byt <vgsage_start_aerial_up,      <vgsage_start_aerial_up
		.byt <vgsage_start_spe_up,         <vgsage_start_spe_up
		.byt <vgsage_start_aerial_down,    <vgsage_start_aerial_down
		.byt <vgsage_start_spe_down,       <vgsage_start_spe_down
		controller_callbacks_hi:
		.byt >fast_fall,                   >vgsage_start_side_special
		.byt >vgsage_start_side_special,   >jump
		.byt >jump,                        >jump
		.byt >vgsage_start_aerial_side,    >vgsage_start_aerial_side
		.byt >vgsage_start_aerial_down,    >vgsage_start_aerial_up
		.byt >vgsage_start_aerial_neutral, >vgsage_start_aerial_spe
		.byt >vgsage_start_spe_up,         >vgsage_start_spe_down
		.byt >vgsage_start_aerial_up,      >vgsage_start_aerial_up
		.byt >vgsage_start_spe_up,         >vgsage_start_spe_up
		.byt >vgsage_start_aerial_down,    >vgsage_start_aerial_down
		.byt >vgsage_start_spe_down,       >vgsage_start_spe_down
		controller_default_callback:
		.word no_input
		&INPUT_TABLE_LENGTH = controller_callbacks_lo - controller_inputs
	.)
}

; Input table for idle state, special values are
;  input_idle_jump_left - Force LEFT direction and jump
;  input_idle_jump_right - Force RIGHT direction and jump
;  input_idle_tilt_left - Left tilt
;  input_idle_tilt_right - Right tilt
;  input_idle_left - Run to the left
;  input_idle_right - Run to the right
;  no_input - Default
!define "VGSAGE_IDLE_INPUTS_TABLE" {
	.(
		controller_inputs:
		.byt CONTROLLER_INPUT_LEFT,              CONTROLLER_INPUT_RIGHT
		.byt CONTROLLER_INPUT_JUMP,              CONTROLLER_INPUT_JUMP_RIGHT
		.byt CONTROLLER_INPUT_JUMP_LEFT,         CONTROLLER_INPUT_JAB
		.byt CONTROLLER_INPUT_ATTACK_LEFT,       CONTROLLER_INPUT_ATTACK_RIGHT
		.byt CONTROLLER_INPUT_SPECIAL,           CONTROLLER_INPUT_SPECIAL_RIGHT
		.byt CONTROLLER_INPUT_SPECIAL_LEFT,      CONTROLLER_INPUT_DOWN_TILT
		.byt CONTROLLER_INPUT_SPECIAL_UP,        CONTROLLER_INPUT_SPECIAL_DOWN
		.byt CONTROLLER_INPUT_ATTACK_UP,         CONTROLLER_INPUT_TECH
		.byt CONTROLLER_INPUT_TECH_LEFT,         CONTROLLER_INPUT_TECH_RIGHT
		.byt CONTROLLER_INPUT_SPECIAL_UP_LEFT,   CONTROLLER_INPUT_SPECIAL_UP_RIGHT
		.byt CONTROLLER_INPUT_ATTACK_UP_LEFT,    CONTROLLER_INPUT_ATTACK_UP_RIGHT
		.byt CONTROLLER_INPUT_SPECIAL_DOWN_LEFT, CONTROLLER_INPUT_SPECIAL_DOWN_RIGHT
		.byt CONTROLLER_INPUT_ATTACK_DOWN_LEFT,  CONTROLLER_INPUT_ATTACK_DOWN_RIGHT
		controller_callbacks_lo:
		.byt <input_idle_left,                <input_idle_right
		.byt <vgsage_start_jumping,           <input_idle_jump_right
		.byt <input_idle_jump_left,           <vgsage_start_jabbing
		.byt <input_idle_tilt_left,           <input_idle_tilt_right
		.byt <vgsage_start_special,           <vgsage_start_side_special_right
		.byt <vgsage_start_side_special_left, <vgsage_start_down_tilt
		.byt <vgsage_start_spe_up,            <vgsage_start_spe_down
		.byt <vgsage_start_up_tilt,           <vgsage_start_shielding
		.byt <vgsage_start_shielding,         <vgsage_start_shielding
		.byt <vgsage_start_spe_up,            <vgsage_start_spe_up
		.byt <vgsage_start_up_tilt,           <vgsage_start_up_tilt
		.byt <vgsage_start_spe_down,          <vgsage_start_spe_down
		.byt <vgsage_start_down_tilt,         <vgsage_start_down_tilt
		controller_callbacks_hi:
		.byt >input_idle_left,                >input_idle_right
		.byt >vgsage_start_jumping,           >input_idle_jump_right
		.byt >input_idle_jump_left,           >vgsage_start_jabbing
		.byt >input_idle_tilt_left,           >input_idle_tilt_right
		.byt >vgsage_start_special,           >vgsage_start_side_special_right
		.byt >vgsage_start_side_special_left, >vgsage_start_down_tilt
		.byt >vgsage_start_spe_up,            >vgsage_start_spe_down
		.byt >vgsage_start_up_tilt,           >vgsage_start_shielding
		.byt >vgsage_start_shielding,         >vgsage_start_shielding
		.byt >vgsage_start_spe_up,            >vgsage_start_spe_up
		.byt >vgsage_start_up_tilt,           >vgsage_start_up_tilt
		.byt >vgsage_start_spe_down,          >vgsage_start_spe_down
		.byt >vgsage_start_down_tilt,         >vgsage_start_down_tilt
		controller_default_callback:
		.word no_input
		&INPUT_TABLE_LENGTH = controller_callbacks_lo - controller_inputs
	.)
}

; Input table for running state, special values are
;  input_running_left - Change running direction to the left (if not already running to the left)
;  input_runnning_right - Change running direction to the right (if not already running to the right)
!define "VGSAGE_RUNNING_INPUTS_TABLE" {
	.(
		controller_inputs:
		.byt CONTROLLER_INPUT_LEFT,              CONTROLLER_INPUT_RIGHT
		.byt CONTROLLER_INPUT_JUMP,              CONTROLLER_INPUT_JUMP_RIGHT
		.byt CONTROLLER_INPUT_JUMP_LEFT,         CONTROLLER_INPUT_ATTACK_LEFT
		.byt CONTROLLER_INPUT_ATTACK_RIGHT,      CONTROLLER_INPUT_SPECIAL
		.byt CONTROLLER_INPUT_SPECIAL_RIGHT,     CONTROLLER_INPUT_SPECIAL_LEFT
		.byt CONTROLLER_INPUT_SPECIAL_UP,        CONTROLLER_INPUT_SPECIAL_DOWN
		.byt CONTROLLER_INPUT_TECH_LEFT,         CONTROLLER_INPUT_TECH_RIGHT
		.byt CONTROLLER_INPUT_SPECIAL_UP_LEFT,   CONTROLLER_INPUT_SPECIAL_UP_RIGHT
		.byt CONTROLLER_INPUT_ATTACK_UP_LEFT,    CONTROLLER_INPUT_ATTACK_UP_RIGHT
		.byt CONTROLLER_INPUT_SPECIAL_DOWN_LEFT, CONTROLLER_INPUT_SPECIAL_DOWN_RIGHT
		.byt CONTROLLER_INPUT_ATTACK_DOWN_LEFT,  CONTROLLER_INPUT_ATTACK_DOWN_RIGHT
		.byt CONTROLLER_INPUT_DOWN_TILT
		controller_callbacks_lo:
		.byt <input_running_left,           <input_running_right
		.byt <vgsage_start_jumping,         <vgsage_start_jumping
		.byt <vgsage_start_jumping,         <vgsage_start_side_tilt_left
		.byt <vgsage_start_side_tilt_right, <vgsage_start_special
		.byt <vgsage_start_side_special,    <vgsage_start_side_special
		.byt <vgsage_start_spe_up,          <vgsage_start_spe_down
		.byt <vgsage_start_shielding,       <vgsage_start_shielding
		.byt <vgsage_start_spe_up,          <vgsage_start_spe_up
		.byt <vgsage_start_up_tilt,         <vgsage_start_up_tilt
		.byt <vgsage_start_spe_down,        <vgsage_start_spe_down
		.byt <vgsage_start_down_tilt,       <vgsage_start_down_tilt
		.byt <vgsage_start_down_tilt
		controller_callbacks_hi:
		.byt >input_running_left,           >input_running_right
		.byt >vgsage_start_jumping,         >vgsage_start_jumping
		.byt >vgsage_start_jumping,         >vgsage_start_side_tilt_left
		.byt >vgsage_start_side_tilt_right, >vgsage_start_special
		.byt >vgsage_start_side_special,    >vgsage_start_side_special
		.byt >vgsage_start_spe_up,          >vgsage_start_spe_down
		.byt >vgsage_start_shielding,       >vgsage_start_shielding
		.byt >vgsage_start_spe_up,          >vgsage_start_spe_up
		.byt >vgsage_start_up_tilt,         >vgsage_start_up_tilt
		.byt >vgsage_start_spe_down,        >vgsage_start_spe_down
		.byt >vgsage_start_down_tilt,       >vgsage_start_down_tilt
		.byt >vgsage_start_down_tilt
		controller_default_callback:
		.word vgsage_start_idle
		&INPUT_TABLE_LENGTH = controller_callbacks_lo - controller_inputs
	.)
}

; Input table for jumping state state (only used during jumpsquat), special values are
;  no_input - default
!define "VGSAGE_JUMPSQUAT_INPUTS_TABLE" {
	.(
		controller_inputs:
		.byt CONTROLLER_INPUT_ATTACK_UP,       CONTROLLER_INPUT_SPECIAL_UP
		.byt CONTROLLER_INPUT_ATTACK_UP_LEFT,  CONTROLLER_INPUT_SPECIAL_UP_LEFT
		.byt CONTROLLER_INPUT_ATTACK_UP_RIGHT, CONTROLLER_INPUT_SPECIAL_UP_RIGHT
		controller_callbacks_lo:
		.byt <vgsage_start_up_tilt, <vgsage_start_spe_up
		.byt <vgsage_start_up_tilt, <vgsage_start_spe_up
		.byt <vgsage_start_up_tilt, <vgsage_start_spe_up
		controller_callbacks_hi:
		.byt >vgsage_start_up_tilt, >vgsage_start_spe_up
		.byt >vgsage_start_up_tilt, >vgsage_start_spe_up
		.byt >vgsage_start_up_tilt, >vgsage_start_spe_up
		controller_default_callback:
		.word no_input
		&INPUT_TABLE_LENGTH = controller_callbacks_lo - controller_inputs
	.)
}

!include "characters/std_aerial_input.asm"
!include "characters/std_crashing.asm"
!include "characters/std_thrown.asm"
!include "characters/std_respawn.asm"
!include "characters/std_innexistant.asm"
!include "characters/std_spawn.asm"
!include "characters/std_idle.asm"
!include "characters/std_running.asm"
!include "characters/std_jumping.asm"
!include "characters/std_landing.asm"
!include "characters/std_helpless.asm"
!include "characters/std_shielding.asm"
!include "characters/std_walljumping.asm"

;
; Jab
;

.(
	+vgsage_start_jabbing:
	.(
		;TODO
		rts
	.)

	+vgsage_tick_jabbing:
	.(
		;TODO
		rts
	.)
.)

;
; Up tilt
;

!define "anim" {vgsage_anim_up_tilt}
!define "state" {VGSAGE_STATE_UP_TILT}
!define "routine" {up_tilt}
!include "characters/tpl_grounded_attack.asm"

;
; Down tilt
;

!define "anim" {vgsage_anim_down_tilt}
!define "state" {VGSAGE_STATE_DOWN_TILT}
!define "routine" {down_tilt}
!include "characters/tpl_grounded_attack.asm"

;
; Side tilt
;

.(
	+vgsage_start_side_tilt_left:
	.(
		lda DIRECTION_LEFT
		sta player_a_direction, x
		jmp vgsage_start_side_tilt
		;rts ; useless, jump to subroutine
	.)

	+vgsage_start_side_tilt_right:
	.(
		lda DIRECTION_RIGHT
		sta player_a_direction, x
		;jmp vgsage_start_side_tilt ; useless, falltrhough
		;rts ; useless, jump to subroutine
	.)

	+vgsage_start_side_tilt:
	.(
		;TODO
		rts
	.)

	+vgsage_tick_side_tilt:
	.(
		;TODO
		rts
	.)
.)

;
; Aerial neutral
;

!define "anim" {vgsage_anim_aerial_neutral}
!define "state" {VGSAGE_STATE_AERIAL_NEUTRAL}
!define "routine" {aerial_neutral}
!include "characters/tpl_aerial_attack.asm"

;
; Aerial up
;

!define "anim" {vgsage_anim_aerial_up}
!define "state" {VGSAGE_STATE_AERIAL_UP}
!define "routine" {aerial_up}
!include "characters/tpl_aerial_attack.asm"

;
; Aerial down
;

!define "anim" {vgsage_anim_aerial_down}
!define "state" {VGSAGE_STATE_AERIAL_DOWN}
!define "routine" {aerial_down}
!include "characters/tpl_aerial_attack.asm"

;
; Aerial side
;

!define "anim" {vgsage_anim_aerial_side}
!define "state" {VGSAGE_STATE_AERIAL_SIDE}
!define "routine" {aerial_side}
!include "characters/tpl_aerial_attack.asm"

;
; Grounded neutral special
;

.(
	; Step - charge
	!define "anim" {vgsage_anim_special}
	!define "state" {VGSAGE_STATE_SPECIAL_NEUTRAL_STEP_0}
	!define "routine" {special}
	;almost like "characters/tpl_aerial_attack_uncancellable.asm" (just need a custom exit routine, and custom duration, and sfx)
	.(
		duration:
			.byt {anim}_dur_pal*2, {anim}_dur_ntsc*2

		+{char_name}_start_{routine}:
		.(
			; Set state
			lda #{state}
			sta player_a_state, x

			; Reset clock
			ldy system_index
			lda duration, y
			sta player_a_state_clock, x

			; Play sfx
			jsr audio_play_land

			; Set the appropriate animation
			lda #<{anim}
			sta tmpfield13
			lda #>{anim}
			sta tmpfield14
			jmp set_player_animation

			;rts ; useless, jump to subroutine
		.)

		+{char_name}_tick_{routine}:
		.(
#ifldef {char_name}_global_tick
			jsr {char_name}_global_tick
#endif

			jsr {char_name}_apply_friction_lite

			; Play the sfx a second time mid-animation
			ldy system_index
			lda duration, y
			lsr
			cmp player_a_state_clock, x
			;;lda player_a_state_clock, x
			;;and #%00000011

			bne sfx_ok
				jsr audio_play_land
			sfx_ok:

			dec player_a_state_clock, x
			bne end
				jmp {char_name}_start_special_fadeout
				; No return, jump to subroutine
			end:
			rts
		.)
	.)
	!undef "anim"
	!undef "state"
	!undef "routine"

	; Step - fadeout
	.(
		+vgsage_start_special_fadeout:
		.(
			lda #VGSAGE_STATE_SPECIAL_NEUTRAL_STEP_1
			sta player_a_state, x

			; Set the appropriate animation
			lda #<vgsage_anim_side_special_jump
			sta tmpfield13
			lda #>vgsage_anim_side_special_jump
			sta tmpfield14
			jsr set_player_animation

			; Stop any momentum
			lda #0
			sta player_a_velocity_v, x
			sta player_a_velocity_h, x
			sta player_a_velocity_v_low, x
			sta player_a_velocity_h_low, x

			; Set clock
			lda #3*2
			sta player_a_state_clock, x

			; Entering state's sound effect
			stx player_number
			ldx #SFX_COUNTDOWN_REACH_IDX
			jsr audio_play_sfx_from_list
			ldx player_number

			rts
		.)

		+vgsage_tick_special_fadeout:
		.(
			; Every four ticks, advance one step of the fadeout
			.(
				lda player_a_state_clock, x
				and #%00000001
				bne ok

					; Set pallettes to current fadaout step
					stx player_number

					lda player_a_state_clock, x
					lsr
					lsr
					tax

					ldy config_selected_stage
					TRAMPOLINE_POINTED(stage_routine_fadeout_lsb COMMA y, stage_routine_fadeout_msb COMMA y, stages_bank COMMA y, #CURRENT_BANK_NUMBER)

					ldx player_number

				ok:
			.)

			; Tick clock
			dec player_a_state_clock, x
			bpl end
				jmp vgsage_start_special_draw_warrior
				;No return

			end:
			rts
		.)
	.)

	; Step - draw warrior
	.(
		&vgsage_start_special_draw_warrior:
		.(
			lda #VGSAGE_STATE_SPECIAL_NEUTRAL_STEP_2
			sta player_a_state, x

			lda #5
			sta player_a_state_clock, x

			rts
		.)

		+vgsage_tick_special_draw_warrior:
		.(
			stx player_number

			ldy player_a_state_clock, x

			lda illustration_header_lsb, y
			sta tmpfield1
			lda illustration_header_msb, y
			sta tmpfield2
			lda illustration_lsb, y
			sta tmpfield3
			lda illustration_msb, y
			sta tmpfield4
			jsr construct_nt_buffer

			ldx player_number

			dec player_a_state_clock, x
			bpl end
				jmp vgsage_start_special_show_warrior
				; No return, jump to subroutine

			end:
			rts

#define ATT(br,bl,tr,tl) ((br << 6) + (bl << 4) + (tr << 2) + tl)
			illustration_palette:
			.byt $0f,$0f,$0f,$0f, $0f,$03,$03,$13, $0f,$32,$32,$20, $0f,$20,$20,$20
			; more opaque version
			;.byt $0f,$0f,$0f,$0f, $0f,$03,$03,$03, $0f,$32,$32,$32, $0f,$20,$20,$20
			; lighter version, seeing more of the stage, less of the illustration
			;.byt $0f,$21,$00,$10, $0f,$03,$03,$13, $0f,$32,$32,$20, $0f,$20,$20,$20
			illustration_palette_fadein_1:
			.byt $0f,$0f,$0f,$0f, $0f,$03,$03,$13, $0f,$22,$22,$32, $0f,$10,$10,$20
			illustration_palette_fadein_2:
			.byt $0f,$0f,$0f,$0f, $0f,$03,$0f,$03, $0f,$12,$12,$22, $0f,$00,$00,$10
			illustration_palette_fadein_3:
			.byt $0f,$0f,$0f,$0f, $0f,$0f,$0f,$0f, $0f,$02,$02,$0f, $0f,$0f,$0f,$00
			illustration_top:
			.byt ATT(0,0,1,1), ATT(1,0,0,0), ATT(2,2,1,1), ATT(2,2,1,1), ATT(0,1,0,0), ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0)
			.byt ATT(0,0,0,0), ATT(2,1,2,1), ATT(2,2,2,2), ATT(2,1,3,1), ATT(3,3,1,3), ATT(1,2,0,1), ATT(0,0,0,0), ATT(0,0,0,0)
			.byt ATT(1,0,1,0), ATT(2,2,2,2), ATT(2,2,2,2), ATT(2,2,1,2), ATT(2,1,3,2), ATT(3,3,2,3), ATT(1,3,0,1), ATT(0,0,0,0)
			.byt ATT(2,1,2,1), ATT(2,2,2,2), ATT(2,2,2,2), ATT(2,2,2,2), ATT(2,2,2,1), ATT(3,2,3,2), ATT(3,3,3,3), ATT(1,2,0,1)
			illustration_bot:
			.byt ATT(1,0,2,1), ATT(1,2,0,1), ATT(0,0,0,0), ATT(3,3,2,0), ATT(0,0,2,2), ATT(3,3,0,0), ATT(1,0,0,0), ATT(1,2,1,1)
			.byt ATT(0,0,0,0), ATT(1,0,2,1), ATT(2,2,0,2), ATT(1,2,0,0), ATT(0,0,0,0), ATT(2,1,0,0), ATT(1,2,2,2), ATT(0,0,0,1)
			.byt ATT(1,1,0,0), ATT(0,0,0,0), ATT(0,0,1,1), ATT(1,0,2,1), ATT(1,1,2,2), ATT(0,1,1,2), ATT(0,0,0,1), ATT(0,0,0,0)
			.byt ATT(2,2,2,2), ATT(2,2,1,1), ATT(1,1,0,0), ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0), ATT(1,0,0,0), ATT(2,2,1,1)
#undef ATT
			illustration_lsb:
			.byt <illustration_palette
			.byt <illustration_palette_fadein_1, <illustration_palette_fadein_2, <illustration_palette_fadein_3
			.byt <illustration_top, <illustration_bot
			illustration_msb:
			.byt >illustration_palette
			.byt >illustration_palette_fadein_1, >illustration_palette_fadein_2, >illustration_palette_fadein_3
			.byt >illustration_top, >illustration_bot

			illustration_palette_header:
			.byt $3f, $00, $10
			illustration_top_header:
			.byt $23, $c0, $20
			illustration_bot_header:
			.byt $23, $e0, $20

			illustration_header_lsb:
			.byt <illustration_palette_header
			.byt <illustration_palette_header, <illustration_palette_header, <illustration_palette_header
			.byt <illustration_top_header, <illustration_bot_header
			illustration_header_msb:
			.byt >illustration_palette_header
			.byt >illustration_palette_header, >illustration_palette_header, >illustration_palette_header
			.byt >illustration_top_header, >illustration_bot_header
		.)
	.)

	; Step - wait a bit to show the warrior
	.(
		&vgsage_start_special_show_warrior:
		.(
			lda #VGSAGE_STATE_SPECIAL_NEUTRAL_STEP_3
			sta player_a_state, x

			lda #25 ;TODO ntsc
			sta player_a_state_clock, x

			jmp audio_play_title_screen_subtitle

			;rts
		.)

		+vgsage_tick_special_show_warrior:
		.(
			dec player_a_state_clock, x
			bne end
				jmp vgsage_start_special_draw_slash
			end:
			rts
		.)
	.)

	; Step - Slash animation
	.(
		&vgsage_start_special_draw_slash:
		.(
			lda #VGSAGE_STATE_SPECIAL_NEUTRAL_STEP_4
			sta player_a_state, x

			lda #(NUM_ANIM_STEPS-1)*2
			sta player_a_state_clock, x

			jmp audio_play_parry

			;rts ; Useless, jump to subroutine
		.)

		+vgsage_tick_special_draw_slash:
		.(
			; Step the animation
			.(
				lda player_a_state_clock, x
				and #%00000001
				bne ok

					stx player_number

					lda player_a_state_clock, x
					lsr
					tay

					lda anim_headers_lsb, y
					cmp #NOOP
					beq skip

						sta tmpfield1
						lda anim_headers_msb, y
						sta tmpfield2
						lda anim_frames_lsb, y
						sta tmpfield3
						lda anim_frames_msb, y
						sta tmpfield4
						jsr construct_nt_buffer

					skip:
					ldx player_number

				ok:
			.)

			; Tick clock
			dec player_a_state_clock, x
			bpl end
				jmp vgsage_start_restore_screen
				; No return, jump to subroutine

			end:
			rts

#define ATT(br,bl,tr,tl) ((br << 6) + (bl << 4) + (tr << 2) + tl)
			anim_1: ;bottom
			.byt ATT(1,0,2,1), ATT(1,2,0,1), ATT(0,0,0,0), ATT(3,3,2,0), ATT(0,0,2,2), ATT(3,3,0,0), ATT(1,0,0,0), ATT(1,2,1,1)
			.byt ATT(0,0,0,0), ATT(1,0,2,1), ATT(2,2,0,2), ATT(1,2,0,0), ATT(0,0,0,0), ATT(2,1,0,0), ATT(1,2,2,2), ATT(0,0,0,1)
			.byt ATT(1,1,0,0), ATT(0,0,0,0), ATT(3,3,3,3), ATT(3,3,3,3), ATT(1,1,2,2), ATT(0,1,1,2), ATT(0,0,0,1), ATT(0,0,0,0)
			.byt ATT(2,2,2,2), ATT(3,3,3,3), ATT(3,3,3,3), ATT(3,3,3,3), ATT(0,0,0,0), ATT(0,0,0,0), ATT(1,0,0,0), ATT(2,2,1,1)
			anim_2: ;bottom
			.byt ATT(1,0,2,1), ATT(1,2,0,1), ATT(0,0,0,0), ATT(3,3,2,0), ATT(3,3,3,3), ATT(3,3,3,3), ATT(3,3,3,3), ATT(1,2,1,1)
			.byt ATT(0,0,0,0), ATT(1,0,2,1), ATT(2,2,0,2), ATT(3,3,3,3), ATT(3,3,3,3), ATT(3,3,3,3), ATT(1,2,2,2), ATT(0,0,0,1)
			.byt ATT(1,1,0,0), ATT(0,0,0,0), ATT(3,3,3,3), ATT(3,3,3,3), ATT(3,3,3,3), ATT(0,1,1,2), ATT(0,0,0,1), ATT(0,0,0,0)
			.byt ATT(2,2,2,2), ATT(3,3,3,3), ATT(3,3,3,3), ATT(3,3,3,3), ATT(0,0,0,0), ATT(0,0,0,0), ATT(1,0,0,0), ATT(2,2,1,1)
			anim_3: ;top
			.byt ATT(0,0,1,1), ATT(1,0,0,0), ATT(2,2,1,1), ATT(2,2,1,1), ATT(0,1,0,0), ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0)
			.byt ATT(0,0,0,0), ATT(2,1,2,1), ATT(2,2,2,2), ATT(2,1,3,1), ATT(3,3,1,3), ATT(1,2,0,1), ATT(0,0,0,0), ATT(3,3,3,3)
			.byt ATT(1,0,1,0), ATT(2,2,2,2), ATT(2,2,2,2), ATT(2,2,1,2), ATT(2,1,3,2), ATT(3,3,2,3), ATT(3,3,3,3), ATT(3,3,3,3)
			.byt ATT(2,1,2,1), ATT(2,2,2,2), ATT(2,2,2,2), ATT(2,2,2,2), ATT(2,2,2,1), ATT(3,3,3,3), ATT(3,3,3,3), ATT(3,3,3,3)
			anim_4: ;bottom
			.byt ATT(1,0,2,1), ATT(1,2,0,1), ATT(3,3,3,3), ATT(3,3,3,3), ATT(3,3,3,3), ATT(3,3,3,3), ATT(3,3,3,3), ATT(3,3,3,3)
			.byt ATT(0,0,0,0), ATT(3,3,3,3), ATT(3,3,3,3), ATT(3,3,3,3), ATT(3,3,3,3), ATT(3,3,3,3), ATT(3,3,3,3), ATT(3,3,3,3)
			.byt ATT(3,3,3,3), ATT(3,3,3,3), ATT(3,3,3,3), ATT(3,3,3,3), ATT(3,3,3,3), ATT(3,3,3,3), ATT(3,3,3,3), ATT(0,0,0,0)
			.byt ATT(3,3,3,3), ATT(3,3,3,3), ATT(3,3,3,3), ATT(3,3,3,3), ATT(3,3,3,3), ATT(3,3,3,3), ATT(1,0,0,0), ATT(2,2,1,1)
			anim_5: ;top
			.byt ATT(0,0,1,1), ATT(1,0,0,0), ATT(2,2,1,1), ATT(2,2,1,1), ATT(0,1,0,0), ATT(0,0,0,0), ATT(3,3,3,3), ATT(3,3,3,3)
			.byt ATT(0,0,0,0), ATT(2,1,2,1), ATT(2,2,2,2), ATT(2,1,3,1), ATT(3,3,1,3), ATT(3,3,3,3), ATT(3,3,3,3), ATT(3,3,3,3)
			.byt ATT(1,0,1,0), ATT(2,2,2,2), ATT(2,2,2,2), ATT(2,2,1,2), ATT(3,3,3,3), ATT(3,3,3,3), ATT(3,3,3,3), ATT(3,3,3,3)
			.byt ATT(2,1,2,1), ATT(2,2,2,2), ATT(2,2,2,2), ATT(3,3,3,3), ATT(3,3,3,3), ATT(3,3,3,3), ATT(3,3,3,3), ATT(3,3,3,3)
			anim_6: ;bottom
			.byt ATT(1,0,2,1), ATT(1,2,0,1), ATT(0,0,0,0), ATT(3,3,2,0), ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0), ATT(1,2,1,1)
			.byt ATT(0,0,0,0), ATT(1,0,2,1), ATT(2,2,0,2), ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0), ATT(1,2,2,2), ATT(0,0,0,1)
			.byt ATT(1,1,0,0), ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,1,1,2), ATT(0,0,0,1), ATT(0,0,0,0)
			.byt ATT(2,2,2,2), ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0), ATT(1,0,0,0), ATT(2,2,1,1)
			anim_7: ;top
			.byt ATT(0,0,1,1), ATT(1,0,0,0), ATT(2,2,1,1), ATT(2,2,1,1), ATT(0,1,0,0), ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0)
			.byt ATT(0,0,0,0), ATT(2,1,2,1), ATT(2,2,2,2), ATT(2,1,3,1), ATT(3,3,1,3), ATT(1,2,0,1), ATT(0,0,0,0), ATT(0,0,0,0)
			.byt ATT(1,0,1,0), ATT(2,2,2,2), ATT(2,2,2,2), ATT(2,2,1,2), ATT(2,1,3,2), ATT(3,3,2,3), ATT(0,0,0,0), ATT(0,0,0,0)
			.byt ATT(2,1,2,1), ATT(2,2,2,2), ATT(2,2,2,2), ATT(2,2,2,2), ATT(2,2,2,1), ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0)
#undef ATT
			NOOP = 255
			anim_frames_lsb:
			.byt <anim_7, <anim_6, NOOP, <anim_3, <anim_2, <anim_1, <anim_5, <anim_4
			anim_frames_msb:
			.byt >anim_7, >anim_6, NOOP, >anim_3, >anim_2, >anim_1, >anim_5, >anim_4

			top_header:
			.byt $23, $c0, $20
			bot_header:
			.byt $23, $e0, $20

			anim_headers_lsb:
			.byt <top_header, <bot_header, NOOP, <top_header, <bot_header, <bot_header, <top_header, <bot_header
			anim_headers_msb:
			.byt >top_header, >bot_header, NOOP, >top_header, >bot_header, >bot_header, >top_header, >bot_header

			&NUM_ANIM_STEPS = anim_headers_msb - anim_headers_lsb
		.)
	.)

	; Step - Restore screen
	;TODO investigate - may not deserve its own state, if setting stage_restore_screen_step has no impact until next frame, it could be done at the end of knight animation step
	.(
		&vgsage_start_restore_screen:
		.(
			lda #VGSAGE_STATE_SPECIAL_NEUTRAL_STEP_5
			sta player_a_state, x
			rts
		.)

		+vgsage_tick_special_restore_screen:
		.(
			lda #0
			sta stage_restore_screen_step
			jmp resume_game
			;rts ; useless, jump to subroutine
		.)
	.)

	resume_game:
	.(
		; Hurt opponent
		;  optimisable - avoid hurt_player routine, call apply_force_vector_direct to not setup the hitbox just to read it in tmpfields
		;  could also be better to use a hitbox in the animation (just ensure it connects someway)
		lda #23
		sta player_a_hitbox_damages, x
		lda #0
		sta player_a_hitbox_force_h, x
		sta player_a_hitbox_force_h_low, x
		sta player_a_hitbox_force_v, x
		sta player_a_hitbox_force_v_low, x
		lda #<-2048
		sta player_a_hitbox_base_knock_up_v_low, x
		lda #>-2048
		sta player_a_hitbox_base_knock_up_v_high, x
		lda #<2048
		sta player_a_hitbox_base_knock_up_h_low, x
		lda #>2048
		sta player_a_hitbox_base_knock_up_h_high, x

		txa:pha
		stx tmpfield10
		SWITCH_SELECTED_PLAYER
		stx tmpfield11
		ldy config_player_a_character, x
		TRAMPOLINE(hurt_player, characters_bank_number COMMA y, #CURRENT_BANK_NUMBER)
		pla:tax

		; Come back to a playable state
		jmp vgsage_start_inactive_state

		;rts ; useless, jump to subroutine
	.)
.)

;
; Aerial neutral special
;

.(
	+vgsage_start_aerial_spe:
	.(
		;TODO
		rts
	.)
.)

;
; Up special
;

.(
	+vgsage_start_spe_up:
	.(
		;TODO
		rts
	.)
.)

;
; Down special
;

.(
	+vgsage_start_spe_down:
	.(
		;TODO
		rts
	.)
.)

;
; Side special
;

.(
	+vgsage_start_side_special_left:
	.(
		lda DIRECTION_LEFT
		sta player_a_direction, x
		jmp vgsage_start_side_special
		;rts ; useless, jump to subroutine
	.)

	+vgsage_start_side_special_right:
	.(
		lda DIRECTION_RIGHT
		sta player_a_direction, x
		;jmp vgsage_start_side_special ; useless, fallthrough
		; Falltrhough to vgsage_start_side_special
	.)

	+vgsage_start_side_special:
	.(
		;TODO
		rts
	.)
.)

!include "characters/std_friction_routines.asm"