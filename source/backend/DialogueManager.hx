package backend;

import flixel.text.FlxText;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxSprite;
using StringTools;

typedef DialogueLine = {
    character:String,
    text:String,
    expression:String
}

class DialogueManager
{
    private var dialogueFlxText:FlxText;
    private var nameFlxText:FlxText;
    private var dialogues:Array<DialogueLine>;
    private var currentLine:Int;
    private var characters:Map<String, FlxSprite>;
    private var textSpeed:Float = 0.05;
    private var currentText:String = "";
    private var targetText:String = "";
    private var textTimer:Float = 0;
    private var textSpeedMultiplier:Float = 1.0;
    private static var playerName:String = "MC";

    public function new(dialogueFile:String)
    {
        dialogues = parseDialogueFile(dialogueFile);
        currentLine = 0;

        dialogueFlxText = new FlxText(225, FlxG.height - 150, FlxG.width - 450, "");
        dialogueFlxText.setFormat("assets/fonts/Aller_Rg.ttf", 24, FlxColor.WHITE, LEFT, OUTLINE, FlxColor.BLACK);

        nameFlxText = new FlxText(230, FlxG.height - 190, 200, "");
        nameFlxText.setFormat("assets/fonts/Aller_Rg.ttf", 28, FlxColor.WHITE, LEFT, OUTLINE, FlxColor.BLACK);

        characters = new Map<String, FlxSprite>();
    }

    private function parseDialogueFile(dialogueFile:String):Array<DialogueLine>
    {
        var lines = openfl.Assets.getText(dialogueFile).split("\n");
        var parsedDialogues = new Array<DialogueLine>();

        for (line in lines)
        {
            line = line.trim();
            if (line.length > 0)
            {
                var parts = line.split(" ");
                if (parts.length >= 2)
                {
                    var character = parts[0];
                    var expression = "neutral";
                    var textStart = 1;

                    if (parts[1].startsWith("(") && parts[1].endsWith(")")) {
                        expression = parts[1].substr(1, parts[1].length - 2);
                        textStart = 2;
                    }

                    var text = parts.slice(textStart).join(" ").trim();
                    if (text.startsWith("\"") && text.endsWith("\"")) {
                        text = text.substr(1, text.length - 2);
                    }
                    
                    text = StringTools.replace(text, "[player]", playerName);
                    
                    if (character == "s" || character == "mc" || character == "n" || character == "y" || character == "m") {
                        parsedDialogues.push({
                            character: character,
                            text: text,
                            expression: expression
                        });
                    } else {
                        parsedDialogues.push({
                            character: "",
                            text: line,
                            expression: "neutral"
                        });
                    }
                }
            }
        }

        return parsedDialogues;
    }

    public function start():Void
    {
        updateDialogue();
    }

    private function updateDialogue():Void
    {
        if (currentLine < dialogues.length)
        {
            var line = dialogues[currentLine];
            switch (line.character) {
                case "s":
                    nameFlxText.text = "Sayori";
                case "mc":
                    nameFlxText.text = playerName;
                case "n":
                    nameFlxText.text = "Natsuki";
                case "y":
                    nameFlxText.text = "Yuri";
                case "m":
                    nameFlxText.text = "Monika";
                default:
                    nameFlxText.text = "";
            }
            targetText = line.text;
            currentText = "";
            textTimer = 0;
            showCharacter(line.character, line.expression);
            currentLine++;
        }
        else
        {
            nameFlxText.text = "";
            dialogueFlxText.text = "";
        }
    }

    public static function setPlayerName(name:String):Void
    {
        playerName = name;
    }

    public function update(elapsed:Float):Void
    {
        if (currentText.length < targetText.length)
        {
            textTimer += elapsed * textSpeedMultiplier;
            while (textTimer >= textSpeed)
            {
                currentText += targetText.charAt(currentText.length);
                textTimer -= textSpeed;
            }
            dialogueFlxText.text = currentText;
        }
    }

    public function skipText():Void
    {
        if (currentText.length < targetText.length)
        {
            currentText = targetText;
            dialogueFlxText.text = currentText;
        }
        else
        {
            updateDialogue();
        }
    }

    private function showCharacter(character:String, expression:String):Void
    {
        for (char in characters.keys())
        {
            characters[char].visible = false;
        }

        if (characters.exists(character))
        {
            var sprite = characters[character];
            sprite.visible = true;
            
            var expressionPath = 'assets/images/characters/${character.toLowerCase()}/${expression}.png';
            if (openfl.Assets.exists(expressionPath))
            {
                sprite.loadGraphic(expressionPath);
            }
            else
            {
                sprite.loadGraphic('assets/images/characters/${character.toLowerCase()}/neutral.png');
            }
        }
    }

    public function addCharacter(name:String, sprite:FlxSprite):Void
    {
        characters.set(name, sprite);
        sprite.visible = false;
    }

    public function isDialogueComplete():Bool
    {
        return currentLine >= dialogues.length;
    }

    public function getDialogueFlxText():FlxText
    {
        return dialogueFlxText;
    }

    public function getNameFlxText():FlxText
    {
        return nameFlxText;
    }

    public function setTextSpeed(speed:Float):Void
    {
        textSpeedMultiplier = speed;
    }
}