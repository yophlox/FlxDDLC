package core.poem;

class SayoriMini extends PoemDokiBase
{
    public function new(x:Float = 0, y:Float = 0)
    {
        super(x, y);
        isLeader = true;
        characterAtlas = 'SayoriChibi';
        loadCharacterAnimations();
    }
}