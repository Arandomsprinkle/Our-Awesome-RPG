/// @description Insert description here
// You can write your code in this editor

if (global.isPaused) exit;

var _tm     = layer_tilemap_get_id("Collision");
var _myTX   = x div TILESIZE;
var _myTY   = y div TILESIZE;
var _sTX    = spawnX div TILESIZE;
var _sTY    = spawnY div TILESIZE;
var _pTX    = objPlayer.x div TILESIZE;
var _pTY    = objPlayer.y div TILESIZE;

//State Machine
switch (state) {

    case "idle":
        var _distToPlayer = max(abs(_pTX - _myTX), abs(_pTY - _myTY));

        if (_distToPlayer <= 2) {
            var _fdx = _pTX - _myTX;
            var _fdy = _pTY - _myTY;
            directionIndex = (round(point_direction(0, 0, _fdx, _fdy) / 45)) mod 8;
        }
		
		else {
            directionIndex = 6;
        }

        image_index = directionIndex * 3;
        break;

    case "wander":
        if (!hostile) {
            var _dxSpawn = abs(_myTX - _sTX);
            var _dySpawn = abs(_myTY - _sTY);

			if (_dxSpawn > wanderRadius || _dySpawn > wanderRadius) {
			    oobTimer++;
				
			    if (oobTimer >= oobTimeLimit) {
			        x = spawnX;
			        y = spawnY;
			        oobTimer = 0;
			        moving = false;
			        pathDirection = { x: 0, y: 0 };
			        pathCooldown = irandom_range(pathCooldownMin, pathCooldownMax);
			    }
			}
			
			else {
			    oobTimer = 0;
			}
        }

        if (!moving) {
            pathTimer++;
			
            if (pathTimer >= pathCooldown) {
                pathTimer = 0;

                var _dirs = [
                    {x: 1, y: 0}, {x:-1, y: 0}, {x: 0, y: 1}, {x: 0, y:-1},
                    {x: 1, y: 1}, {x:-1, y: 1}, {x: 1, y:-1}, {x:-1, y:-1},
                    {x: 0, y: 0}
                ];
                var _valid = [];

                for (var i = 0; i < array_length(_dirs); i++) {
                    var _d = _dirs[i];
                    var _nx = x + _d.x * TILESIZE;
                    var _ny = y + _d.y * TILESIZE;
                    var _dx = abs(_nx - spawnX) div TILESIZE;
                    var _dy = abs(_ny - spawnY) div TILESIZE;

                    if (_dx <= wanderRadius && _dy <= wanderRadius) {
                        array_push(_valid, _d);
                    }
                }

                if (array_length(_valid) > 0) {
                    pathDirection = _valid[irandom(array_length(_valid) - 1)];
					
                    if (pathDirection.x != 0 || pathDirection.y != 0) {
                        directionIndex = (round(point_direction(0, 0, pathDirection.x, pathDirection.y) / 45)) mod 8;
                    }
                }
				
				else {
                    pathDirection = { x: 0, y: 0 };
                }
            }
        }
        break;

    case "hostile":
        if (!moving) {
            pathTimer++;
			
            if (pathTimer >= pathCooldown) {
                pathTimer = 0;

                var _dist = max(abs(_pTX - _myTX), abs(_pTY - _myTY));
				
                if (_dist > fleeRange) {
                    hostile = false;
                    state = "wander";
                    break;
                }

                pathDirection = get_local_path(_myTX, _myTY, _pTX, _pTY, 10);
				
                if (pathDirection.x != 0 || pathDirection.y != 0) {
                    directionIndex = (round(point_direction(0, 0, pathDirection.x, pathDirection.y) / 45)) mod 8;
                }
            }
        }
        break;
}

//Movement Planning
if (!moving && (pathDirection.x != 0 || pathDirection.y != 0)) {
    startX  = x;
    startY  = y;
    targetX = x + pathDirection.x * TILESIZE;
    targetY = y + pathDirection.y * TILESIZE;

    var _tX = targetX div TILESIZE;
    var _tY = targetY div TILESIZE;
    var _tile = tilemap_get(_tm, _tX, _tY);

    if (_tile != 1 && !(_tX == _pTX && _tY == _pTY)) {
        moveX = pathDirection.x * moveSpeed;
        moveY = pathDirection.y * moveSpeed;
        totalDistance = TILESIZE;
        moving = true;
    }
	
	else {
		//face player
        if (_tX == _pTX && _tY == _pTY) {
            var _fdx = _pTX - _myTX;
            var _fdy = _pTY - _myTY;
            directionIndex = (round(point_direction(0, 0, _fdx, _fdy) / 45)) mod 8;
        }
        pathDirection = { x: 0, y: 0 };
    }
}

//Movement Execution
if (moving) {
    x += moveX;
    y += moveY;

    if ((moveX > 0 && x >= targetX) || (moveX < 0 && x <= targetX)) x = targetX;
    if ((moveY > 0 && y >= targetY) || (moveY < 0 && y <= targetY)) y = targetY;

    if (x == targetX && y == targetY) {
        moving = false;
        pathDirection = { x: 0, y: 0 };
        pathCooldown = irandom_range(pathCooldownMin, pathCooldownMax);
    }
}

//Animate
if (moving) {
    var _moved    = abs(x - startX) + abs(y - startY);
    var _progress = _moved / totalDistance;
    image_index   = directionIndex * 3 + (floor(_progress * 3) mod 3); //fewer frames than player.
}

else {
    image_index = directionIndex * 3;
}