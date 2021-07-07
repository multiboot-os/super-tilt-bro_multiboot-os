GAME_VERSION_TYPE = 0 ; 0-alpha 1-beta 2-rc 3-release
GAME_VERSION_MAJOR = 2
GAME_VERSION_MINOR = 8
GAME_VERSION = (GAME_VERSION_TYPE << 10) + (GAME_VERSION_MAJOR << 8) + GAME_VERSION_MINOR

#define INITIAL_GAME_STATE $01

GAME_STATE_INGAME = $00
GAME_STATE_TITLE = $01
GAME_STATE_GAMEOVER = $02
GAME_STATE_CREDITS = $03
GAME_STATE_CONFIG = $04
GAME_STATE_STAGE_SELECTION = $05
GAME_STATE_CHARACTER_SELECTION = $06
GAME_STATE_MODE_SELECTION = $07
GAME_STATE_NETPLAY_LAUNCH = $08
GAME_STATE_DONATION = $09
GAME_STATE_DONATION_BTC = $0a
GAME_STATE_DONATION_PAYPAL = $0b
GAME_STATE_ONLINE_MODE_SELECTION = $0c
GAME_STATE_WIFI_SETTINGS = $0d
;NOTE maximum supported value is $0f, because get_transition_id returns an ID on one byte. To handle more than 16 states, it should be changed.

DEFAULT_GRAVITY = $0200

; Variants of ingame state
GAME_MODE_LOCAL = $00
GAME_MODE_ONLINE = $01

; States used by the game engine, they must have a referenced start_routine
PLAYER_STATE_THROWN = $00
PLAYER_STATE_RESPAWN = $01
PLAYER_STATE_INNEXISTANT = $02
PLAYER_STATE_SPAWN = $03
; States used by generic AI to check player's state, no need for a referenced start_routine
PLAYER_STATE_STANDING = $04
PLAYER_STATE_RUNNING = $05
; End of standard player states, from this index characters are free to define custom states
CUSTOM_PLAYER_STATES_BEGIN = $06

PLAYER_RESPAWN_MAX_DURATION = 200 ; Beware max is 212 (ntsc counterpart would overflow above that)
PLAYER_DOWN_TAP_MAX_DURATION = 9

CHARACTERS_NUM_TILES_PER_CHAR = 96
CHARACTERS_CHARACTER_A_FIRST_TILE = 0
CHARACTERS_CHARACTER_B_FIRST_TILE = CHARACTERS_CHARACTER_A_FIRST_TILE+CHARACTERS_NUM_TILES_PER_CHAR
CHARACTERS_CHARACTER_A_TILES_OFFSET = CHARACTERS_CHARACTER_A_FIRST_TILE*16
CHARACTERS_CHARACTER_B_TILES_OFFSET = CHARACTERS_CHARACTER_B_FIRST_TILE*16
CHARACTERS_END_TILES_OFFSET = 2*CHARACTERS_NUM_TILES_PER_CHAR*16

CHARACTERS_PROPERTIES_VICTORY_ANIM_OFFSET = 0
CHARACTERS_PROPERTIES_DEFEAT_ANIM_OFFSET = 2
CHARACTERS_PROPERTIES_MENU_SELECT_ANIM_OFFSET = 4
CHARACTERS_PROPERTIES_CHAR_NAME_OFFSET = 6
CHARACTERS_PROPERTIES_ILLUSTRATIONS_ADDR_OFFSET = 16
CHARACTERS_PROPERTIES_AI_ACTION_SELECTORS_OFFSET = 18
CHARACTERS_PROPERTIES_AI_NB_ATTACKS_OFFSET = 20
CHARACTERS_PROPERTIES_AI_ATTACKS_OFFSET = 21

CHARACTERS_ILLUSTRATION_TOKEN_OFFSET = 0
CHARACTERS_ILLUSTRATION_SMALL_OFFSET = 1
CHARACTERS_ILLUSTRATION_LARGE_OFFSET = 5

