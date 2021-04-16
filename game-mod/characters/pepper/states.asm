; Character code handling movment
;
; This code is the implementation of very common movement and reaction to hits. It leads to a character able to move around, but unable to attack.
;
; Animations needed:
;  pepper_anim_crash
;  pepper_anim_falling
;  pepper_anim_helpless
;  pepper_anim_idle
;  pepper_anim_jump
;  pepper_anim_landing
;  pepper_anim_respawn
;  pepper_anim_run
;  pepper_anim_spawn
;  pepper_anim_thrown
;
;  pepper_anim_aerial_jump can easily be introduced, see related TODO

PEPPER_STATE_THROWN = 0
PEPPER_STATE_RESPAWN = 1
PEPPER_STATE_INNEXISTANT = 2
PEPPER_STATE_SPAWN = 3
PEPPER_STATE_IDLE = 4
PEPPER_STATE_RUNNING = 5
PEPPER_STATE_FALLING = CUSTOM_PLAYER_STATES_BEGIN + 0
PEPPER_STATE_LANDING = CUSTOM_PLAYER_STATES_BEGIN + 1
PEPPER_STATE_CRASHING = CUSTOM_PLAYER_STATES_BEGIN + 2
PEPPER_STATE_HELPLESS = CUSTOM_PLAYER_STATES_BEGIN + 3
PEPPER_STATE_JUMPING = CUSTOM_PLAYER_STATES_BEGIN + 4
PEPPER_STATE_SHIELDING = CUSTOM_PLAYER_STATES_BEGIN + 5
PEPPER_STATE_SHIELDLAG = CUSTOM_PLAYER_STATES_BEGIN + 6
PEPPER_STATE_WALLJUMPING = CUSTOM_PLAYER_STATES_BEGIN + 7

PEPPER_MAX_NUM_AERIAL_JUMPS = 1
PEPPER_MAX_WALLJUMPS = 1
PEPPER_WALL_JUMP_SQUAT_END = 4
PEPPER_WALL_JUMP_VELOCITY_VERTICAL = $fb80
PEPPER_AIR_FRICTION_STRENGTH = 7
PEPPER_AERIAL_DIRECTIONAL_INFLUENCE_STRENGTH = $80
PEPPER_AERIAL_SPEED = $0100
PEPPER_FASTFALL_SPEED = $05
PEPPER_GROUND_FRICTION_STRENGTH = $40

pepper_a_num_walljumps = player_a_state_field3
pepper_b_num_walljumps = player_b_state_field3

pepper_init:
pepper_global_onground:
.(
	; Initialize walljump counter
	lda #PEPPER_MAX_WALLJUMPS
	sta pepper_a_num_walljumps, x
	rts
.)

pepper_aerial_directional_influence:
.(
	; merge_to_player_velocity parameter names
	merged_v_low = tmpfield1
	merged_v_high = tmpfield3
	merged_h_low = tmpfield2
	merged_h_high = tmpfield4
	merge_step = tmpfield5

	; Choose what to do depending on controller state
	lda controller_a_btns, x
	and #CONTROLLER_INPUT_LEFT
	bne go_left

	lda controller_a_btns, x
	and #CONTROLLER_INPUT_RIGHT
	bne go_right

	jmp air_friction

	go_left:
		; Go to the left
		lda #<-PEPPER_AERIAL_SPEED
		sta tmpfield6
		lda #>-PEPPER_AERIAL_SPEED
		sta tmpfield7
		lda player_a_velocity_h_low, x
		sta tmpfield8
		lda player_a_velocity_h, x
		sta tmpfield9
		jsr signed_cmp
		bpl end

		lda player_a_velocity_v_low, x
		sta merged_v_low
		lda player_a_velocity_v, x
		sta merged_v_high
		lda #<-PEPPER_AERIAL_SPEED
		sta merged_h_low
		lda #>-PEPPER_AERIAL_SPEED
		sta merged_h_high
		lda #PEPPER_AERIAL_DIRECTIONAL_INFLUENCE_STRENGTH
		sta merge_step
		jsr merge_to_player_velocity
		jmp end

	go_right:
		; Go to the right
		lda player_a_velocity_h_low, x
		sta tmpfield6
		lda player_a_velocity_h, x
		sta tmpfield7
		lda #<PEPPER_AERIAL_SPEED
		sta tmpfield8
		lda #>PEPPER_AERIAL_SPEED
		sta tmpfield9
		jsr signed_cmp
		bpl end

		lda player_a_velocity_v_low, x
		sta merged_v_low
		lda player_a_velocity_v, x
		sta merged_v_high
		lda #<PEPPER_AERIAL_SPEED
		sta merged_h_low
		lda #>PEPPER_AERIAL_SPEED
		sta merged_h_high
		lda #PEPPER_AERIAL_DIRECTIONAL_INFLUENCE_STRENGTH
		sta merge_step
		jsr merge_to_player_velocity
		jmp end

	air_friction:
		; Apply air friction
		lda player_a_velocity_v_low, x
		sta merged_v_low
		lda player_a_velocity_v, x
		sta merged_v_high
		lda #$00
		sta merged_h_low
		sta merged_h_high
		lda #PEPPER_AIR_FRICTION_STRENGTH
		sta merge_step
		jsr merge_to_player_velocity

	end:
	rts
.)

