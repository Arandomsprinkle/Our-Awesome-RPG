event_inherited();

if (active == true) {
    if (!instance_exists(objDialogueBox)) {
        var _dialogue_instance = instance_create_layer(0, 0, "Entities", objDialogueBox);
        if (instance_exists(_dialogue_instance)) {
            with (_dialogue_instance) {
                start_dialogue(other.message); 
            }
            _dialogue_instance.visible = true;
            global.isPaused = true; 
        }
	}
}