package backend;

import flixel.text.FlxText;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxState;
import flixel.FlxSprite;
using StringTools;

class DialogueManager
{
    private var dialogueFlxText:FlxText;
    private var dialogues:Array<String>;
    private var currentLine:Int;
    private var characterNames:Map<String, String>;

    public function new(dialogueFile:String)
    {
        dialogues = openfl.Assets.getText(dialogueFile).split("\n");
        currentLine = 0;

        dialogueFlxText = new FlxText(0, FlxG.height - 150, FlxG.width, "");
        dialogueFlxText.setFormat("assets/fonts/Aller_Rg.ttf", 24, FlxColor.WHITE, OUTLINE, FlxColor.BLACK);
        dialogueFlxText.x += 225;

        characterNames = new Map<String, String>();
        characterNames.set("s", "Sayori");
        characterNames.set("m", "Monika");
        characterNames.set("n", "Natsuki");
        characterNames.set("y", "Yuri");
        characterNames.set("mc", "MC");

        updateDialogue();
    }

    private function updateDialogue():Void
    {
        while (currentLine < dialogues.length)
        {
            var line:String = dialogues[currentLine].trim();
            if (line.length > 0)
            {
                var prefix:String = line.charAt(0);
                if (characterNames.exists(prefix) && line.charAt(1) == ' ')
                {
                    var dialogue:String = line.substr(2);
                    var characterName:String = characterNames.get(prefix);
                    if (characterName != "")
                    {
                        dialogueFlxText.text = characterName + ": " + handleLineBreaks(dialogue);
                    }
                    else
                    {
                        dialogueFlxText.text = handleLineBreaks(dialogue);
                    }
                }
                else
                {
                    dialogueFlxText.text = handleLineBreaks(line);
                }
                currentLine++;
                return;
            }
            currentLine++;
        }
        dialogueFlxText.text = "";
    }

    private function handleLineBreaks(line:String):String
    {
        return line.split("n\\").join("\n");
    }

    public function start():Void
    {
        updateDialogue();
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
