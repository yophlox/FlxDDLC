package states;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxBackdrop;
import substates.NameEnterSubstate;
import states.SayoriSqueaker;

class MainMenuState extends FlxState
{
    var titlestatebg:FlxBackdrop;

    override public function create()
    {
		titlestatebg = new FlxBackdrop(Paths.image('gui/menu_bg'), XY, 0.2, 0);
		titlestatebg.velocity.set(200, 110);
		titlestatebg.updateHitbox();
		titlestatebg.screenCenter(X);
		add(titlestatebg);

		var sidething:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('gui/menuside'));
		sidething.setGraphicSize(Std.int(sidething.width * 1.1));
		sidething.updateHitbox();
		sidething.screenCenter();
		add(sidething);

		var girls:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('gui/menugirls'));
		girls.setGraphicSize(Std.int(girls.width * 1.1));
		girls.updateHitbox();
		girls.screenCenter();
		add(girls);

		var menulogo:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('gui/menulogo'));
		menulogo.setGraphicSize(Std.int(menulogo.width * 1.1));
		menulogo.updateHitbox();
		menulogo.screenCenter();
		add(menulogo);

        super.create();
    }

    override public function update(elapsed:Float)
    {
		#if christmas
		if (FlxG.keys.justPressed.ENTER)
		{
			FlxG.switchState(new SayoriSqueaker());
		}
		#else
		if (FlxG.keys.justPressed.ENTER)
        {
			//FlxG.switchState(new PlayState());
			var typename = new NameEnterSubstate();
            openSubState(typename);
        }
		#end
        super.update(elapsed);
    }
}