TECH_MAX_FRAMES_BEFORE_COLLISION_PAL = 15 ; To tech successfully the tech must be input at maximum TECH_MAX_FRAMES_BEFORE_COLLISION frames before hitting the ground
TECH_NB_FORBIDDEN_FRAMES_PAL = 50 ; After expiration of a tech input, it is not possible to input another tech for TECH_NB_FORBIDDEN_FRAMES frames
TECH_MAX_FRAMES_BEFORE_COLLISION_NTSC = 18
TECH_NB_FORBIDDEN_FRAMES_NTSC = 60

NETWORK_INPUT_LAG = 4

#define INGAME_PLAYER_A_FIRST_SPRITE 0
#define INGAME_PLAYER_A_LAST_SPRITE 15
#define INGAME_PLAYER_B_FIRST_SPRITE 16
#define INGAME_PLAYER_B_LAST_SPRITE 31

#define DIRECTION_LEFT #$00
#define DIRECTION_RIGHT #$01

#define HITBOX_DISABLED #$00
#define HITBOX_ENABLED #$01

#define HITSTUN_PARRY_NB_FRAMES 10
#define SCREENSHAKE_PARRY_NB_FRAMES 2
#define SCREENSHAKE_PARRY_INTENSITY 1

#define MAX_STOCKS 4
#define MAX_AI_LEVEL 3

#define TILENUM_NT_CHAR_0 #TILE_CHAR_0

#define CONTROLLER_BTN_A      %10000000
#define CONTROLLER_BTN_B      %01000000
#define CONTROLLER_BTN_SELECT %00100000
#define CONTROLLER_BTN_START  %00010000
#define CONTROLLER_BTN_UP     %00001000
#define CONTROLLER_BTN_DOWN   %00000100
#define CONTROLLER_BTN_LEFT   %00000010
#define CONTROLLER_BTN_RIGHT  %00000001

#define CONTROLLER_INPUT_NONE               0
#define CONTROLLER_INPUT_JUMP               CONTROLLER_BTN_UP
#define CONTROLLER_INPUT_JAB                CONTROLLER_BTN_A
#define CONTROLLER_INPUT_LEFT               CONTROLLER_BTN_LEFT
#define CONTROLLER_INPUT_RIGHT              CONTROLLER_BTN_RIGHT
#define CONTROLLER_INPUT_JUMP_RIGHT         CONTROLLER_BTN_UP | CONTROLLER_BTN_RIGHT
#define CONTROLLER_INPUT_JUMP_LEFT          CONTROLLER_BTN_UP | CONTROLLER_BTN_LEFT
#define CONTROLLER_INPUT_ATTACK_LEFT        CONTROLLER_BTN_LEFT | CONTROLLER_BTN_A
#define CONTROLLER_INPUT_ATTACK_RIGHT       CONTROLLER_BTN_RIGHT | CONTROLLER_BTN_A
#define CONTROLLER_INPUT_ATTACK_UP          CONTROLLER_BTN_UP | CONTROLLER_BTN_A
#define CONTROLLER_INPUT_ATTACK_UP_LEFT     CONTROLLER_BTN_UP | CONTROLLER_BTN_A | CONTROLLER_BTN_LEFT
#define CONTROLLER_INPUT_ATTACK_UP_RIGHT    CONTROLLER_BTN_UP | CONTROLLER_BTN_A | CONTROLLER_BTN_RIGHT
#define CONTROLLER_INPUT_DOWN_TILT          CONTROLLER_BTN_DOWN | CONTROLLER_BTN_A
#define CONTROLLER_INPUT_ATTACK_DOWN_LEFT   CONTROLLER_BTN_DOWN | CONTROLLER_BTN_A | CONTROLLER_BTN_LEFT
#define CONTROLLER_INPUT_ATTACK_DOWN_RIGHT  CONTROLLER_BTN_DOWN | CONTROLLER_BTN_A | CONTROLLER_BTN_RIGHT
#define CONTROLLER_INPUT_SPECIAL            CONTROLLER_BTN_B
#define CONTROLLER_INPUT_SPECIAL_RIGHT      CONTROLLER_BTN_B | CONTROLLER_BTN_RIGHT
#define CONTROLLER_INPUT_SPECIAL_LEFT       CONTROLLER_BTN_B | CONTROLLER_BTN_LEFT
#define CONTROLLER_INPUT_SPECIAL_DOWN       CONTROLLER_BTN_B | CONTROLLER_BTN_DOWN
#define CONTROLLER_INPUT_SPECIAL_DOWN_LEFT  CONTROLLER_BTN_B | CONTROLLER_BTN_DOWN | CONTROLLER_BTN_LEFT
#define CONTROLLER_INPUT_SPECIAL_DOWN_RIGHT CONTROLLER_BTN_B | CONTROLLER_BTN_DOWN | CONTROLLER_BTN_RIGHT
#define CONTROLLER_INPUT_SPECIAL_UP         CONTROLLER_BTN_B | CONTROLLER_BTN_UP
#define CONTROLLER_INPUT_SPECIAL_UP_LEFT    CONTROLLER_BTN_B | CONTROLLER_BTN_UP | CONTROLLER_BTN_LEFT
#define CONTROLLER_INPUT_SPECIAL_UP_RIGHT   CONTROLLER_BTN_B | CONTROLLER_BTN_UP | CONTROLLER_BTN_RIGHT
#define CONTROLLER_INPUT_TECH               CONTROLLER_BTN_DOWN
#define CONTROLLER_INPUT_TECH_RIGHT         CONTROLLER_BTN_DOWN | CONTROLLER_BTN_RIGHT
#define CONTROLLER_INPUT_TECH_LEFT          CONTROLLER_BTN_DOWN | CONTROLLER_BTN_LEFT

