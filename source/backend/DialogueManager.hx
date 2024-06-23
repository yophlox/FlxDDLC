package backend;

import flixel.text.FlxText;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxState;
import flixel.FlxSprite;

class DialogueManager
{
    private var dialogueFlxText:FlxText;
    private var dialogues:Array<String>;
    private var currentLine:Int;

    public function new(dialogueFile:String)
    {
        dialogues = openfl.Assets.getText(dialogueFile).split("\n");
        currentLine = 0;

        dialogueFlxText = new FlxText(0, 0, FlxG.width, "");
        dialogueFlxText.setFormat("assets/fonts/Aller_Rg.ttf", 32, FlxColor.WHITE, "center");
        dialogueFlxText.screenCenter();
    }

    public function start():Void
    {
        if (currentLine < dialogues.length)
        {
            dialogueFlxText.text = dialogues[currentLine];
            currentLine++;
        }
        else
        {
            // Handle end of dialogue
            dialogueFlxText.text = ""; // or handle end of dialogue state
        }
    }

    public function isDialogueComplete():Bool
    {
        return currentLine >= dialogues.length;
    }

    public function getDialogueFlxText():FlxText
    {
        return dialogueFlxText;
    }
}
