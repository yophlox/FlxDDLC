package states;

import flixel.text.FlxText;
import flixel.FlxState;
import flixel.FlxG;

class PlayState extends FlxState
{
	override public function create()
	{
		super.create();

		var dialoguetext:Array<String> = openfl.Assets.getText("assets/data/act1/testdialogue.txt").split("@@");
		trace(dialoguetext);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