#define GAME_STATE_INGAME $00
#define GAME_STATE_TITLE $01
#define GAME_STATE_GAMEOVER $02
#define GAME_STATE_CREDITS $03
#define GAME_STATE_CONFIG $04
#define GAME_STATE_STAGE_SELECTION $05
#define GAME_STATE_CHARACTER_SELECTION $06

#define ZERO_PAGE_GLOBAL_FIELDS_BEGIN $b0

STAGE_ELEMENT_END = $00
STAGE_ELEMENT_PLATFORM = $01
STAGE_ELEMENT_SMOOTH_PLATFORM = $02
STAGE_ELEMENT_OOS_PLATFORM = $03
STAGE_ELEMENT_OOS_SMOOTH_PLATFORM = $04

#define STAGE_HEADER_OFFSET_PAX_LOW 0
#define STAGE_HEADER_OFFSET_PBX_LOW 1
#define STAGE_HEADER_OFFSET_PAX_HIGH 2
#define STAGE_HEADER_OFFSET_PBX_HIGH 3
#define STAGE_HEADER_OFFSET_PAY_LOW 4
#define STAGE_HEADER_OFFSET_PBY_LOW 5
#define STAGE_HEADER_OFFSET_PAY_HIGH 6
#define STAGE_HEADER_OFFSET_PBY_HIGH 7
#define STAGE_HEADER_OFFSET_RESPAWNX_LOW 8
#define STAGE_HEADER_OFFSET_RESPAWNX_HIGH 9
#define STAGE_HEADER_OFFSET_RESPAWNY_LOW 10
#define STAGE_HEADER_OFFSET_RESPAWNY_HIGH 11
#define STAGE_OFFSET_ELEMENTS 12
#define STAGE_PLATFORM_OFFSET_LEFT 1
#define STAGE_PLATFORM_OFFSET_RIGHT 2
#define STAGE_PLATFORM_OFFSET_TOP 3
#define STAGE_PLATFORM_OFFSET_BOTTOM 4
#define STAGE_OOS_PLATFORM_OFFSET_LEFT_LSB 1
#define STAGE_OOS_PLATFORM_OFFSET_LEFT_MSB 2
#define STAGE_OOS_PLATFORM_OFFSET_RIGHT_LSB 3
#define STAGE_OOS_PLATFORM_OFFSET_RIGHT_MSB 4
#define STAGE_OOS_PLATFORM_OFFSET_TOP_LSB 5
#define STAGE_OOS_PLATFORM_OFFSET_TOP_MSB 6
#define STAGE_OOS_PLATFORM_OFFSET_BOTTOM_LSB 7
#define STAGE_OOS_PLATFORM_OFFSET_BOTTOM_MSB 8
#define STAGE_ELEMENT_SIZE 9

