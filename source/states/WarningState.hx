package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.FlxState;

class WarningState extends FlxState
{
	var warnText:FlxText;

	override function create()
	{
		super.create();

		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('bg/warning/warning'));
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0.18;
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

		warnText = new FlxText(0, 0, FlxG.width,
			"This game is not suitable for children\nor those who are easily disturbed.\n
			Individuals suffering from anxiety or depression may not have a safe experience playing this game.\n
            By playing Doki Doki Literature Club, you agree that you are at least 13 years of age, and you consent to your exposure of highly disturbing content.\n
			Press ENTER to continue\n
			Press ESCAPE to quit.",
			32);
		warnText.setFormat("assets/fonts/Aller_Rg.ttf", 32, FlxColor.BLACK, CENTER);
		warnText.screenCenter(Y);
		add(warnText);
	}

	override function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.ENTER)
        {
            FlxG.switchState(new states.MainMenuState());
        }    
        else if (FlxG.keys.justPressed.ESCAPE)
        {    
            Sys.exit(1);
        }

		super.update(elapsed);
	}
}