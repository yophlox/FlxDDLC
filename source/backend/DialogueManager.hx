package backend;

import flixel.text.FlxText;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import hscript.Parser;
import hscript.Interp;
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
    private var dialogueFile:String;
    private var parser:Parser;
    private var interp:Interp;
    private var lastExpression:String = "";

    public function new(dialogueFile:String)
    {
        this.dialogueFile = dialogueFile;
        dialogues = [];
        currentLine = 0;

        dialogueFlxText = new FlxText(225, FlxG.height - 150, FlxG.width - 450, "");
        dialogueFlxText.setFormat("assets/fonts/Aller_Rg.ttf", 24, FlxColor.WHITE, LEFT, OUTLINE, FlxColor.BLACK);

        nameFlxText = new FlxText(230, FlxG.height - 190, 200, "");
        nameFlxText.setFormat("assets/fonts/Aller_Rg.ttf", 28, FlxColor.WHITE, LEFT, OUTLINE, FlxColor.BLACK);

        characters = new Map<String, FlxSprite>();
        parser = new Parser();
        interp = new Interp();
        setupInterpreter();
    }

    private function setupInterpreter():Void
    {
        interp.variables.set("showDialogue", showDialogue);
        interp.variables.set("setCharacterExpression", setCharacterExpression);
        interp.variables.set("playerName", playerName);
    }

    private function parseDialogueFile(dialogueFile:String):Array<DialogueLine>
    {
        try {
            var script = openfl.Assets.getText(dialogueFile);
            if (script == null || script == "") {
                trace('Error: Dialogue file is empty or not found: $dialogueFile');
                return [];
            }
            var program = parser.parseString(script);
            interp.execute(program);
            return dialogues;
        } catch (e:Dynamic) {
            trace('Error parsing dialogue file: $e');
            return [];
        }
    }

    public function start():Void
    {
        dialogues = parseDialogueFile(dialogueFile + ".hx");
        trace('Loaded ${dialogues.length} dialogue lines');
        currentLine = 0;
        if (dialogues.length > 0) {
            updateDialogue();
        } else {
            trace('Warning: No dialogues loaded from file: $dialogueFile');
        }
    }

    private function showDialogue(character:String, text:String):Void
    {
        nameFlxText.text = character;
        targetText = text;
        currentText = "";
        textTimer = 0;
        
        dialogues.push({
            character: character,
            text: text,
            expression: lastExpression
        });
    }

    private function setCharacterExpression(character:String, expression:String):Void
    {
        trace('Setting character expression: $character, $expression');
        lastExpression = expression;
        showCharacter(character, expression);
    }

    private function updateDialogue():Void
    {
        if (currentLine < dialogues.length)
        {
            var line = dialogues[currentLine];
            nameFlxText.text = switch (line.character) {
                case "s": "Sayori";
                case "mc": playerName;
                case "n": "Natsuki";
                case "y": "Yuri";
                case "m": "Monika";
                default: line.character; // Use the character name as-is if not recognized
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
        if (targetText == null) return;
        
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
        if (targetText == null) return;
        
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
        trace('Showing character: $character with expression: $expression');
        for (char in characters.keys())
        {
            characters[char].visible = false;
            trace('Setting ${char} visibility to false');
        }

        // Convert full names to abbreviations
        var charAbbr = switch (character.toLowerCase()) {
            case "sayori": "s";
            case "monika": "m";
            case "natsuki": "n";
            case "yuri": "y";
            default: character.toLowerCase();
        }

        if (characters.exists(charAbbr))
        {
            var sprite = characters[charAbbr];
            sprite.visible = true;
            trace('Setting $charAbbr visibility to true');
            
            var expressionPath = 'assets/images/characters/${charAbbr}/${expression}.png';
            trace('Attempting to load: $expressionPath');
            if (openfl.Assets.exists(expressionPath))
            {
                sprite.loadGraphic(expressionPath);
                trace('Loaded $expressionPath');
            }
            else
            {
                var neutralPath = 'assets/images/characters/${charAbbr}/neutral.png';
                sprite.loadGraphic(neutralPath);
                trace('Fallback: Loaded $neutralPath');
            }
        }
        else
        {
            trace('Character $charAbbr not found in characters map');
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