#include <cstb.h>


///////////////////////////////////////
// Global labels from the ASM codebase
///////////////////////////////////////

extern uint8_t const charset_alphanum;
extern uint8_t const menu_mode_selection_palette;
extern uint8_t const nametable_mode_selection;
extern uint8_t const tileset_menu_mode_selection;

// Labels, use their address or the associtated *_bank() function
extern uint8_t const CHARSET_ALPHANUM_BANK_NUMBER;
extern uint8_t const MENU_MODE_SELECTION_SCREEN_BANK;
extern uint8_t const MENU_MODE_SELECTION_TILESET_BANK;

///////////////////////////////////////
// Constants specific to this file
///////////////////////////////////////

static uint8_t const NB_OPTIONS = 3;
static uint8_t const OPTION_LOCAL = 0;
static uint8_t const OPTION_ONLINE = 1;
static uint8_t const OPTION_SUPPORT = 2;

///////////////////////////////////////
// Utility functions
///////////////////////////////////////

#define ATT(br, bl, tr, tl) ((br << 6) + (bl << 4) + (tr << 2) + tl)

static uint8_t charset_bank() {
	return ptr_lsb(&CHARSET_ALPHANUM_BANK_NUMBER);
}

static uint8_t screen_bank() {
	return ptr_lsb(&MENU_MODE_SELECTION_SCREEN_BANK);
}

static uint8_t tileset_bank() {
	return ptr_lsb(&MENU_MODE_SELECTION_TILESET_BANK);
}

///////////////////////////////////////
// State implementation
///////////////////////////////////////

static void go_up() {
	audio_play_interface_click();
	if (*mode_selection_current_option == OPTION_SUPPORT) {
		*mode_selection_current_option = OPTION_LOCAL;
	}else {
		*mode_selection_current_option = OPTION_SUPPORT;
	}
}

static void go_down() {
	go_up();
}

static void go_left() {
	audio_play_interface_click();
	if (*mode_selection_current_option > 0) {
		--*mode_selection_current_option;
	}else {
		*mode_selection_current_option = NB_OPTIONS - 1;
	}
}

static void go_right() {
	audio_play_interface_click();
	++*mode_selection_current_option;
	if (*mode_selection_current_option >= NB_OPTIONS) {
		*mode_selection_current_option = 0;
	}
}

static void previous_screen() {
	audio_play_interface_click();
	wrap_change_global_game_state(GAME_STATE_TITLE);
}

static void next_screen() {
	static uint8_t const option_to_game_state[] = {GAME_STATE_CONFIG, GAME_STATE_ONLINE_MODE_SELECTION, GAME_STATE_DONATION};

	if (no_network()) {
		if (*mode_selection_current_option == OPTION_ONLINE) {
			return;
		}
	}

	audio_play_interface_click();
	*config_game_mode = *mode_selection_current_option;
	wrap_change_global_game_state(option_to_game_state[*mode_selection_current_option]);
}

static void show_selected_option() {
	static uint8_t const nt_highlight_header[] = {0x23, 0xd1, 0x15};
	static uint8_t const nt_highlight_payload[][21] = {
		{
			/**/          ATT(1,1,1,1), ATT(1,1,1,1), ATT(1,1,1,1), ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0),
			ATT(0,0,0,0), ATT(1,1,1,1), ATT(1,1,1,1), ATT(1,1,1,1), ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0),
			ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0),
		},
		{
			/**/          ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0), ATT(1,1,1,1), ATT(1,1,1,1), ATT(1,1,1,1), ATT(1,1,1,1),
			ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0), ATT(1,1,1,1), ATT(1,1,1,1), ATT(1,1,1,1), ATT(1,1,1,1),
			ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0),
		},
		{
			/**/          ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0),
			ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0),
			ATT(0,0,0,0), ATT(0,0,0,0), ATT(1,1,1,1), ATT(1,1,1,1), ATT(1,1,1,1), ATT(1,1,1,1),
		},
	};
	static uint8_t const nt_highlight_payload_no_network[][21] = {
		{
			/**/          ATT(1,1,1,1), ATT(1,1,1,1), ATT(1,1,1,1), ATT(3,3,3,3), ATT(3,3,3,3), ATT(3,3,3,3), ATT(3,3,3,3),
			ATT(0,0,0,0), ATT(1,1,1,1), ATT(1,1,1,1), ATT(1,1,1,1), ATT(3,3,3,3), ATT(3,3,3,3), ATT(3,3,3,3), ATT(3,3,3,3),
			ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0),
		},
		{
			/**/          ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0), ATT(2,2,2,2), ATT(2,2,2,2), ATT(2,2,2,2), ATT(2,2,2,2),
			ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0), ATT(2,2,2,2), ATT(2,2,2,2), ATT(2,2,2,2), ATT(2,2,2,2),
			ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0),
		},
		{
			/**/          ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0), ATT(3,3,3,3), ATT(3,3,3,3), ATT(3,3,3,3), ATT(3,3,3,3),
			ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0), ATT(0,0,0,0), ATT(3,3,3,3), ATT(3,3,3,3), ATT(3,3,3,3), ATT(3,3,3,3),
			ATT(0,0,0,0), ATT(0,0,0,0), ATT(1,1,1,1), ATT(1,1,1,1), ATT(1,1,1,1), ATT(1,1,1,1),
		},
	};

	if (no_network()) {
		wrap_construct_nt_buffer(nt_highlight_header, nt_highlight_payload_no_network[*mode_selection_current_option]);
	}else {
		wrap_construct_nt_buffer(nt_highlight_header, nt_highlight_payload[*mode_selection_current_option]);
	}
}

void init_mode_selection_screen_extra() {
	// Draw screen
	long_construct_palettes_nt_buffer(screen_bank(), &menu_mode_selection_palette);
	long_draw_zipped_nametable(screen_bank(), &nametable_mode_selection);
	long_cpu_to_ppu_copy_tileset_background(tileset_bank(), &tileset_menu_mode_selection);
	long_cpu_to_ppu_copy_charset(charset_bank(), &charset_alphanum, 0x1dc0, 1, 3);

	// Setup common menu effects
	re_init_menu();

	// Initialize state
	*mode_selection_current_option = *config_game_mode;
	show_selected_option();
}

void mode_selection_screen_tick_extra() {
	reset_nt_buffers();

	// Play common menus effects
	tick_menu();

	// Check if a button is released and trigger correct action
	for (uint8_t controller = 0; controller < 2; ++controller) {
		if (*(controller_a_btns + controller) == 0) {
			switch (*(controller_a_last_frame_btns + controller)) {
				case CONTROLLER_BTN_UP:
					go_up(); break;
				case CONTROLLER_BTN_DOWN:
					go_down(); break;
				case CONTROLLER_BTN_LEFT:
					go_left(); break;
				case CONTROLLER_BTN_RIGHT:
					go_right(); break;
				case CONTROLLER_BTN_B:
					previous_screen(); break;
				case CONTROLLER_BTN_START:
				case CONTROLLER_BTN_A:
					next_screen(); break;
			}
		}
	}

	show_selected_option();
}
