#macro TILESIZE 16

enum GAME_STATE {
    TITLE,
    PLAYING,
    PAUSED,
    GAME_OVER,
    OPTIONS
}

global.game_state = GAME_STATE.TITLE;

global.keyInteract = ord("F");
global.keyUp = ord("W");
global.keyDown = ord("S");
global.keyLeft = ord("A");
global.keyRight = ord("D");
global.keyAttack = vk_space;
global.keyConfirm = vk_enter;
global.keyCancel = vk_escape;

global.textSpeed = 3;
global.isPaused = false;