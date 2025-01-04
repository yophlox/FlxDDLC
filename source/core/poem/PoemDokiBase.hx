package core.poem;

import flixel.FlxSprite;
import flixel.FlxG;
import states.PlayState;
import openfl.geom.Rectangle;
import openfl.display.BitmapData;

class PoemDokiBase extends FlxSprite
{
    public var speed:Float = 10;
    public var characterAtlas:String;
    var isLeader:Bool = false;

    public function new(x:Float = 0, y:Float = 0)
    {
        super(x, y);
    }

    public function loadCharacterAnimations()
    {
        if (characterAtlas != null)
        {
            frames = Paths.getSparrowAtlas('minigame/poem/chars/' + characterAtlas);
            animation.addByPrefix('idle', 'norm', 12, true);
            animation.addByPrefix('cheer', 'yay', 12, true);
            
            animation.play('idle');
            scale.set(2, 2);
            updateHitbox();
        }
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);
    }
}