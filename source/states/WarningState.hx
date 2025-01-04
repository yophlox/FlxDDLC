package states;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.input.mouse.FlxMouse;

class WarningState extends FlxState
{
    private var dialogueManager:DialogueManager;
    private var mouse:FlxMouse;

    override public function create()
    {
        mouse = FlxG.mouse;

		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('bg/warning/warning'));
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0.18;
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

        var dialoguebox:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('textbox'));
        dialoguebox.scrollFactor.x = 0;
        dialoguebox.scrollFactor.y = 0.18;
        dialoguebox.setGraphicSize(Std.int(dialoguebox.width * 1.1));
        dialoguebox.updateHitbox();
        dialoguebox.screenCenter();
        dialoguebox.y -= 40;
        add(dialoguebox);

        dialogueManager = new DialogueManager("assets/data/data-goes-here.txt");
        add(dialogueManager.getDialogueFlxText());

        super.create();
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.ENTER)
        {
            FlxG.switchState(new MainMenuState());
        }
        
        // Reg shit
        /*
        if (FlxG.keys.justPressed.ENTER || mouse.justPressed) {
            if (!dialogueManager.isDialogueComplete()) {
                dialogueManager.start();
            } else {
                // blech
            }
        }
        */
    }
}