; Change the player's state if an aerial move is input on the controller
;  register X - Player number
;
;  Overwrites tmpfield15 and tmpfield2 plus the ones overriten by the state starting subroutine
pepper_check_aerial_inputs:
.(
	input_marker = tmpfield15
	player_btn = tmpfield2

	.(
		; Refuse to do anything if under hitstun
		lda player_a_hitstun, x
		bne end

		; Assuming we are called from an input event
		; Do nothing if the only changes concern the left-right buttons
		lda controller_a_btns, x
		eor controller_a_last_frame_btns, x
		and #CONTROLLER_BTN_A | CONTROLLER_BTN_B | CONTROLLER_BTN_UP | CONTROLLER_BTN_DOWN
		beq end

			; Save current direction
			lda player_a_direction, x
			pha

			; Change player's direction according to input direction
			lda controller_a_btns, x
			sta player_btn
			lda #CONTROLLER_BTN_LEFT
			bit player_btn
			beq check_direction_right
				lda DIRECTION_LEFT
				jmp set_direction
			check_direction_right:
				lda #CONTROLLER_BTN_RIGHT
				bit player_btn
				beq no_direction
				lda DIRECTION_RIGHT
			set_direction:
				sta player_a_direction, x
			no_direction:

			; Start the good state according to input
			jsr take_input

			; Restore player's direction if there was no input, else discard saved direction
			lda input_marker
			beq restore_direction
				pla
				jmp end
			restore_direction:
				pla
				sta player_a_direction, x

		end:
		rts
	.)

	take_input:
	.(
		; Mark input
		lda #01
		sta input_marker

		; Call aerial subroutines, in case of input it will return with input marked
		lda #<controller_inputs
		sta tmpfield1
		lda #>controller_inputs
		sta tmpfield2
		lda #14
		sta tmpfield3
		jmp controller_callbacks

		;rts ; useless, controller_callbacks returns to caller

		; Fast fall on release of CONTROLLER_INPUT_TECH, gravity * 1.5
		fast_fall:
		.(
			lda controller_a_last_frame_btns, x
			cmp #CONTROLLER_INPUT_TECH
			bne no_fast_fall
				lda #PEPPER_FASTFALL_SPEED
				sta player_a_gravity, x
				sta player_a_velocity_v, x
				lda #$00
				sta player_a_velocity_v_low, x
			no_fast_fall:
			rts
		.)

		; Jump, choose between aerial jump or wall jump
        jump:
        .(
			lda player_a_walled, x
			beq aerial_jump
			lda pepper_a_num_walljumps, x
			beq aerial_jump
				wall_jump:
					lda player_a_walled_direction, x
					sta player_a_direction, x
					jmp pepper_start_walljumping
				aerial_jump:
					jmp pepper_start_aerial_jumping
			;rts ; useless, both branches jump to subroutine
        .)

		; If no input, unmark the input flag and return
		no_input:
		.(
			lda #$00
			sta input_marker
			;rts ; Fallthrough to return
		.)

		end:
		rts

		; Impactful controller states and associated callbacks
		; Note - We have to put subroutines as callbacks since we do not expect a return unless we used the default callback
		; TODO callbacks set to no_input are to be implemented (except the default callback)
		controller_inputs:
		.byt CONTROLLER_INPUT_NONE,         CONTROLLER_INPUT_SPECIAL_RIGHT
		.byt CONTROLLER_INPUT_SPECIAL_LEFT, CONTROLLER_INPUT_JUMP
		.byt CONTROLLER_INPUT_JUMP_RIGHT,   CONTROLLER_INPUT_JUMP_LEFT
		.byt CONTROLLER_INPUT_ATTACK_LEFT,  CONTROLLER_INPUT_ATTACK_RIGHT
		.byt CONTROLLER_INPUT_DOWN_TILT,    CONTROLLER_INPUT_ATTACK_UP
		.byt CONTROLLER_INPUT_JAB,          CONTROLLER_INPUT_SPECIAL
		.byt CONTROLLER_INPUT_SPECIAL_UP,   CONTROLLER_INPUT_SPECIAL_DOWN
		controller_callbacks_lo:
		.byt <fast_fall, <no_input
		.byt <no_input,  <jump
		.byt <jump,      <jump
		.byt <no_input,  <no_input
		.byt <no_input,  <no_input
		.byt <no_input,  <no_input
		.byt <no_input,  <no_input
		controller_callbacks_hi:
		.byt >fast_fall, >no_input
		.byt >no_input,  >jump
		.byt >jump,      >jump
		.byt >no_input,  >no_input
		.byt >no_input,  >no_input
		.byt >no_input,  >no_input
		.byt >no_input,  >no_input
		controller_default_callback:
		.word no_input
	.)
.)

