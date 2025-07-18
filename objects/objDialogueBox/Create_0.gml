/// @description Insert description here
// You can write your code in this editor


visible = false;

dialogueQueue = [];

currentText = "";
textDisplayed = "";

charIndex = 0;
charTimer = 0;

isTyping = false;
isWaiting = false;

portrait = -1;
portraitPadding = 90;

call = -1;
label = -1;

choices = [];
selectedChoice = 0;
pendingChoices = undefined;


/* Old No Choice
visible = false;

dialogueQueue = [];

currentText = "";
textDisplayed = "";

charIndex = 0;
charTimer = 0;
textSpeed = 2;

isTyping = false;
isWaiting = false;

portrait = -1;
portraitPadding = 52;

call = -1;