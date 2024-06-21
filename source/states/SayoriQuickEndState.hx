package states;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxG;

class SayoriQuickEndState extends FlxState
{
	override public function create()
	{
        var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('sayoriquickend/sayoribg'));
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0.18;
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