pepper_start_thrown:
.(
	; Set the player's state
	lda #PEPPER_STATE_THROWN
	sta player_a_state, x

	; Initialize tech counter
	lda #0
	sta player_a_state_field1, x

	; Set the appropriate animation
	lda #<pepper_anim_thrown
	sta tmpfield13
	lda #>pepper_anim_thrown
	sta tmpfield14
	jsr set_player_animation

	; Set the appropriate animation direction (depending on player's velocity)
	lda player_a_velocity_h, x
	bmi set_anim_left
		lda DIRECTION_RIGHT
		jmp set_anim_dir
	set_anim_left:
		lda DIRECTION_LEFT
	set_anim_dir:
		ldy #ANIMATION_STATE_OFFSET_DIRECTION
		sta (tmpfield11), y

	rts
.)

pepper_tick_thrown:
.(
	; Update velocity
	lda player_a_hitstun, x
	bne gravity
		jsr pepper_aerial_directional_influence
	gravity:
	jsr apply_player_gravity

	; Decrement tech counter (to zero minimum)
	lda player_a_state_field1, x
	beq end_dec_tech_cnt
		dec player_a_state_field1, x
	end_dec_tech_cnt:

	rts
.)

pepper_input_thrown:
.(
	; Handle controller inputs
	lda #<(input_table+1)
	sta tmpfield1
	lda #>(input_table+1)
	sta tmpfield2
	lda input_table
	sta tmpfield3
	jmp controller_callbacks

	; If a tech is entered, store it's direction in state_field2
	; and if the counter is at 0, reset it to it's max value.
	tech_neutral:
		lda #$00
		jmp tech_common
	tech_right:
		lda #$01
		jmp tech_common
	tech_left:
		lda #$02
	tech_common:
		sta player_a_state_field2, x
		lda player_a_state_field1, x
		bne end
		lda #TECH_MAX_FRAMES_BEFORE_COLLISION+TECH_NB_FORBIDDEN_FRAMES
		sta player_a_state_field1, x

	no_tech:
		jsr pepper_check_aerial_inputs

	end:
	rts

	; Impactful controller states and associated callbacks
	input_table:
	.(
		table_length:
		.byt 3
		controller_inputs:
		.byt CONTROLLER_INPUT_TECH,        CONTROLLER_INPUT_TECH_RIGHT,   CONTROLLER_INPUT_TECH_LEFT
		controller_callbacks_lo:
		.byt <tech_neutral,                <tech_right,                   <tech_left
		controller_callbacks_hi:
		.byt >tech_neutral,                >tech_right,                   >tech_left
		controller_default_callback:
		.word no_tech
	.)
.)

pepper_onground_thrown:
.(
	;jsr pepper_global_onground ; useless, will be done by start_landing or start_crashing

	PEPPER_TECH_SPEED = $0400

	; If the tech counter is bellow the threshold, just crash
	lda #TECH_NB_FORBIDDEN_FRAMES
	cmp player_a_state_field1, x
	bcs crash

	; A valid tech was entered, land with momentum depending on tech's direction
	jsr pepper_start_landing
	lda player_a_state_field2, x
	beq no_momentum
	cmp #$01
	beq momentum_right
		lda #>(-PEPPER_TECH_SPEED)
		sta player_a_velocity_h, x
		lda #>(-PEPPER_TECH_SPEED)
		sta player_a_velocity_h_low, x
		jmp end
	no_momentum:
		lda #$00
		sta player_a_velocity_h, x
		sta player_a_velocity_h_low, x
		jmp end
	momentum_right:
		lda #>PEPPER_TECH_SPEED
		sta player_a_velocity_h, x
		lda #<PEPPER_TECH_SPEED
		sta player_a_velocity_h_low, x
		jmp end

	crash:
	jmp pepper_start_crashing
	;Note - no return, jump to a subroutine

	end:
	rts
.)

pepper_start_respawn:
.(
	; Set the player's state
	lda #PEPPER_STATE_RESPAWN
	sta player_a_state, x

	; Place player to the respawn spot
	lda stage_data+STAGE_HEADER_OFFSET_RESPAWNX_HIGH
	sta player_a_x, x
	lda stage_data+STAGE_HEADER_OFFSET_RESPAWNX_LOW
	sta player_a_x_low, x
	lda stage_data+STAGE_HEADER_OFFSET_RESPAWNY_HIGH
	sta player_a_y, x
	lda stage_data+STAGE_HEADER_OFFSET_RESPAWNY_LOW
	sta player_a_y_low, x
	lda #$00
	sta player_a_x_screen, x
	sta player_a_y_screen, x
	sta player_a_velocity_h, x
	sta player_a_velocity_h_low, x
	sta player_a_velocity_v, x
	sta player_a_velocity_v_low, x
	sta player_a_damages, x

	; Initialise state's timer
	lda #PLAYER_RESPAWN_MAX_DURATION
	sta player_a_state_field1, x

	; Reinitialize walljump counter
	lda #PEPPER_MAX_WALLJUMPS
	sta pepper_a_num_walljumps, x

	; Set the appropriate animation
	lda #<pepper_anim_respawn
	sta tmpfield13
	lda #>pepper_anim_respawn
	sta tmpfield14
	jsr set_player_animation

	rts
.)


pepper_tick_respawn:
.(
	; Check for timeout
	dec player_a_state_field1, x
	bne end
	jsr pepper_start_falling

	end:
	rts
.)

pepper_input_respawn:
.(
	; Avoid doing anything until controller has returned to neutral since after
	; death the player can release buttons without expecting to take action
	lda controller_a_last_frame_btns, x
	bne end

		; Call pepper_check_aerial_inputs
		;  If it does not change the player state, go to falling state
		;  so that any button press makes the player falls from revival
		;  platform
		jsr pepper_check_aerial_inputs
		lda player_a_state, x
		cmp #PEPPER_STATE_RESPAWN
		bne end

			jsr pepper_start_falling

	end:
	rts
.)


pepper_start_innexistant:
.(
	; Set the player's state
	lda #PEPPER_STATE_INNEXISTANT
	sta player_a_state, x

	; Set to a fixed place
	lda #0
	sta player_a_x_screen, x
	sta player_a_x, x
	sta player_a_x_low, x
	sta player_a_y_screen, x
	sta player_a_y, x
	sta player_a_y_low, x
	sta player_a_velocity_h, x
	sta player_a_velocity_h_low, x
	sta player_a_velocity_v, x
	sta player_a_velocity_v_low, x

	; Set the appropriate animation
	lda #<anim_invisible
	sta tmpfield13
	lda #>anim_invisible
	sta tmpfield14
	jsr set_player_animation

	rts
.)

pepper_tick_innexistant:
.(
	rts
.)


pepper_start_spawn:
.(
	; Hack - there is no ensured call to a character init function
	;        expect start_spawn to be called once at the begining of a game
	jsr pepper_init

	; Set the player's state
	lda #PEPPER_STATE_SPAWN
	sta player_a_state, x

	; Reset clock
	lda #0
	sta player_a_state_clock, x

	; Set the appropriate animation
	lda #<pepper_anim_spawn
	sta tmpfield13
	lda #>pepper_anim_spawn
	sta tmpfield14
	jsr set_player_animation

	rts
.)

pepper_tick_spawn:
.(
	PEPPER_STATE_SPAWN_DURATION = 50

	inc player_a_state_clock, x
	lda player_a_state_clock, x
	cmp #PEPPER_STATE_SPAWN_DURATION
	bne end
		jsr pepper_start_idle

	end:
	rts
.)


pepper_start_idle:
.(
	; Set the player's state
	lda #PEPPER_STATE_IDLE
	sta player_a_state, x

	; Set the appropriate animation
	lda #<pepper_anim_idle
	sta tmpfield13
	lda #>pepper_anim_idle
	sta tmpfield14
	jsr set_player_animation

	rts
.)

pepper_tick_idle:
.(
	; Do not move, velocity tends toward vector (0,0)
	lda #$00
	sta tmpfield4
	sta tmpfield3
	sta tmpfield2
	sta tmpfield1
	lda #$ff
	sta tmpfield5
	jsr merge_to_player_velocity

	; Force handling directional controls
	;   we want to start running even if button presses where maintained from previous state)
	lda controller_a_btns, x
	cmp #CONTROLLER_INPUT_LEFT
	bne no_left
	jsr pepper_input_idle_left
	jmp end
	no_left:
	cmp #CONTROLLER_INPUT_RIGHT
	bne end
	jsr pepper_input_idle_right

	end:
	rts
.)

