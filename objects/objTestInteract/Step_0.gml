/// @description Insert description here
// You can write your code in this editor

if active {
	switch (funct) {
		case "rock":
			//Graphic
			var _tilemap1 = layer_tilemap_get_id("TileLayer1");
			tilemap_set_at_pixel(_tilemap1,pickRock,x,y)
			//Collision
			var _tilemapCol = layer_tilemap_get_id("Collision")
			tilemap_set_at_pixel(_tilemapCol,0,x,y) //Clears the collision.
			//Add to inv
			var _rock = { //Probably going to make a function for making items, but this is just a test
				name : "rock", //Item name, duh.
				desc : "just a normal rock.", //Item Description, also duh.
				icon : noone, //the sprite of the item for the inv
				weight : 5, //In pounds
				material : "stone", //What the item is made out of.
				durability : -1, //-1 no durability
				type : "material", //Item type, such as weapon, armour, food, etc.
				effect : [], //like recover health, fill hunger, cure poison
				spoilTime : 0, //Not sure how to do this yet, probably using calendar that will be made later
				uses : 0, //How many uses the item has
				damage : 1, //How much damage the item will do (mainly for weapons, could also be for throwing)
				armour : 0, //How much armour the item provides the player.
				use : noone, //Script to run when using the item (may pick this over effect)
				equip : noone, //Script to run when equipped (may replace damage/armour?)
				drop : noone, //Script when item is dropped.
				canStack : 5, //0 = false, 1+ = max stack size.
				stackSize : 1, //Current stack size
				tags : [] //This will be for a system later.
				//May expand, but I'm thinking this will be a good "template"
			}
			array_push(objPlayer.inventory, _rock)
			
			active = false;
			instance_destroy();
		break;
		case "tree":
			show_message("THIS IS TREE");
			active = false;
		break;
	}
}