;TODO place these values in character properties
#define NB_CHARACTER_PALETTES 7
#define NB_WEAPON_PALETTES 7

#define AUDIO_CHANNEL_SQUARE $00
#define AUDIO_CHANNEL_TRIANGLE $01

#define PARTICLE_BLOCK_OFFSET_PARAM 0
#define PARTICLE_BLOCK_OFFSET_TILENUM 1
#define PARTICLE_BLOCK_OFFSET_TILEATTR 2
#define PARTICLE_BLOCK_OFFSET_POSITIONS 4
#define PARTICLE_POSITION_OFFSET_X_LSB 0
#define PARTICLE_POSITION_OFFSET_X_MSB 1
#define PARTICLE_POSITION_OFFSET_Y_LSB 2
#define PARTICLE_POSITION_OFFSET_Y_MSB 3
#define PARTICLE_BLOCK_SIZE 32
#define PARTICLE_BLOCK_NB_PARTICLES 7
#define PARTICLE_NB_BLOCKS 2
#define PARTICLE_FIRST_SPRITE 50

#define ANIMATION_STATE_OFFSET_X_LSB 0
#define ANIMATION_STATE_OFFSET_X_MSB 1
#define ANIMATION_STATE_OFFSET_Y_LSB 2
#define ANIMATION_STATE_OFFSET_Y_MSB 3
#define ANIMATION_STATE_OFFSET_DATA_VECTOR_LSB 4
#define ANIMATION_STATE_OFFSET_DATA_VECTOR_MSB 5
#define ANIMATION_STATE_OFFSET_DIRECTION 6
#define ANIMATION_STATE_OFFSET_CLOCK 7
#define ANIMATION_STATE_OFFSET_FIRST_SPRITE_NUM 8
#define ANIMATION_STATE_OFFSET_LAST_SPRITE_NUM 9
#define ANIMATION_STATE_OFFSET_FRAME_VECTOR_LSB 10
#define ANIMATION_STATE_OFFSET_FRAME_VECTOR_MSB 11
#define ANIMATION_STATE_LENGTH 12

#define SLOWDOWN_TIME 100

#define MENU_COMMON_NB_CLOUDS 3
#define MENU_COMMON_OAM_SPRITE_SIZE 4
#define MENU_COMMON_NB_SPRITE_PER_CLOUD 5
#define MENU_COMMON_FIRST_CLOUD_SPRITE (64 - MENU_COMMON_NB_SPRITE_PER_CLOUD * MENU_COMMON_NB_CLOUDS)

