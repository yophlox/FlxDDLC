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
        trace("PlayState create() started");
        mouse = FlxG.mouse;

        if (act1)
        {
            dialogueManager = new DialogueManager("assets/data/testdialogue");
            //dialogueManager = new DialogueManager("assets/data/act1/dialogue_ch0_main"); // commented out until I add all of the expressions lol
            dialogueManager.setTextSpeed(2.0);
        }

        var clubbg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('bg/club'));
        clubbg.scrollFactor.set(0, 0.18);
        clubbg.setGraphicSize(Std.int(clubbg.width * 1.1));
        clubbg.updateHitbox();
        clubbg.screenCenter();
        add(clubbg);

        var sayori = new FlxSprite(100, 100).loadGraphic(Paths.image('characters/s/neutral'));
        var monika = new FlxSprite(300, 100).loadGraphic(Paths.image('characters/m/neutral'));
        var natsuki = new FlxSprite(500, 100).loadGraphic(Paths.image('characters/n/neutral'));
        var yuri = new FlxSprite(700, 100).loadGraphic(Paths.image('characters/y/neutral'));
        
        dialogueManager.addCharacter("s", sayori);
        dialogueManager.addCharacter("m", monika);
        dialogueManager.addCharacter("n", natsuki);
        dialogueManager.addCharacter("y", yuri);

        sayori.visible = true;
        monika.visible = true;
        natsuki.visible = true;
        yuri.visible = true;
        
        add(sayori);
        add(monika);
        add(natsuki);
        add(yuri);

        var dialoguebox:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('textbox'));
        dialoguebox.scrollFactor.set(0, 0.18);
        dialoguebox.setGraphicSize(Std.int(dialoguebox.width * 1.1));
        dialoguebox.updateHitbox();
        dialoguebox.screenCenter();
        dialoguebox.y = FlxG.height - dialoguebox.height - 20;
        add(dialoguebox);

        if (act1)
        {
            add(dialogueManager.getDialogueFlxText());
            add(dialogueManager.getNameFlxText());
            dialogueManager.start();
        }

        trace("PlayState create() completed");
        super.create();
    }

    override public function update(elapsed:Float)
    {
        try {
            super.update(elapsed);

            if (FlxG.keys.justPressed.R)
            {
                FlxG.resetState();
            }
            
            if (FlxG.keys.justPressed.ENTER || mouse.justPressed) {
                dialogueManager.skipText();
            }

            dialogueManager.update(elapsed);
        } catch (e:Dynamic) {
            trace('Error in PlayState update: $e');
        }
    }
}
