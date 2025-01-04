// Hella simple but he liked it so that's what matters!
package states;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxBackdrop;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class SayoriSqueaker extends FlxState
{
    var titlestatebg:FlxBackdrop;
    var chibiSayori:SayoriMini;
    var score:Int = 0;
    var scoreText:FlxText;

    override public function create()
    {
		titlestatebg = new FlxBackdrop(Paths.image('gui/menu_bg'), XY, 0.2, 0);
		titlestatebg.velocity.set(200, 110);
		titlestatebg.updateHitbox();
		titlestatebg.screenCenter(X);
		add(titlestatebg);

        chibiSayori = new SayoriMini(0, 0);
        chibiSayori.screenCenter(X);
        add(chibiSayori);

        scoreText = new FlxText(FlxG.width - 100, 10, 0, "Score: 0", 24);
        scoreText.setFormat(Paths.font("Aller_Rg.ttf"), 24, FlxColor.BLACK, RIGHT);
        add(scoreText);

        super.create();
    }

    override public function update(elapsed:Float)
    {
        if (FlxG.mouse.justPressed)
        {
            if (FlxG.mouse.overlaps(chibiSayori))
            {
                chibiSayori.animation.play('cheer');
                FlxG.sound.play(Paths.sound('boop'));
                score += 10;
                scoreText.text = "Score: " + score;
                
                chibiSayori.velocity.y = -200;
                
                new flixel.util.FlxTimer().start(0.3, function(tmr:flixel.util.FlxTimer)
                {
                    chibiSayori.animation.play('idle');
                });
            }
        }

        chibiSayori.velocity.y += 800 * elapsed;
        
        if (chibiSayori.y > FlxG.height - chibiSayori.height)
        {
            chibiSayori.y = FlxG.height - chibiSayori.height;
            chibiSayori.velocity.y = 0;
        }

        super.update(elapsed);
    }
}
