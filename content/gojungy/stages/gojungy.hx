var bg:BGSprite; 
var floor:FlxSprite;
var bgX:Float = -650;
var bgY:Float = -750;

function onLoad(){

    FlxG.mouse.visible = false;

    bg = new BGSprite('gojungy', bgX, bgY);
    bg.antialiasing = false;
    bg.scale.set(2.5, 2.5);
    add(bg);
}

function onCreatePost(){
    game.sectionHit();
    game.camFollow.setPosition(0, 0);
    game.isCameraOnForcedPos = true;
}