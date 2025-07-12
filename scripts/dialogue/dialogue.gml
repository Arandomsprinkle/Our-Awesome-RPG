#region Test Dialogues
//Example of no choice
function test_dialogue_00(stage = 0) {
    switch (stage) {
        case 0:
            start_dialogue("How does this look?", -1)
		//will automatically go to the next case after finished.
		case 1:
			start_dialogue("Rhetorical question, I think it looks pretty good :)", -1)
			break; //break to end it.
		//Just a catch
		default:
			start_dialogue("Error: Missing Path")
			break;
    }
}


//Example of choice
function test_dialogue_01(stage = 0) {
    switch (stage) {
	//the Label is the option name, and the call is the next "stage"
        case 0:
			//I honestly hate how this looks, but it's the easiest for readability
            start_dialogue("How does this look?", sprTestPortrait, undefined, [
                {
                    label: "Good",
                    call: function() { test_dialogue_01("positive"); }
                },
                {
                    label: "Bad",
                    call: function() { test_dialogue_01("negative"); }
                }
            ]);
            break;

        case "positive":
            start_dialogue("Oh awesome, I'm glad you like it. It kind of took forever, so I hope I don't have to change much about it.", sprTestPortrait, undefined, [
                {
                    label: "Lets hope not!",
                    call: function() { test_dialogue_01("hopenot"); }
                },
                {
                    label: "Well actually...",
                    call: function() { test_dialogue_01("actually"); }
                }
            ]);
            break;

        case "hopenot":
            start_dialogue("Yeah, for real.", sprTestPortrait);
            break;

        case "actually":
            start_dialogue("Maaaaan... Come on!!", sprTestPortrait);
            break;

        case "negative":
            start_dialogue("Wow. Okay. Rude.", sprTestPortrait);
            break;
			
		default:
			start_dialogue("Error: Missing Path", sprTestPortrait)
			break;
    }
}
#endregion