pepper_input_idle:
.(
	; Do not handle any input if under hitstun
	lda player_a_hitstun, x
	bne end

		; Check state changes
		lda #<(input_table+1)
		sta tmpfield1
		lda #>(input_table+1)
		sta tmpfield2
		lda input_table
		sta tmpfield3
		jmp controller_callbacks

	end:
	rts

	input_table:
	.(
		table_length:
		.byt 8
		controller_inputs:
		.byt CONTROLLER_INPUT_LEFT,      CONTROLLER_INPUT_RIGHT
		.byt CONTROLLER_INPUT_JUMP,      CONTROLLER_INPUT_JUMP_RIGHT
		.byt CONTROLLER_INPUT_JUMP_LEFT, CONTROLLER_INPUT_TECH
		.byt CONTROLLER_INPUT_TECH_LEFT,  CONTROLLER_INPUT_TECH_RIGHT
		controller_callbacks_lsb:
		.byt <pepper_input_idle_left,      <pepper_input_idle_right
		.byt <pepper_start_jumping,        <pepper_input_idle_jump_right
		.byt <pepper_input_idle_jump_left, <pepper_start_shielding
		.byt <pepper_start_shielding,      <pepper_start_shielding
		controller_callbacks_msb:
		.byt >pepper_input_idle_left,      >pepper_input_idle_right
		.byt >pepper_start_jumping,        >pepper_input_idle_jump_right
		.byt >pepper_input_idle_jump_left, >pepper_start_shielding
		.byt >pepper_start_shielding,      >pepper_start_shielding
		controller_default_callback:
		.word end
	.)

	pepper_input_idle_jump_right:
	.(
		lda DIRECTION_RIGHT
		sta player_a_direction, x
		jmp pepper_start_jumping
		;rts ; useless - pepper_start_jumping is a routine
	.)

	pepper_input_idle_jump_left:
	.(
		lda DIRECTION_LEFT
		sta player_a_direction, x
		jmp pepper_start_jumping
		;rts ; useless - pepper_start_jumping is a routine
	.)
.)

pepper_input_idle_left:
.(
	lda DIRECTION_LEFT
	sta player_a_direction, x
	jsr pepper_start_running
	rts
.)

pepper_input_idle_right:
.(
	lda DIRECTION_RIGHT
	sta player_a_direction, x
	jsr pepper_start_running
	rts
.)


