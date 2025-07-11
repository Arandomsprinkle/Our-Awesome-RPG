/// @description Insert description here
// You can write your code in this editor

if (!global.cameraFollowEnabled || !instance_exists(objPlayer)) exit;

var _cam = view_camera[0];
var _viewW = camera_get_view_width(_cam);
var _viewH = camera_get_view_height(_cam);
var _px = objPlayer.x;
var _py = objPlayer.y;

//Region check
if (currentRegionIndex != -1) {
    var _curr = global.cameraRegions[currentRegionIndex];
    if (_px >= _curr.x1 && _px < _curr.x2 && _py >= _curr.y1 && _py < _curr.y2) {
        //Don't do anything, still inside region
    }
	
	else {
        //Not in same region, time to check again
        for (var i = 0; i < array_length(global.cameraRegions); i++) {
            var _r = global.cameraRegions[i];
            if (_px >= _r.x1 && _px < _r.x2 && _py >= _r.y1 && _py < _r.y2) {
                currentRegionIndex = i;
                break;
            }
        }
    }
}

//Init region
else {
    for (var i = 0; i < array_length(global.cameraRegions); i++) {
        var _r = global.cameraRegions[i];
        if (_px >= _r.x1 && _px < _r.x2 && _py >= _r.y1 && _py < _r.y2) {
            currentRegionIndex = i;
            break;
        }
    }
}

//keep the goddamn FUCKING CAMERA INSIDE THE BOUNDARIES >:OOOOOOOO
var _region = global.cameraRegions[currentRegionIndex];
var _targetX = _px - _viewW * 0.5;
var _targetY = _py - _viewH * 0.5;
var _margin = 16; //Just a dumb fix so that it shows a bit ouside, because I'm too dumb to figure it out otherwise

_targetX = clamp(_targetX, _region.x1 - _margin, _region.x2 - _viewW + _margin);
_targetY = clamp(_targetY, _region.y1 - _margin, _region.y2 - _viewH + _margin);

camera_set_view_pos(_cam, _targetX, _targetY);
