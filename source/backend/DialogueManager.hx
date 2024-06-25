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

        dialogueFlxText = new FlxText(0, FlxG.height - 100, FlxG.width, "");
        dialogueFlxText.setFormat("assets/fonts/Aller_Rg.ttf", 32, FlxColor.WHITE, "center");
        dialogueFlxText.screenCenter();

        characterNames = new Map<String, String>();
        characterNames.set("s", "Sayori");
        characterNames.set("m", "Monika");
        characterNames.set("n", "Natsuki");
        characterNames.set("y", "Yuri");
        characterNames.set("mc", ""); // To be defined...

        updateDialogue();
    }

    private function updateDialogue():Void
    {
        while (currentLine < dialogues.length)
        {
            var line:String = dialogues[currentLine].trim();
            if (line.length > 3 && line.charAt(1) == ' ')
            {
                var prefix:String = line.charAt(0);
                if (characterNames.exists(prefix))
                {
                    var dialogue:String = line.substr(2);
                    var characterName:String = characterNames.get(prefix);
                    if (characterName != "")
                    {
                        dialogueFlxText.text = characterName + ": " + dialogue;
                    }
                    else
                    {
                        dialogueFlxText.text = dialogue;
                    }
                    currentLine++;
                    return;
                }
            }
            currentLine++;
        }

        // Handle end of dialogue
        dialogueFlxText.text = ""; // or handle end of dialogue state
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
