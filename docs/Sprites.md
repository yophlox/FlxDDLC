# FlxDDLC Character Sprites

The sprites are all in the assets/images/characters folder.

Each character has their own folder, and inside that folder is a neutral.png file.

This is the default expression for each character.

Each expression is defined with a name, for example:

```
assets/images/characters/s/neutral.png 
```

which would be the default expression for Sayori.

To set a character to an expression, use the following code:

```haxe
setCharacterExpression("s", "expressionName");
```

For example:

```haxe
setCharacterExpression("s", "excited");
```

This would set Sayori's expression to the "excited" expression.