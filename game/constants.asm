#define INITIAL_GAME_STATE $01

#define DEFAULT_GRAVITY $03

#define PLAYER_STATE_THROWN #$00
#define PLAYER_STATE_RESPAWN #$01
#define PLAYER_STATE_INNEXISTANT #$02
#define PLAYER_STATE_SPAWN #$03
#define PLAYER_STATE_STANDING #$04
#define PLAYER_STATE_RUNNING #$05
#define PLAYER_STATE_FALLING #$06
#define PLAYER_STATE_JUMPING #$07
#define PLAYER_STATE_JABBING #$08
#define PLAYER_STATE_SIDE_TILT #$09
#define PLAYER_STATE_SPECIAL #$0a
#define PLAYER_STATE_SIDE_SPECIAL #$0b
#define PLAYER_STATE_HELPLESS #$0c
#define PLAYER_STATE_LANDING #$0d
#define PLAYER_STATE_CRASHING #$0e
#define PLAYER_STATE_DOWN_TILT #$0f
#define PLAYER_STATE_AERIAL_SIDE #$10
#define PLAYER_STATE_AERIAL_DOWN #$11
#define PLAYER_STATE_AERIAL_UP #$12
#define PLAYER_STATE_AERIAL_NEUTRAL #$13
#define PLAYER_STATE_AERIAL_SPE_NEUTRAL #$14
#define PLAYER_STATE_SPE_UP #$15
#define PLAYER_STATE_SPE_DOWN #$16
#define PLAYER_STATE_UP_TILT #$17
#define PLAYER_STATE_SHIELDING #$18
#define PLAYER_STATE_SHIELDLAG #$19

CHARACTERS_NUM_TILES_PER_CHAR = 96
CHARACTERS_CHARACTER_A_TILES_OFFSET = 0
CHARACTERS_CHARACTER_B_TILES_OFFSET = CHARACTERS_CHARACTER_A_TILES_OFFSET+(CHARACTERS_NUM_TILES_PER_CHAR*16)
CHARACTERS_END_TILES_OFFSET = 2*CHARACTERS_NUM_TILES_PER_CHAR*16

CHARACTERS_PROPERTIES_VICTORY_ANIM_OFFSET = 0
CHARACTERS_PROPERTIES_DEFEAT_ANIM_OFFSET = 2
CHARACTERS_PROPERTIES_CHAR_NAME_OFFSET = 4
CHARACTERS_PROPERTIES_WEAPON_NAME_OFFSET = 14

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

#define TILENUM_NT_CHAR_0 #$14

#define CONTROLLER_BTN_A      %10000000
#define CONTROLLER_BTN_B      %01000000
#define CONTROLLER_BTN_SELECT %00100000
#define CONTROLLER_BTN_START  %00010000
#define CONTROLLER_BTN_UP     %00001000
#define CONTROLLER_BTN_DOWN   %00000100
#define CONTROLLER_BTN_LEFT   %00000010
#define CONTROLLER_BTN_RIGHT  %00000001

#define CONTROLLER_INPUT_JUMP          CONTROLLER_BTN_UP
#define CONTROLLER_INPUT_JAB           CONTROLLER_BTN_A
#define CONTROLLER_INPUT_LEFT          CONTROLLER_BTN_LEFT
#define CONTROLLER_INPUT_RIGHT         CONTROLLER_BTN_RIGHT
#define CONTROLLER_INPUT_JUMP_RIGHT    CONTROLLER_BTN_UP | CONTROLLER_BTN_RIGHT
#define CONTROLLER_INPUT_JUMP_LEFT     CONTROLLER_BTN_UP | CONTROLLER_BTN_LEFT
#define CONTROLLER_INPUT_ATTACK_LEFT   CONTROLLER_BTN_LEFT | CONTROLLER_BTN_A
#define CONTROLLER_INPUT_ATTACK_RIGHT  CONTROLLER_BTN_RIGHT | CONTROLLER_BTN_A
#define CONTROLLER_INPUT_ATTACK_UP     CONTROLLER_BTN_UP | CONTROLLER_BTN_A
#define CONTROLLER_INPUT_SPECIAL       CONTROLLER_BTN_B
#define CONTROLLER_INPUT_SPECIAL_RIGHT CONTROLLER_BTN_B | CONTROLLER_BTN_RIGHT
#define CONTROLLER_INPUT_SPECIAL_LEFT  CONTROLLER_BTN_B | CONTROLLER_BTN_LEFT
#define CONTROLLER_INPUT_SPECIAL_DOWN  CONTROLLER_BTN_B | CONTROLLER_BTN_DOWN
#define CONTROLLER_INPUT_SPECIAL_UP    CONTROLLER_BTN_B | CONTROLLER_BTN_UP
#define CONTROLLER_INPUT_TECH          CONTROLLER_BTN_DOWN
#define CONTROLLER_INPUT_TECH_RIGHT    CONTROLLER_BTN_DOWN | CONTROLLER_BTN_RIGHT
#define CONTROLLER_INPUT_TECH_LEFT     CONTROLLER_BTN_DOWN | CONTROLLER_BTN_LEFT
#define CONTROLLER_INPUT_DOWN_TILT     CONTROLLER_BTN_DOWN | CONTROLLER_BTN_A

