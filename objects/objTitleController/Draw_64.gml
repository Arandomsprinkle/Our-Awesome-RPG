/// @description Insert description here
// You can write your code in this editor
draw_set_font(fSilk);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);
draw_text(room_width / 2, room_height / 4, "LOW TIDE");
var _numItems = array_length(menuItems);
var _titleY = room_height / 4;
var _firstMenuItemY = _titleY + titleToMenuSpacing;
var _startY = _firstMenuItemY - ((_numItems - 1) * textSpacing / 2);
for (var i = 0; i < _numItems; i++) {
	var _textToDraw = menuItems[i][0];
	var _drawColor = c_white;
	if (i == selectedButtonIndex) {
		_drawColor = c_lime;
	}
	draw_set_color(_drawColor);
	draw_text(room_width / 2, _startY + (i * textSpacing), _textToDraw);
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);