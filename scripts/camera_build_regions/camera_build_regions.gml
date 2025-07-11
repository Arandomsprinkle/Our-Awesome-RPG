/// @function camera_build_regions(layerName, tileIndex)
/// @param {string} layerName name of tile layer (ie: "Boundary")
/// @param {real} tileIndex index of tile to detect as region (ie: 2 (blue tile in collisions tileset))
/// @description Build regions that constrain the camera, allowing a single room to function as many smaller rooms.

function camera_build_regions(_layerName, _tileIndex) {
	
	//Getting the layer and dimensions
    var _layer = layer_get_id(_layerName);
    var _tilemap = layer_tilemap_get_id(_layer);
    var _tileW = tilemap_get_tile_width(_tilemap);
    var _tileH = tilemap_get_tile_height(_tilemap);
    var _mapW = tilemap_get_width(_tilemap);
    var _mapH = tilemap_get_height(_tilemap);
	
	//Track tiles used in a region
    var _visited = array_create(_mapW * _mapH, false);
	
	//Loop over whole map (really fast with tiles honestly)
    for (var _y = 0; _y < _mapH; _y++) {
        for (var _x = 0; _x < _mapW; _x++) {
			//Skip tiles already in a region
            if (_visited[_y * _mapW + _x]) continue;
			
			//only check for the tile we specified.
            var _tile = tilemap_get(_tilemap, _x, _y);
            if (tile_get_index(_tile) != _tileIndex) continue;
			
			//Start a new region otherwise
            var _left = _x;
            var _top = _y;
            var _right = _x;
            var _bottom = _y;
			
			//Expand right for as far as row goes
            while (_right + 1 < _mapW && tile_get_index(tilemap_get(_tilemap, _right + 1, _top)) == _tileIndex) {
                _right++;
            }
			
			//Expand down while each tile in row is a valid tile
            var _valid = true;
            while (_bottom + 1 < _mapH) {
                for (var _xx = _left; _xx <= _right; _xx++) {
                    if (tile_get_index(tilemap_get(_tilemap, _xx, _bottom + 1)) != _tileIndex) {
                        _valid = false;
                        break;
                    }
                }
                if (_valid) _bottom++;
                else break;
            }
			
			//Done? Mark those tiles as visted (visted by the script, not the player, just to be clear)
            for (var _yy = _top; _yy <= _bottom; _yy++) {
                for (var _xx = _left; _xx <= _right; _xx++) {
                    _visited[_y * _mapW + _x] = true;
                }
            }
			
			//Turn that bitch into a cute lil rectangle and slap it in the mother FLIPPING array.
            var _region = {
                x1: _left * _tileW,
                y1: _top * _tileH,
                x2: (_right + 1) * _tileW,
                y2: (_bottom + 1) * _tileH
            };
            array_push(global.cameraRegions, _region);
        }
    }
}