PEPPER_RUNNING_INITIAL_VELOCITY = $0100
PEPPER_RUNNING_MAX_VELOCITY = $0180
PEPPER_RUNNING_ACCELERATION = $40
pepper_start_running:
.(
	; Set the player's state
	lda #PEPPER_STATE_RUNNING
	sta player_a_state, x

	; Set initial velocity
	lda player_a_direction, x
	cmp DIRECTION_LEFT
	bne direction_right
		lda #<-PEPPER_RUNNING_INITIAL_VELOCITY
		sta player_a_velocity_h_low, x
		lda #>-PEPPER_RUNNING_INITIAL_VELOCITY
		jmp set_high_byte
	direction_right:
		lda #<PEPPER_RUNNING_INITIAL_VELOCITY
		sta player_a_velocity_h_low, x
		lda #>PEPPER_RUNNING_INITIAL_VELOCITY
	set_high_byte:
	sta player_a_velocity_h, x

	; Fallthrough to set animation
.)
pepper_set_running_animation:
.(
	; Set the appropriate animation
	lda #<pepper_anim_run
	sta tmpfield13
	lda #>pepper_anim_run
	sta tmpfield14
	jsr set_player_animation

	rts
.)

pepper_tick_running:
.(
	; Update player's velocity dependeing on his direction
	lda player_a_direction, x
	beq run_left

		; Running right, velocity tends toward vector max velocity
		lda #>PEPPER_RUNNING_MAX_VELOCITY
		sta tmpfield4
		lda #<PEPPER_RUNNING_MAX_VELOCITY
		jmp update_velocity

	run_left:
		; Running left, velocity tends toward vector "-1 * max volcity"
		lda #>-PEPPER_RUNNING_MAX_VELOCITY
		sta tmpfield4
		lda #<-PEPPER_RUNNING_MAX_VELOCITY

	update_velocity:
		sta tmpfield2
		lda #0
		sta tmpfield3
		sta tmpfield1
		lda #PEPPER_RUNNING_ACCELERATION
		sta tmpfield5
		jsr merge_to_player_velocity

	end:
	rts
.)

pepper_input_running:
.(
	; If in hitstun, stop running
	lda player_a_hitstun, x
	beq take_input
		jsr pepper_start_idle
		jmp end
	take_input:

		; Check state changes
		lda #<(input_table+1)
		sta tmpfield1
		lda #>(input_table+1)
		sta tmpfield2
		lda input_table
		sta tmpfield3
		jmp controller_callbacks

	end:
	rts

	pepper_input_running_left:
	.(
		lda DIRECTION_LEFT
		cmp player_a_direction, x
		beq end_changing_direction
			sta player_a_direction, x
			jsr pepper_set_running_animation
		end_changing_direction:
		rts
	.)

	pepper_input_running_right:
	.(
		lda DIRECTION_RIGHT
		cmp player_a_direction, x
		beq end_changing_direction
			sta player_a_direction, x
			jsr pepper_set_running_animation
		end_changing_direction:
		rts
	.)

	input_table:
	.(
		table_length:
		.byt 8
		controller_inputs:
		.byt CONTROLLER_INPUT_LEFT,      CONTROLLER_INPUT_RIGHT
		.byt CONTROLLER_INPUT_JUMP,      CONTROLLER_INPUT_JUMP_RIGHT,
		.byt CONTROLLER_INPUT_JUMP_LEFT, CONTROLLER_INPUT_TECH
		.byt CONTROLLER_INPUT_TECH_LEFT, CONTROLLER_INPUT_TECH_RIGHT
		controller_callbacks_lsb:
		.byt <pepper_input_running_left, <pepper_input_running_right
		.byt <pepper_start_jumping,      <pepper_start_jumping
		.byt <pepper_start_jumping,      <pepper_start_shielding
		.byt <pepper_start_shielding,    <pepper_start_shielding
		controller_callbacks_msb:
		.byt >pepper_input_running_left, >pepper_input_running_right
		.byt >pepper_start_jumping,      >pepper_start_jumping
		.byt >pepper_start_jumping,      >pepper_start_shielding
		.byt >pepper_start_shielding,    >pepper_start_shielding
		controller_default_callback:
		.word pepper_start_idle
	.)
.)


pepper_start_jumping:
.(
	lda #PEPPER_STATE_JUMPING
	sta player_a_state, x

	lda #0
	sta player_a_state_field1, x
	sta player_a_state_clock, x

	; Set the appropriate animation
	lda #<pepper_anim_jump
	sta tmpfield13
	lda #>pepper_anim_jump
	sta tmpfield14
	jsr set_player_animation

	rts
.)