#define GAME_STATE_INGAME $00
#define GAME_STATE_TITLE $01
#define GAME_STATE_GAMEOVER $02
#define GAME_STATE_CREDITS $03
#define GAME_STATE_CONFIG $04
#define GAME_STATE_STAGE_SELECTION $05
#define GAME_STATE_CHARACTER_SELECTION $06

#define ZERO_PAGE_GLOBAL_FIELDS_BEGIN $c0

#define STAGE_ELEMENT_PLATFORM $01
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
#define STAGE_OFFSET_PLATFORMS 12
#define STAGE_PLATFORM_OFFSET_LEFT 1
#define STAGE_PLATFORM_OFFSET_RIGHT 2
#define STAGE_PLATFORM_OFFSET_TOP 3
#define STAGE_PLATFORM_OFFSET_BOTTOM 4
#define STAGE_PLATFORM_LENGTH 5
#define STAGE_SMOOTH_PLATFORM_LENGTH 4

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
#define MENU_COMMON_NB_SPRITE_PER_CLOUD 6
#define MENU_COMMON_FIRST_CLOUD_SPRITE (64 - MENU_COMMON_NB_SPRITE_PER_CLOUD * MENU_COMMON_NB_CLOUDS)

#define NOTE_O0_C $7ff
#define NOTE_O0_Cs $7ff
#define NOTE_O0_D $7ff
#define NOTE_O0_Ds $7ff
#define NOTE_O0_E $7ff
#define NOTE_O0_F $7ff
#define NOTE_O0_Fs $7ff
#define NOTE_O0_G $7ff
#define NOTE_O0_Gs $7d1
#define NOTE_O0_A $760
#define NOTE_O0_As $6f6
#define NOTE_O0_B $692
#define NOTE_O1_C $634
#define NOTE_O1_Cs $5da
#define NOTE_O1_D $586
#define NOTE_O1_Ds $537
#define NOTE_O1_E $4ec
#define NOTE_O1_F $4a5
#define NOTE_O1_Fs $462
#define NOTE_O1_G $423
#define NOTE_O1_Gs $3e8
#define NOTE_O1_A $3b0
#define NOTE_O1_As $37b
#define NOTE_O1_B $349
#define NOTE_O2_C $319
#define NOTE_O2_Cs $2ed
#define NOTE_O2_D $2c3
#define NOTE_O2_Ds $29b
#define NOTE_O2_E $276
#define NOTE_O2_F $252
#define NOTE_O2_Fs $231
#define NOTE_O2_G $211
#define NOTE_O2_Gs $1f3
#define NOTE_O2_A $1d7
#define NOTE_O2_As $1bd
#define NOTE_O2_B $1a4
#define NOTE_O3_C $18c
#define NOTE_O3_Cs $176
#define NOTE_O3_D $161
#define NOTE_O3_Ds $14d
#define NOTE_O3_E $13a
#define NOTE_O3_F $129
#define NOTE_O3_Fs $118
#define NOTE_O3_G $108
#define NOTE_O3_Gs $0f9
#define NOTE_O3_A $0eb
#define NOTE_O3_As $0de
#define NOTE_O3_B $0d1
#define NOTE_O4_C $0c6
#define NOTE_O4_Cs $0ba
#define NOTE_O4_D $0b0
#define NOTE_O4_Ds $0a6
#define NOTE_O4_E $09d
#define NOTE_O4_F $094
#define NOTE_O4_Fs $08b
#define NOTE_O4_G $084
#define NOTE_O4_Gs $07c
#define NOTE_O4_A $075
#define NOTE_O4_As $06e
#define NOTE_O4_B $068
#define NOTE_O5_C $062
#define NOTE_O5_Cs $05d
#define NOTE_O5_D $057
#define NOTE_O5_Ds $052
#define NOTE_O5_E $04e
#define NOTE_O5_F $049
#define NOTE_O5_Fs $045
#define NOTE_O5_G $041
#define NOTE_O5_Gs $03e
#define NOTE_O5_A $03a
#define NOTE_O5_As $037
#define NOTE_O5_B $034
#define NOTE_O6_C $031
#define NOTE_O6_Cs $02e
#define NOTE_O6_D $02b
#define NOTE_O6_Ds $029
#define NOTE_O6_E $026
#define NOTE_O6_F $024
#define NOTE_O6_Fs $022
#define NOTE_O6_G $020
#define NOTE_O6_Gs $01e
#define NOTE_O6_A $01d
#define NOTE_O6_As $01b
#define NOTE_O6_B $019
#define NOTE_O7_C $018
#define NOTE_O7_Cs $016
#define NOTE_O7_D $015
#define NOTE_O7_Ds $014
#define NOTE_O7_E $013
#define NOTE_O7_F $012
#define NOTE_O7_Fs $011
#define NOTE_O7_G $010
#define NOTE_O7_Gs $00f
#define NOTE_O7_A $00e
#define NOTE_O7_As $00d
#define NOTE_O7_B $00c
