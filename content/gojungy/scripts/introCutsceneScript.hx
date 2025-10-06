import flixel.text.FlxText;

var cutsceneMap:Map<String,String> = [
    "krystmas-rap" => "krystmas1",
    "greambells" => "krystmas2",
    "one-last-chicken" => "krystmas3"
    "dont-krean-the-cheese" => "krystmas4",
    "flash" => "krystmas5",
    "bloomin" => "krystmas6",
    "mario-gream" => "krystmas7",
    "grystaltale" => "krystmas8",
    "grystal gream" => "krystmas9",
];

var dir:String = "introVids/";

var skippedCountdown:Bool = false;

var cutsceneVid:FunkinVideoSprite = null;

var cutsceneCover:FlxSprite;
var dumbLoadText:FlxText;

function onStartCountdown(){
    if(!skippedCountdown){
        skippedCountdown = true;
        return Function_Stop;
    } else return Function_Continue;
}

function onCreatePost(){
    /*trace(songName);
    trace(cutsceneMap[songName]);*/

    cutsceneCover = new FlxSprite(0, 0);
    cutsceneCover.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
    cutsceneCover.cameras = [camOther];
    cutsceneCover.updateHitbox();
    cutsceneCover.screenCenter();
    add(cutsceneCover);

    dumbLoadText = new FlxText(0, 0, FlxG.width, 20, true);
    dumbLoadText.setFormat(Paths.font("conan.ttf"), 17, FlxColor.LIME, FlxTextAlign.CENTER, FlxTextBorderStyle.NONE, FlxColor.TRANSPARENT, true);
    dumbLoadText.text = "loading probably";
    dumbLoadText.size = 100;
    dumbLoadText.cameras = [camOther];
    dumbLoadText.updateHitbox();
    dumbLoadText.screenCenter();
    add(dumbLoadText);

    if(cutsceneMap[songName] != null && PlayState.isStoryMode == true){

        cutsceneVid = new FunkinVideoSprite(0, 0, true);

        cutsceneVid.onFormat(() -> {
            cutsceneVid.cameras = [camOther];
            cutsceneVid.setGraphicSize(FlxG.width, 0);
            cutsceneVid.updateHitbox();
            cutsceneVid.screenCenter(FlxAxes.XY);
        });

        cutsceneVid.onEnd(() -> {
            dumbLoadText.kill();
            cutsceneCover.kill();
            PlayState.instance.startCountdown();
        });

        if(cutsceneVid.load(Paths.video(dir + cutsceneMap[songName]))){
            cutsceneVid.delayAndStart();
        } else {
            trace("Fart.");
            dumbLoadText.kill();
            cutsceneCover.kill();
            PlayState.instance.startCountdown();
        }

        add(cutsceneVid);
    } else {
        dumbLoadText.kill();
        cutsceneCover.kill();
        PlayState.instance.startCountdown();
    }
}