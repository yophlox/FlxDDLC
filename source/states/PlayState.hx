package states;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import backend.DialogueManager;
import flixel.input.mouse.FlxMouse;
using StringTools;

class PlayState extends FlxState
{
    private var dialogueManager:DialogueManager;
    private var mouse:FlxMouse;
    var act1:Bool = true;
    var act2:Bool = false;
    var act3:Bool = false;
    var act4:Bool = false;
    
    override public function create()
    {
        mouse = FlxG.mouse;

        var clubbg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('bg/club'));
        clubbg.scrollFactor.set(0, 0.18);
        clubbg.setGraphicSize(Std.int(clubbg.width * 1.1));
        clubbg.updateHitbox();
        clubbg.screenCenter();
        add(clubbg);

        var dialoguebox:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('textbox'));
        dialoguebox.scrollFactor.set(0, 0.18);
        dialoguebox.setGraphicSize(Std.int(dialoguebox.width * 1.1));
        dialoguebox.updateHitbox();
        dialoguebox.screenCenter();
        dialoguebox.y = FlxG.height - dialoguebox.height - 20;
        add(dialoguebox);

        if (act1)
        {
            dialogueManager = new DialogueManager("assets/data/act1/dialogue.txt");
            add(dialogueManager.getDialogueFlxText());
            add(dialogueManager.getNameFlxText());
            
            /*
            var sayori = new FlxSprite(100, 100).loadGraphic(Paths.image('characters/sayori'));
            var monika = new FlxSprite(300, 100).loadGraphic(Paths.image('characters/monika'));
            var natsuki = new FlxSprite(500, 100).loadGraphic(Paths.image('characters/natsuki'));
            var yuri = new FlxSprite(700, 100).loadGraphic(Paths.image('characters/yuri'));

            dialogueManager.addCharacter("Sayori", sayori);
            dialogueManager.addCharacter("Monika", monika);
            dialogueManager.addCharacter("Natsuki", natsuki);
            dialogueManager.addCharacter("Yuri", yuri);

            add(sayori);
            add(monika);
            add(natsuki);
            add(yuri);
            */

            dialogueManager.start();
        }

        super.create();
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.R)
        {
            FlxG.resetState();
        }
        
        if (FlxG.keys.justPressed.ENTER || mouse.justPressed) {
            dialogueManager.skipText();
        }

        dialogueManager.update(elapsed);
    }
}
