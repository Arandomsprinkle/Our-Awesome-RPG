var _player_nearby = collision_circle(x, y, interact_range, objPlayer, false, true);
if (instance_exists(objPlayer)) {
	player_in_range = true;
} else {
	player_in_range = false;
}