PEPPER_STATE_JUMP_PREPARATION_END = 4
pepper_tick_jumping:
.(
	PEPPER_STATE_JUMP_SHORT_HOP_TIME = 9
	PEPPER_STATE_JUMP_INITIAL_VELOCITY = $fac0
	PEPPER_STATE_JUMP_SHORT_HOP_VELOCITY = $fefe

	; Tick clock
	inc player_a_state_clock, x

	; Wait for the preparation to end to begin to jump
	lda player_a_state_clock, x
	cmp #PEPPER_STATE_JUMP_PREPARATION_END
	bcc end
	beq begin_to_jump

	; Handle short-hop input
	cmp #PEPPER_STATE_JUMP_SHORT_HOP_TIME
	beq stop_short_hop

	; Check if the top of the jump is reached
	lda player_a_velocity_v, x
	beq top_reached
	bpl top_reached

	; The top is not reached, stay in jumping state but apply gravity and directional influence
	moving_upward:
		jsr pepper_tick_falling ; Hack - We just use pepper_tick_falling which do exactly what we want
		jmp end

	; The top is reached, return to falling
	top_reached:
		jsr pepper_start_falling
		jmp end

	; If the jump button is no more pressed mid jump, convert the jump to a short-hop
	stop_short_hop:
		; Handle this tick as any other
		jsr pepper_tick_falling

		; If the jump button is still pressed, this is not a short-hop
		lda controller_a_btns, x
		and #CONTROLLER_INPUT_JUMP
		bne end

		; Reduce upward momentum to end the jump earlier
		lda #>PEPPER_STATE_JUMP_SHORT_HOP_VELOCITY
		sta player_a_velocity_v, x
		lda #<PEPPER_STATE_JUMP_SHORT_HOP_VELOCITY
		sta player_a_velocity_v_low, x
		jmp end

	; Put initial jumping velocity
	begin_to_jump:
		lda #>PEPPER_STATE_JUMP_INITIAL_VELOCITY
		sta player_a_velocity_v, x
		lda #<PEPPER_STATE_JUMP_INITIAL_VELOCITY
		sta player_a_velocity_v_low, x
		;jmp end ; Useless, fallthrough

	end:
	rts
.)

pepper_input_jumping:
.(
	; The jump is cancellable by grounded movements during preparation
	; and by aerial movements after that
	lda player_a_num_aerial_jumps, x ; performing aerial jump, not
	bne not_grounded                 ; grounded
	lda player_a_state_clock, x          ;
	cmp #PEPPER_STATE_JUMP_PREPARATION_END ; Still preparing the jump
	bcc grounded                         ;

	not_grounded:
	jsr pepper_check_aerial_inputs
	jmp end

	grounded:
	lda #<(input_table+1)
	sta tmpfield1
	lda #>(input_table+1)
	sta tmpfield2
	lda input_table
	sta tmpfield3
	jmp controller_callbacks

	end:
	rts

	input_table:
	.(
		; Impactful controller states and associated callbacks (when still grounded)
		; Note - We can put subroutines as callbacks because we have nothing to do after calling it
		;        (sourboutines return to our caller since "called" with jmp)
		; TODO callbacks set to "end" are to be implemented (except the default callback)
		table_length:
		.byt 2
		controller_inputs:
		.byt CONTROLLER_INPUT_ATTACK_UP, CONTROLLER_INPUT_SPECIAL_UP
		controller_callbacks_lo:
		.byt <end, <end
		controller_callbacks_hi:
		.byt >end, >end
		controller_default_callback:
		.word end
	.)
.)


pepper_start_aerial_jumping:
.(
	; Deny to start jump state if the player used all it's jumps
	lda #PEPPER_MAX_NUM_AERIAL_JUMPS
	cmp player_a_num_aerial_jumps, x
	bne jump_ok
	rts
	jump_ok:
	inc player_a_num_aerial_jumps, x

	; Trick - aerial_jumping set the state to jumping. It is the same state with
	; the starting conditions as the only differences
	lda #PEPPER_STATE_JUMPING
	sta player_a_state, x

	; Reset clock
	lda #0
	sta player_a_state_clock, x

	lda #$00
	sta player_a_velocity_v, x
	lda #$00
	sta player_a_velocity_v_low, x

	; Set the appropriate animation
	;TODO use pepper_anim_aerial_jump animation
	lda #<pepper_anim_jump
	sta tmpfield13
	lda #>pepper_anim_jump
	sta tmpfield14
	jsr set_player_animation

	rts
.)


pepper_start_falling:
.(
	lda #PEPPER_STATE_FALLING
	sta player_a_state, x

	; Set the appropriate animation
	lda #<pepper_anim_falling
	sta tmpfield13
	lda #>pepper_anim_falling
	sta tmpfield14
	jsr set_player_animation

	rts
.)

pepper_tick_falling:
.(
	jsr pepper_aerial_directional_influence
	jsr apply_player_gravity
	rts
.)


pepper_start_landing:
.(
	jsr pepper_global_onground

	PEPPER_LANDING_SPEED_CAP = $0200

	; Set state
	lda #PEPPER_STATE_LANDING
	sta player_a_state, x

	; Reset clock
	lda #0
	sta player_a_state_clock, x

	; Cap initial velocity
#if (PEPPER_LANDING_SPEED_CAP & $00ff) <> 0
#error following condition expects round number for pepper landing speed cap
#endif
	lda player_a_velocity_h, x
	jsr absolute_a
	cmp #>(PEPPER_LANDING_SPEED_CAP+$0100)
	bcs set_cap

		jmp pepper_set_landing_animation

	set_cap:
		lda player_a_velocity_h, x
		bmi negative_cap
			lda #>PEPPER_LANDING_SPEED_CAP
			sta player_a_velocity_h, x
			lda #<PEPPER_LANDING_SPEED_CAP
			sta player_a_velocity_h_low, x
			jmp pepper_set_landing_animation
		negative_cap:
			lda #>(-PEPPER_LANDING_SPEED_CAP)
			sta player_a_velocity_h, x
			lda #<(-PEPPER_LANDING_SPEED_CAP)
			sta player_a_velocity_h_low, x

	; Fallthrough to set the animation
.)
pepper_set_landing_animation:
.(
	; Set the appropriate animation
	lda #<pepper_anim_landing
	sta tmpfield13
	lda #>pepper_anim_landing
	sta tmpfield14
	jsr set_player_animation

	rts
.)

