package states;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import backend.DialogueManager;

class PlayState extends FlxState
{
    private var dialogueManager:DialogueManager;

    override public function create()
    {
        var clubbg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('bg/club'));
        clubbg.scrollFactor.x = 0;
        clubbg.scrollFactor.y = 0.18;
        clubbg.setGraphicSize(Std.int(clubbg.width * 1.1));
        clubbg.updateHitbox();
        clubbg.screenCenter();
        add(clubbg);

        dialogueManager = new DialogueManager("assets/data/act1/testdialogue.txt");
        add(dialogueManager.getDialogueFlxText());

        super.create();
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.ENTER)
        {
            if (!dialogueManager.isDialogueComplete())
            {
                dialogueManager.start();
            }
            else
            {
                // end of dialogue handler here idk how do kinda do this yet tho
            }
        }
    }
}