NOTE_PAL_O0_C = $7ff
NOTE_PAL_O0_Cs = $7ff
NOTE_PAL_O0_D = $7ff
NOTE_PAL_O0_Ds = $7ff
NOTE_PAL_O0_E = $7ff
NOTE_PAL_O0_F = $7ff
NOTE_PAL_O0_Fs = $7ff
NOTE_PAL_O0_G = $7ff
NOTE_PAL_O0_Gs = $7d1
NOTE_PAL_O0_A = $760
NOTE_PAL_O0_As = $6f6
NOTE_PAL_O0_B = $692
NOTE_PAL_O1_C = $634
NOTE_PAL_O1_Cs = $5da
NOTE_PAL_O1_D = $586
NOTE_PAL_O1_Ds = $537
NOTE_PAL_O1_E = $4ec
NOTE_PAL_O1_F = $4a5
NOTE_PAL_O1_Fs = $462
NOTE_PAL_O1_G = $423
NOTE_PAL_O1_Gs = $3e8
NOTE_PAL_O1_A = $3b0
NOTE_PAL_O1_As = $37b
NOTE_PAL_O1_B = $349
NOTE_PAL_O2_C = $319
NOTE_PAL_O2_Cs = $2ed
NOTE_PAL_O2_D = $2c3
NOTE_PAL_O2_Ds = $29b
NOTE_PAL_O2_E = $276
NOTE_PAL_O2_F = $252
NOTE_PAL_O2_Fs = $231
NOTE_PAL_O2_G = $211
NOTE_PAL_O2_Gs = $1f3
NOTE_PAL_O2_A = $1d7
NOTE_PAL_O2_As = $1bd
NOTE_PAL_O2_B = $1a4
NOTE_PAL_O3_C = $18c
NOTE_PAL_O3_Cs = $176
NOTE_PAL_O3_D = $161
NOTE_PAL_O3_Ds = $14d
NOTE_PAL_O3_E = $13a
NOTE_PAL_O3_F = $129
NOTE_PAL_O3_Fs = $118
NOTE_PAL_O3_G = $108
NOTE_PAL_O3_Gs = $0f9
NOTE_PAL_O3_A = $0eb
NOTE_PAL_O3_As = $0de
NOTE_PAL_O3_B = $0d1
NOTE_PAL_O4_C = $0c6
NOTE_PAL_O4_Cs = $0ba
NOTE_PAL_O4_D = $0b0
NOTE_PAL_O4_Ds = $0a6
NOTE_PAL_O4_E = $09d
NOTE_PAL_O4_F = $094
NOTE_PAL_O4_Fs = $08b
NOTE_PAL_O4_G = $084
NOTE_PAL_O4_Gs = $07c
NOTE_PAL_O4_A = $075
NOTE_PAL_O4_As = $06e
NOTE_PAL_O4_B = $068
NOTE_PAL_O5_C = $062
NOTE_PAL_O5_Cs = $05d
NOTE_PAL_O5_D = $057
NOTE_PAL_O5_Ds = $052
NOTE_PAL_O5_E = $04e
NOTE_PAL_O5_F = $049
NOTE_PAL_O5_Fs = $045
NOTE_PAL_O5_G = $041
NOTE_PAL_O5_Gs = $03e
NOTE_PAL_O5_A = $03a
NOTE_PAL_O5_As = $037
NOTE_PAL_O5_B = $034
NOTE_PAL_O6_C = $031
NOTE_PAL_O6_Cs = $02e
NOTE_PAL_O6_D = $02b
NOTE_PAL_O6_Ds = $029
NOTE_PAL_O6_E = $026
NOTE_PAL_O6_F = $024
NOTE_PAL_O6_Fs = $022
NOTE_PAL_O6_G = $020
NOTE_PAL_O6_Gs = $01e
NOTE_PAL_O6_A = $01d
NOTE_PAL_O6_As = $01b
NOTE_PAL_O6_B = $019
NOTE_PAL_O7_C = $018
NOTE_PAL_O7_Cs = $016
NOTE_PAL_O7_D = $015
NOTE_PAL_O7_Ds = $014
NOTE_PAL_O7_E = $013
NOTE_PAL_O7_F = $012
NOTE_PAL_O7_Fs = $011
NOTE_PAL_O7_G = $010
NOTE_PAL_O7_Gs = $00f
NOTE_PAL_O7_A = $00e
NOTE_PAL_O7_As = $00d
NOTE_PAL_O7_B = $00c