pepper_tick_landing:
.(
	PEPPER_STATE_LANDING_DURATION = 6

	; Tick clock
	inc player_a_state_clock, x

	; Do not move, velocity tends toward vector (0,0)
	lda #$00
	sta tmpfield4
	sta tmpfield3
	sta tmpfield2
	sta tmpfield1
	lda #PEPPER_GROUND_FRICTION_STRENGTH
	sta tmpfield5
	jsr merge_to_player_velocity

	; After move's time is out, go to standing state
	lda player_a_state_clock, x
	cmp #PEPPER_STATE_LANDING_DURATION
	bne end
	jsr pepper_start_idle

	end:
	rts
.)


pepper_start_crashing:
.(
	; Set state
	lda #PEPPER_STATE_CRASHING
	sta player_a_state, x

	; Reset clock
	lda #0
	sta player_a_state_clock, x

	; Set the appropriate animation
	lda #<pepper_anim_crash
	sta tmpfield13
	lda #>pepper_anim_crash
	sta tmpfield14
	jsr set_player_animation

	; Play crash sound
	jsr audio_play_crash

	rts
.)

pepper_tick_crashing:
.(
	PEPPER_STATE_CRASHING_DURATION = 30

	; Tick clock
	inc player_a_state_clock, x

	; Do not move, velocity tends toward vector (0,0)
	lda #$00
	sta tmpfield4
	sta tmpfield3
	sta tmpfield2
	sta tmpfield1
	lda #PEPPER_GROUND_FRICTION_STRENGTH*2
	sta tmpfield5
	jsr merge_to_player_velocity

	; After move's time is out, go to standing state
	lda player_a_state_clock, x
	cmp #PEPPER_STATE_CRASHING_DURATION
	bne end
	jsr pepper_start_idle

	end:
	rts
.)


pepper_start_helpless:
.(
	; Set state
	lda #PEPPER_STATE_HELPLESS
	sta player_a_state, x

	; Set the appropriate animation
	lda #<pepper_anim_helpless
	sta tmpfield13
	lda #>pepper_anim_helpless
	sta tmpfield14
	jsr set_player_animation

	rts
.)

pepper_tick_helpless:
.(
	jmp pepper_tick_falling
.)

pepper_input_helpless:
.(
	; Allow to escape helpless mode with a walljump, else keep input dirty
	lda player_a_walled, x
	beq no_jump
	lda pepper_a_num_walljumps, x
	beq no_jump
		jump:
			lda player_a_walled_direction, x
			sta player_a_direction, x
			jmp pepper_start_walljumping
		no_jump:
			jmp keep_input_dirty
	;rts ; useless, both branches jump to a subroutine
.)


pepper_start_shielding:
.(
	; Set state
	lda #PEPPER_STATE_SHIELDING
	sta player_a_state, x

	; Reset clock
	lda #0
	sta player_a_state_clock, x

	; Set the appropriate animation
	lda #<pepper_anim_shield_full
	sta tmpfield13
	lda #>pepper_anim_shield_full
	sta tmpfield14
	jsr set_player_animation

	; Cancel momentum
	lda #$00
	sta player_a_velocity_h_low, x
	sta player_a_velocity_h, x

	; Set shield as full life
	lda #2
	sta player_a_state_field1, x

	rts
.)

pepper_tick_shielding:
.(
	; Tick clock
	lda player_a_state_clock, x
	cmp #PLAYER_DOWN_TAP_MAX_DURATION
	bcs end_tick
		inc player_a_state_clock, x
	end_tick:

	rts
.)

pepper_input_shielding:
.(
	; Maintain down to stay on shield
	; Down-a and down-b are allowed as out of shield moves
	; Any other combination ends the shield (with shield lag or falling from smooth platform)
	lda controller_a_btns, x
	cmp #CONTROLLER_INPUT_TECH
	beq end
	cmp #CONTROLLER_INPUT_DOWN_TILT
	beq handle_input
	cmp #CONTROLLER_INPUT_SPECIAL_DOWN
	beq handle_input

	end_shield:

		lda #PLAYER_DOWN_TAP_MAX_DURATION
		cmp player_a_state_clock, x
		beq shieldlag
		bcc shieldlag
			ldy player_a_grounded, x
			beq shieldlag
				lda stage_data, y
				cmp #STAGE_ELEMENT_PLATFORM
				beq shieldlag
				cmp #STAGE_ELEMENT_OOS_PLATFORM
				beq shieldlag

		fall_from_smooth:
			; HACK - "position = position + 2" to compensate collision system not handling subpixels and "position + 1" being the collision line
			;        actually, "position = position + 3" to compensate for moving platforms that move down
			;        Better solution would be to have an intermediary player state with a specific animation
			clc
			lda player_a_y, x
			adc #3
			sta player_a_y, x
			lda player_a_y_screen, x
			adc #0
			sta player_a_y_screen, x

			jmp pepper_start_falling
			; No return, jump to subroutine

		shieldlag:
			jmp pepper_start_shieldlag
			; No return, jump to subroutine

	handle_input:

		jmp pepper_input_idle
		; No return, jump to subroutine

	end:
	rts
.)

