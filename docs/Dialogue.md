# FlxDDLC Dialogue System

Basically the dialogue is handled ALMOST the same way that base ddlc would handle it but with some modifications.

For instance:

```haxe
setCharacterExpression("s", "neutral");
showDialogue("Sayori", "I'm so excited!");

setCharacterExpression("m", "neutral");
showDialogue("Monika", "That's great, Sayori.");

setCharacterExpression("n", "neutral");
showDialogue("Natsuki", "What's all the fuss about?");

setCharacterExpression("y", "neutral");
showDialogue("Yuri", "Um... I'm not sure...");

showDialogue(playerName, "I'm so excited!"); // dis is for MC/The Player's dialogue.
showDialogue("", "mmm me when I thinky"); // dis is for MC/The Player's thoughts.
```

s stands for Sayori, m stands for Monika, n stands for Natsuki, y stands for Yuri, and mc stands for The name you input at the beginning of the game.

If you wanna go a line down you'd use "n/"

for instance:

mc "Insert comically large n\text here."

and it'd come out as

PlayerName: "Insert comically large
             text here."