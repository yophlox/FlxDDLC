package states;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxBackdrop;

class MainMenuState extends FlxState
{
    var titlestatebg:FlxBackdrop;

    override public function create()
    {
		titlestatebg = new FlxBackdrop(Paths.image('gui/menu_bg'), 0.2, 0, true, true);
		titlestatebg.velocity.set(200, 110);
		titlestatebg.updateHitbox();
		titlestatebg.screenCenter(X);
		add(titlestatebg);

		var sidething:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('gui/sidething'));
		sidething.setGraphicSize(Std.int(sidething.width * 1.1));
		sidething.updateHitbox();
		sidething.screenCenter();
		add(sidething);

        super.create();
    }

    override public function update(elapsed:Float)
    {
        if (FlxG.keys.justPressed.ENTER)
        {
            FlxG.switchState(new states.PlayState());
        }
        super.update(elapsed);
    }
}