pepper_hurt_shielding:
.(
	stroke_player = tmpfield11

	; Reduce shield's life
	dec player_a_state_field1, x

	; Select what to do according to shield's life
	lda player_a_state_field1, x
	beq limit_shield
	cmp #1
	beq partial_shield

		; Break the shield, derived from normal hurt with:
		;  Knockback * 2
		;  Screen shaking * 4
		;  Special sound
		jsr hurt_player
		ldx stroke_player
		asl player_a_velocity_h_low, x
		rol player_a_velocity_h, x
		asl player_a_velocity_v_low, x
		rol player_a_velocity_v, x
		asl player_a_hitstun, x
		asl screen_shake_counter
		asl screen_shake_counter
		jsr audio_play_shield_break
		jmp end

	partial_shield:
		; Get the animation corresponding to the shield's life
		lda #<pepper_anim_shield_partial
		sta tmpfield13
		lda #>pepper_anim_shield_partial
		jmp still_shield

	limit_shield:
		; Get the animation corresponding to the shield's life
		lda #<pepper_anim_shield_limit
		sta tmpfield13
		lda #>pepper_anim_shield_limit

	still_shield:
		; Set the new shield animation
		sta tmpfield14
		jsr set_player_animation

		; Play sound
		jsr audio_play_shield_hit

	end:
	; Disable the hitbox to avoid multi-hits
	jsr switch_selected_player
	lda HITBOX_DISABLED
	sta player_a_hitbox_enabled, x

	rts
.)

pepper_start_shieldlag:
.(
	; Set state
	lda #PEPPER_STATE_SHIELDLAG
	sta player_a_state, x

	; Reset clock
	lda #0
	sta player_a_state_clock, x

	; Set the appropriate animation
	lda #<pepper_anim_shield_remove
	sta tmpfield13
	lda #>pepper_anim_shield_remove
	sta tmpfield14
	jsr set_player_animation

	rts
.)

pepper_tick_shieldlag:
.(
	PEPPER_STATE_SHIELDLAG_DURATION = 8

	; Do not move, velocity tends toward vector (0,0)
	lda #$00
	sta tmpfield4
	sta tmpfield3
	sta tmpfield2
	sta tmpfield1
	lda #$80
	sta tmpfield5
	jsr merge_to_player_velocity

	; After move's time is out, go to standing state
	inc player_a_state_clock, x
	lda player_a_state_clock, x
	cmp #PEPPER_STATE_SHIELDLAG_DURATION
	bne end
		jsr pepper_start_idle

	end:
	rts
.)


pepper_start_walljumping:
.(
	; Deny to start jump state if the player used all it's jumps
	;lda pepper_a_num_walljumps, x ; useless, all calls to pepper_start_walljumping actually do this check
	;beq end

	; Update wall jump counter
	dec pepper_a_num_walljumps, x

	; Set player's state
	lda #PEPPER_STATE_WALLJUMPING
	sta player_a_state, x

	; Reset clock
	lda #0
	sta player_a_state_clock, x

	; Stop any momentum, pepper does not fall during jumpsquat
	sta player_a_velocity_h, x
	sta player_a_velocity_h_low, x
	sta player_a_velocity_v, x
	sta player_a_velocity_v_low, x

	; Set the appropriate animation
	;TODO specific animation
	lda #<pepper_anim_jump
	sta tmpfield13
	lda #>pepper_anim_jump
	sta tmpfield14
	jsr set_player_animation

	end:
	rts
.)

pepper_tick_walljumping:
.(
	; Tick clock
	inc player_a_state_clock, x

	; Wait for the preparation to end to begin to jump
	lda player_a_state_clock, x
	cmp #PEPPER_WALL_JUMP_SQUAT_END
	bcc end
	beq begin_to_jump

	; Check if the top of the jump is reached
	lda player_a_velocity_v, x
	beq top_reached
	bpl top_reached

		; The top is not reached, stay in walljumping state but apply gravity, without directional influence
		jmp apply_player_gravity
		;jmp end ; useless, jump to a subroutine

	; The top is reached, return to falling
	top_reached:
		jmp pepper_start_falling
		;jmp end ; useless, jump to a subroutine

	; Put initial jumping velocity
	begin_to_jump:
		; Vertical velocity
		lda #>PEPPER_WALL_JUMP_VELOCITY_VERTICAL
		sta player_a_velocity_v, x
		lda #<PEPPER_WALL_JUMP_VELOCITY_VERTICAL
		sta player_a_velocity_v_low, x

		; Horizontal velocity
		lda player_a_direction, x
		;cmp DIRECTION_LEFT ; useless while DIRECTION_LEFT is $00
		bne jump_right
			jump_left:
				lda #$ff
				jmp end_jump_direction
			jump_right:
				lda #1
		end_jump_direction:
		sta player_a_velocity_h, x

		;jmp end ; useless, fallthrough

	end:
	rts
.)

pepper_input_walljumping:
.(
	; The jump is cancellable by aerial movements, but only after preparation
	lda #PEPPER_WALL_JUMP_SQUAT_END
	cmp player_a_state_clock, x
	bcs grounded
		not_grounded:
			jmp pepper_check_aerial_inputs
			; no return, jump to a subroutine
	grounded:
	rts
.)