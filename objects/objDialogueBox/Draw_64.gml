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
		draw_set_halign(fa_left); //Forgot to reset this.
		draw_set_color(c_black);
    }
}

