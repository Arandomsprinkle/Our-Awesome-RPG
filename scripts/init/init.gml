#macro TILESIZE 16

enum GAME_STATE {
    TITLE,
    PLAYING,
    PAUSED,
    GAME_OVER,
    OPTIONS
}

global.game_state = GAME_STATE.TITLE;