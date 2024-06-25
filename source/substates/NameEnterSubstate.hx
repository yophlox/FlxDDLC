package substates;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.FlxSubState;
import flixel.FlxCamera;

class NameEnterSubstate extends FlxSubState
{
    var nametext:FlxText;

	public function new()
	{
		super();

        var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);
        bg.scrollFactor.set();
        bg.alpha = 0.65;
		bg.screenCenter();
        add(bg);

		nametext = new FlxText(0, 0, FlxG.width, "Please enter your name", 32);
		nametext.setFormat(Paths.font("Aller_Rg.ttf"), 32, FlxColor.BLACK, CENTER);
		nametext.screenCenter(Y);
		add(nametext);

        /*
		var levelInfo:FlxText = new FlxText(20, 15, 0, "DEMO LEVEL", 32);
		levelInfo.scrollFactor.set();
		levelInfo.setFormat(Paths.font("vcr.ttf"), 32);
		levelInfo.updateHitbox();
		add(levelInfo);
        */
	}

	override function update(elapsed:Float)
	{
        if (FlxG.keys.justPressed.ENTER)
        {
			FlxG.switchState(new states.PlayState());
        }

		super.update(elapsed);
	}

	override function destroy()
	{
		super.destroy();
	}	
}