NOTE_NTSC_O0_C = $7ff
NOTE_NTSC_O0_Cs = $7ff
NOTE_NTSC_O0_D = $7ff
NOTE_NTSC_O0_Ds = $7ff
NOTE_NTSC_O0_E = $7ff
NOTE_NTSC_O0_F = $7ff
NOTE_NTSC_O0_Fs = $7ff
NOTE_NTSC_O0_G = $7ff
NOTE_NTSC_O0_Gs = $7ff
NOTE_NTSC_O0_A = $7f1
NOTE_NTSC_O0_As = $780
NOTE_NTSC_O0_B = $713
NOTE_NTSC_O1_C = $6ad
NOTE_NTSC_O1_Cs = $64d
NOTE_NTSC_O1_D = $5f3
NOTE_NTSC_O1_Ds = $59d
NOTE_NTSC_O1_E = $54d
NOTE_NTSC_O1_F = $500
NOTE_NTSC_O1_Fs = $4b8
NOTE_NTSC_O1_G = $475
NOTE_NTSC_O1_Gs = $435
NOTE_NTSC_O1_A = $3f8
NOTE_NTSC_O1_As = $3bf
NOTE_NTSC_O1_B = $389
NOTE_NTSC_O2_C = $356
NOTE_NTSC_O2_Cs = $326
NOTE_NTSC_O2_D = $2f9
NOTE_NTSC_O2_Ds = $2ce
NOTE_NTSC_O2_E = $2a6
NOTE_NTSC_O2_F = $27f
NOTE_NTSC_O2_Fs = $25c
NOTE_NTSC_O2_G = $23a
NOTE_NTSC_O2_Gs = $21a
NOTE_NTSC_O2_A = $1fb
NOTE_NTSC_O2_As = $1df
NOTE_NTSC_O2_B = $1c4
NOTE_NTSC_O3_C = $1ab
NOTE_NTSC_O3_Cs = $193
NOTE_NTSC_O3_D = $17c
NOTE_NTSC_O3_Ds = $167
NOTE_NTSC_O3_E = $152
NOTE_NTSC_O3_F = $13f
NOTE_NTSC_O3_Fs = $12d
NOTE_NTSC_O3_G = $11c
NOTE_NTSC_O3_Gs = $10c
NOTE_NTSC_O3_A = $0fd
NOTE_NTSC_O3_As = $0ef
NOTE_NTSC_O3_B = $0e2
NOTE_NTSC_O4_C = $0d2
NOTE_NTSC_O4_Cs = $0c9
NOTE_NTSC_O4_D = $0bd
NOTE_NTSC_O4_Ds = $0b3
NOTE_NTSC_O4_E = $0a9
NOTE_NTSC_O4_F = $09f
NOTE_NTSC_O4_Fs = $096
NOTE_NTSC_O4_G = $08e
NOTE_NTSC_O4_Gs = $086
NOTE_NTSC_O4_A = $07e
NOTE_NTSC_O4_As = $077
NOTE_NTSC_O4_B = $070
NOTE_NTSC_O5_C = $06a
NOTE_NTSC_O5_Cs = $064
NOTE_NTSC_O5_D = $05e
NOTE_NTSC_O5_Ds = $059
NOTE_NTSC_O5_E = $054
NOTE_NTSC_O5_F = $04f
NOTE_NTSC_O5_Fs = $04b
NOTE_NTSC_O5_G = $046
NOTE_NTSC_O5_Gs = $042
NOTE_NTSC_O5_A = $03f
NOTE_NTSC_O5_As = $03b
NOTE_NTSC_O5_B = $038
NOTE_NTSC_O6_C = $034
NOTE_NTSC_O6_Cs = $031
NOTE_NTSC_O6_D = $02f
NOTE_NTSC_O6_Ds = $02c
NOTE_NTSC_O6_E = $029
NOTE_NTSC_O6_F = $027
NOTE_NTSC_O6_Fs = $025
NOTE_NTSC_O6_G = $023
NOTE_NTSC_O6_Gs = $021
NOTE_NTSC_O6_A = $01f
NOTE_NTSC_O6_As = $01d
NOTE_NTSC_O6_B = $01b
NOTE_NTSC_O7_C = $01a
NOTE_NTSC_O7_Cs = $018
NOTE_NTSC_O7_D = $017
NOTE_NTSC_O7_Ds = $015
NOTE_NTSC_O7_E = $014
NOTE_NTSC_O7_F = $013
NOTE_NTSC_O7_Fs = $012
NOTE_NTSC_O7_G = $011
NOTE_NTSC_O7_Gs = $010
NOTE_NTSC_O7_A = $00f
NOTE_NTSC_O7_As = $00e
NOTE_NTSC_O7_B = $00d
