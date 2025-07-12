/// @description Insert description here
// You can write your code in this editor

/// @description Insert description here
// You can write your code in this editor

if (visible) {
    //Main Box
    var boxX = 8;
    var boxW = display_get_gui_width() - 16;
    var boxH = 96;
    var boxY = display_get_gui_height() - boxH - 8;

    draw_set_color(c_white);
    draw_rectangle(boxX - 1, boxY - 1, boxX + boxW + 1, boxY + boxH + 1, false);

    draw_set_color(make_color_rgb(20, 20, 20));
    draw_rectangle(boxX, boxY, boxX + boxW, boxY + boxH, false);

    //Text and Portrait
    var textX = boxX + 8;
    var textY = boxY + 8;

    if (portrait != -1) {
        draw_sprite(portrait, 0, textX, textY);
        textX += portraitPadding;
    }

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
    draw_text_ext(textX, textY, textDisplayed, -1, boxW - (textX - boxX) - 8);

    //Choices Box
    if (array_length(choices) > 0) {
        var choicePadding = 12;
        var choiceW = 180;
        var choiceH = array_length(choices) * 18 + choicePadding * 2;
        var choiceX = boxX + boxW - choiceW;
        var choiceY = boxY - choiceH - 8;

        draw_set_color(c_white);
        draw_rectangle(choiceX - 1, choiceY - 1, choiceX + choiceW + 1, choiceY + choiceH + 1, false);

        draw_set_color(make_color_rgb(20, 20, 20));
        draw_rectangle(choiceX, choiceY, choiceX + choiceW, choiceY + choiceH, false);

        draw_set_halign(fa_right);
        draw_set_valign(fa_top);
        draw_set_color(c_white);
		
		//Choice Labels
        var labelX = choiceX + choiceW - choicePadding;
        var labelYStart = choiceY + choicePadding;

        for (var i = 0; i < array_length(choices); i++) {
            var lineY = labelYStart + i * 18;

            if (i == selectedChoice) {
                draw_set_color(make_color_rgb(50, 50, 50));
                draw_rectangle(choiceX + 1, lineY - 2, choiceX + choiceW - 1, lineY + 14, false);
                draw_set_color(c_white);
            }
            draw_text(labelX, lineY, choices[i].label);
        }
    }
}


/* Old no choice
if (visible) {
	//Textbox dimensions
	var _boxX = 8;
	var _boxH = 96;
	var _boxY = display_get_gui_height() - _boxH - 8;
	var _boxW = display_get_gui_width() - 16;

    //Draw box outline
    draw_set_color(c_white);
    draw_rectangle(_boxX - 1, _boxY - 1, _boxX + _boxW + 1, _boxY + _boxH + 1, false);

    //Draw box
    draw_set_color(make_color_rgb(20, 20, 20));
    draw_rectangle(_boxX, _boxY, _boxX + _boxW, _boxY + _boxH, false);

    //Draw portrait if available
    var _textX = _boxX + 8;
    var _textY = _boxY + 8;
    if (portrait != -1) {
        draw_sprite(portrait, 0, _textX, _textY);
        _textX += portraitPadding;
    }

    draw_set_color(c_white);
	draw_set_halign(fa_left); // ← you need this back before drawing dialogue
	draw_text_ext(_textX, _textY, textDisplayed, -1, _boxW - (_textX - _boxX) - 8);

	
	
	
	if (array_length(choices) > 0) {
	    var _boxPadding = 16;
	    var _choiceBoxW = 160;
	    var _choiceBoxH = array_length(choices) * 18 + _boxPadding * 2;
	    var _choiceBoxX = _boxX + _boxW - _choiceBoxW - 8; // right of dialogue box
	    var _choiceBoxY = _boxY - _choiceBoxH - 8;         // above dialogue box

	    // Box outline
	    draw_set_color(c_white);
	    draw_rectangle(_choiceBoxX - 1, _choiceBoxY - 1, _choiceBoxX + _choiceBoxW + 1, _choiceBoxY + _choiceBoxH + 1, false);

	    // Box fill
	    draw_set_color(make_color_rgb(20, 20, 20));
	    draw_rectangle(_choiceBoxX, _choiceBoxY, _choiceBoxX + _choiceBoxW, _choiceBoxY + _choiceBoxH, false);

	    // Text setup
	    draw_set_color(c_white);
	    draw_set_halign(fa_right); // align right

	    var _textX = _choiceBoxX + _choiceBoxW - _boxPadding;
	    var _textY = _choiceBoxY + _boxPadding;

	    for (var i = 0; i < array_length(choices); i++) {
	        var _lineY = _textY + i * 18;

	        // Highlight background for selected choice
	        if (i == selectedChoice) {
	            draw_set_color(make_color_rgb(50, 50, 50));
	            draw_rectangle(_choiceBoxX + 1, _lineY - 2, _choiceBoxX + _choiceBoxW - 1, _lineY + 14, false);
	            draw_set_color(c_white);
	        }

	        draw_text(_textX, _lineY, choices[i].label);
	    }

	    draw_set_halign(fa_left); // reset alignment
	}

}


