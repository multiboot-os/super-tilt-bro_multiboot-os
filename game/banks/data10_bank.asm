.(
#echo
#echo ====== DATA-10-BANK =====
* = $8000

bank_data10_begin:

bank_data_cutscene_logic_begin:
#include "game/logic/cutscenes.asm"
#echo
#echo cutscenes logic size
#print *-bank_data_cutscene_logic_begin

bank_data_cutscene_sinbad_story_bird_msg_begin:
#include "game/data/cutscenes/sinbad_story_bird_msg/cutscene.asm"
#echo
#echo arcade cutscene sinbad story bird size:
#print *-bank_data_cutscene_sinbad_story_bird_msg_begin

bank_data_stage_arcade_btt01_begin:
#include "game/data/stages/arcade/btt01/stage_arcade_btt01.asm"
#echo
#echo stage arcade btt01 size:
#print *-bank_data_stage_arcade_btt01_begin

bank_data_arcade_btt_sprites_begin:
#include "game/data/arcade/btt_sprites_tileset.asm"
#echo
#echo arcade btt sprites size:
#print *-bank_data_arcade_btt_sprites_begin

bank_data_cutscene_sinbad_story_kiki_encounter_begin:
#include "game/data/cutscenes/sinbad_story_kiki_encounter/cutscene.asm"
#echo
#echo arcade cutscene sinbad story kiki encounter size:
#print *-bank_data_cutscene_sinbad_story_kiki_encounter_begin

bank_data_stage_arcade_boss_begin:
#include "game/data/stages/arcade/boss/stage_arcade_boss.asm"
#echo
#echo arcade stage boss size:
#print *-bank_data_stage_arcade_boss_begin

bank_data10_end:

#echo
#echo DATA-10-bank used size:
#print bank_data10_end-bank_data10_begin
#echo
#echo DATA-10-bank free space:
#print $c000-*

#if $c000-* < 0
#error Data bank occupies too much space
#else
.dsb $c000-*, CURRENT_BANK_NUMBER
#endif
.)