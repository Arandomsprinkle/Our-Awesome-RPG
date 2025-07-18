/// @function start_dialogue(text_or_array, portrait, call, choices)
/// @desc Queue one or more dialogue messages

function start_dialogue(_text, _portrait = -1, _call = -1, _choices = undefined) {
	show_debug_message("start dialogue has been called");
    if (!instance_exists(objDialogueBox)) return;

    with (objDialogueBox) {
        var _entry = {
            text: _text,
            portrait: _portrait,
            call: _call,
            choices: _choices // new field
        };

        array_push(dialogueQueue, _entry);
    }
}

/*
function show_choices(_labels, _callbacks) {
    if (!instance_exists(objDialogueBox)) return;

    with (objDialogueBox) {
        choices = [];
        selectedChoice = 0;

        for (var i = 0; i < array_length(_labels); i++) {
            array_push(choices, {
                label: _labels[i],
                call: _callbacks[i]
            });
        }

        isTyping = false;
        isWaiting = true;
        visible = true;
    }
}



/* OLD NO OPTIONS (just in case)
function start_dialogue(_input, _portrait = -1, _call = -1) {
    if (!instance_exists(objDialogueBox)) {
        show_debug_message("Dialogue system not found.");
        return;
    }

    with (objDialogueBox) {
        if (is_array(_input)) {
            for (var _i = 0; _i < array_length(_input); _i++) {
                var _entry = {
                    text: _input[_i],
                    portrait: _portrait,
                    call: _call
                };
                array_push(dialogueQueue, _entry);
            }
        }
		
		else {
            var _entry = {
                text: _input,
                portrait: _portrait,
                call: _call
            };
            array_push(dialogueQueue, _entry);
        }
    }
}


