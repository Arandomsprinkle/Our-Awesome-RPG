var _upKey = keyboard_check(vk_up) || keyboard_check(ord("W"));
var _downKey = keyboard_check(vk_down) || keyboard_check(ord("S"));
var _selectKey = keyboard_check(vk_enter) || keyboard_check(vk_space);

if (_upKey && !keyUpPressed) {
	selectedButtonIndex = (selectedButtonIndex - 1 + array_length(menuItems)) % array_length(menuItems);
	keyUpPressed = true;
} else if (!_upKey) {
	keyUpPressed = false;
}
if (_downKey && !keyDownPressed) {
	selectedButtonIndex = (selectedButtonIndex + 1) % array_length(menuItems);
	keyDownPressed = true;
} else if (!_downKey) {
	keyDownPressed = false;
}
if (_selectKey && !keySelectedPressed) {
	var _action = menuItems[selectedButtonIndex][1];

	switch (_action) {
		case "startGame":
			global.game_state = GAME_STATE.PLAYING;
			room_goto(rmSandbox);
			break;
		case "quitGame":
			game_end();
			break;
	}
	keySelectedPressed = true;
} else if (!_selectKey) {
	keySelectedPressed = false;
}