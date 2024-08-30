package substates;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class NameEnterSubstate extends FlxSubState
{
    var nameText:FlxText;
    var inputText:FlxText;
    var okButton:FlxButton;
    var playerName:String = "";

    public function new()
    {
        super();

        var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);
        bg.scrollFactor.set();
        bg.alpha = 0.65;
        bg.screenCenter();
        add(bg);

        nameText = new FlxText(0, FlxG.height * 0.3, FlxG.width, "Please enter your name", 32);
        nameText.setFormat(Paths.font("Aller_Rg.ttf"), 32, FlxColor.BLACK, CENTER);
        add(nameText);

        inputText = new FlxText(0, FlxG.height * 0.4, FlxG.width, "", 24);
        inputText.setFormat(Paths.font("Aller_Rg.ttf"), 24, FlxColor.BLACK, CENTER);
        add(inputText);

        okButton = new FlxButton(0, FlxG.height * 0.6, "OK", onOkClick);
        okButton.screenCenter(X);
        add(okButton);
    }

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.BACKSPACE && playerName.length > 0)
		{
			playerName = playerName.substr(0, playerName.length - 1);
		}
		else if (FlxG.keys.justPressed.ENTER)
		{
			onOkClick();
		}
		else
		{
			var pressedKey = getJustPressedLetter();
			if (pressedKey != null)
			{
				var keyString = String.fromCharCode(pressedKey);
				if (FlxG.keys.pressed.SHIFT)
				{
					keyString = keyString.toUpperCase();
				}
				else
				{
					keyString = keyString.toLowerCase();
				}
				playerName += keyString;
				if (playerName.length > 10) playerName = playerName.substr(0, 10);
			}
		}

		inputText.text = playerName;
	}

	private function getJustPressedLetter():Null<Int>
	{
		for (i in 65...91)
		{
			if (FlxG.keys.justPressed.byCode(i))
			{
				return i;
			}
		}
		return null;
	}

    function onOkClick()
    {
        if (playerName.length > 0)
        {
            DialogueManager.setPlayerName(playerName);
            FlxG.switchState(new states.PlayState());
        }
    }
}