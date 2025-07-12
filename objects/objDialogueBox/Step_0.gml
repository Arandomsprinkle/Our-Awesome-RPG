/// @description Insert description here
// You can write your code in this editor

var _inputPressed = keyboard_check_pressed(ord("F")) || keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter);
var _keyUp = keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))
var _keyDown = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))
var _inputHandled = false;

if (!isTyping && !isWaiting && array_length(dialogueQueue) > 0) {
	var _entry = array_shift(dialogueQueue);

	currentText = _entry.text;
	portrait = _entry.portrait;
	call = _entry.call;

	//Queue choices if there are any
	pendingChoices = !is_undefined(_entry.choices) ? _entry.choices : undefined;

	textDisplayed = "";
	charIndex = 0;
	charTimer = 0;
	isTyping = true;
	isWaiting = false;
	visible = true;
	global.isPaused = 1;
}

// Typing text
if (isTyping) {
	charTimer++;

	if (charTimer >= global.textSpeed && charIndex < string_length(currentText)) {
	    charIndex++;
	    textDisplayed = string_copy(currentText, 1, charIndex);
	    charTimer = 0;
	    audio_play_sound(text01, 1, 0, 0.5, 0, random_range(0.8, 1.2));
	}

	if (_inputPressed && charIndex < string_length(currentText)) {
	    charIndex = string_length(currentText);
	    textDisplayed = currentText;
	    charTimer = 0;
	    isTyping = false;
	    isWaiting = true;
	    _inputHandled = true;
	}

	if (charIndex >= string_length(currentText)) {
	    isTyping = false;
	    isWaiting = true;
	}
}

// Choices
if (isWaiting && array_length(choices) > 0) {
	if (_keyUp) {
	    selectedChoice = (selectedChoice - 1 + array_length(choices)) mod array_length(choices);
	}

	if (_keyDown) {
	    selectedChoice = (selectedChoice + 1) mod array_length(choices);
	}

	if (_inputPressed) {
		var _choice = choices[selectedChoice];
		isWaiting = false;
		choices = [];
		selectedChoice = 0;

		if (is_callable(_choice.call)) {
			call = noone;
			_choice.call();
		}
	}
}

if (isWaiting && !_inputHandled && _inputPressed) {
	isWaiting = false;

	//Show Choices
	if (!is_undefined(pendingChoices)) {
	    choices = [];
	    selectedChoice = 0;

	    for (var i = 0; i < array_length(pendingChoices); i++) {
	        array_push(choices, pendingChoices[i]);
	    }

	    pendingChoices = undefined;
	    isWaiting = true;
	    return; //wait for choice
	}

	//Otherwise clear box
	if (array_length(dialogueQueue) == 0) {
		visible = false;
		global.isPaused = 0;
		portrait = -1;
		currentText = "";
		textDisplayed = "";
		charIndex = 0;
		charTimer = 0;
		isTyping = false;
		isWaiting = false;

		if (is_callable(call)) {
		    call();
		}

		call = noone;
	}
}



/* Old no choice
var _inputPressed = keyboard_check_pressed(ord("F")) || keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter);
var _inputHandled = false;

if (!isTyping && !isWaiting && array_length(dialogueQueue) > 0) {
    var _entry = array_shift(dialogueQueue);

    currentText = _entry.text;
    portrait = _entry.portrait;
    call = _entry.call;

    textDisplayed = "";
    charIndex = 0;
    charTimer = 0;
    isTyping = true;
    isWaiting = false;
    visible = true;
	global.isPaused = 1;
}

//Typewriter the message
if (isTyping) {
    charTimer++;

    if (charTimer >= global.textSpeed && charIndex < string_length(currentText)) {
        charIndex++;
        textDisplayed = string_copy(currentText, 1, charIndex);
        charTimer = 0;
		//if !audio_is_playing(text02) {audio_play_sound(text02,1,0)} //for super short files so it doesn't overlap.
		audio_play_sound(text01,1,0,0.5,0,random_range(0.8,1.2)) //We'll mess around with this obvi
    }

    if (_inputPressed && charIndex < string_length(currentText)) {
        charIndex = string_length(currentText);
        textDisplayed = currentText;
        charTimer = 0;
        isTyping = false;
        isWaiting = true;
        _inputHandled = true;
    }

    if (charIndex >= string_length(currentText)) {
        isTyping = false;
        isWaiting = true;
    }
}

if (isWaiting && !_inputHandled && _inputPressed) {
    isWaiting = false;

    if (array_length(dialogueQueue) == 0) {
        visible = false;
		global.isPaused = 0;
        portrait = -1;
        currentText = "";
        textDisplayed = "";
        charIndex = 0;
        charTimer = 0;
        isTyping = false;
        isWaiting = false;

        if (is_callable(call)) {
            call();
        }

        call = noone;
    }
}