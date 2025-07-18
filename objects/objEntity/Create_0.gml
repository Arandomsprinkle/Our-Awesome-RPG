/// @description Insert description here
// You can write your code in this editor


name = "";
hostile = false;
hp = 10;
hpMax = 10;
hp = 25;
hpMax = 25;
damage = 1;
canHit = true;
alive = true;
moving = false;
dir = 0; //Direction
moveSpeed = 1;
state = "wander";
wanderRadius = 5;
aggroRange = 0 * TILESIZE; //Obviously this ='s 0, just a reminder to * it by tilesize
target = noone;
lootTable = [];
canTalk = false;
dialogueState = {};

//Shared movement vars
moving = false;
moveX = 0;
moveY = 0;
startX = x;
startY = y;
targetX = x;
targetY = y;
totalDistance = 0;
directionIndex = 0;


pathDirection = {x: 0, y: 0};
pathTimer = 0;
pathCooldownMin = 30
pathCooldownMax = 120
pathCooldown = 0
spawnX = x;
spawnY = y;
fleeRange = 11;
oobTimer = 0;
oobTimeLimit = 180 //3 seconds for testing

tags = [];

//For Survivors
inventory = [];
keyItem = [];
schedule = {};

switches = {}; //not sure if I wanna use this, but it's here if I do.


//Put the function here for now, so I'm not changing too many files
//shitty localized A*
function get_local_path(_startX, _startY, _goalX, _goalY, _radius) {
    var _layerID = layer_tilemap_get_id("Collision");
    var _openSet = ds_priority_create();
    var _size = _radius * 2 + 1;
    var _centerX = _startX - _radius;
    var _centerY = _startY - _radius;
    var _gScore = array_create(_size * _size, -1);
    var _cameFrom = array_create(_size * _size, -1);
    var _startIndex = (_startY - _centerY) * _size + (_startX - _centerX);
	
    _gScore[_startIndex] = 0;
	
    ds_priority_add(_openSet, [_startX, _startY], 0);

    var _dirs = [
        {x: 1, y: 0}, {x:-1, y: 0}, {x: 0, y: 1}, {x: 0, y: -1},
        {x: 1, y: 1}, {x: -1, y: 1}, {x: 1, y: -1}, {x: -1, y: -1}
    ];

    var _found = false;

    while (!ds_priority_empty(_openSet)) {
        var _current = ds_priority_delete_min(_openSet);
        var _cx = _current[0];
        var _cy = _current[1];

        if (_cx == _goalX && _cy == _goalY) {
            _found = true;
            break;
        }

        var _currentIndex = (_cy - _centerY) * _size + (_cx - _centerX);
        var _g = _gScore[_currentIndex];

        for (var _i = 0; _i < 8; _i++) {
            var _nx = _cx + _dirs[_i].x;
            var _ny = _cy + _dirs[_i].y;

            if (abs(_nx - _startX) > _radius || abs(_ny - _startY) > _radius) continue;
            if (tilemap_get(_layerID, _nx, _ny) == 1) continue;		
			
			var _px = _nx * TILESIZE + TILESIZE / 2;
			var _py = _ny * TILESIZE + TILESIZE / 2;
			var _blocker = instance_position(_px, _py, objEntity);

			if (_blocker != noone && _blocker != id) continue;

            var _ni = (_ny - _centerY) * _size + (_nx - _centerX);
            var _newG = _g + 1;

            if (_gScore[_ni] == -1 || _newG < _gScore[_ni]) {
                _gScore[_ni] = _newG;
                _cameFrom[_ni] = _currentIndex;
                var _h = abs(_goalX - _nx) + abs(_goalY - _ny);
                ds_priority_add(_openSet, [_nx, _ny], _newG + _h);
            }
        }
    }

    var _dir = {x: 0, y: 0};

    if (_found) {
        var _gx = _goalX;
        var _gy = _goalY;
        var _gi = (_gy - _centerY) * _size + (_gx - _centerX);
        var _step = -1;
		
		if (_startX == _goalX && _startY == _goalY) {
		    ds_priority_destroy(_openSet);
		    return { x: 0, y: 0 };
		}

        while (_cameFrom[_gi] != -1) {
            _step = _gi;
            _gi = _cameFrom[_gi];
        }

        if (_step != -1) {
            var _sx = (_step mod _size) + _centerX;
            var _sy = (_step div _size) + _centerY;
            _dir = { x: _sx - _startX, y: _sy - _startY };
        }
    }

    ds_priority_destroy(_openSet);
    return _dir;
}