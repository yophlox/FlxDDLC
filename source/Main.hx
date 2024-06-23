package;

import flixel.FlxGame;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.utils.Timer;
import openfl.events.TimerEvent;
import sys.io.File;
import sys.FileSystem;
import sys.io.Process;
import states.WarningState;
import states.PlayState;
import states.MainMenuState;

class Main extends Sprite
{
    var config = {
        width: 1280,
        height: 720,
        zoom: -1.0,
        framerate: 60,
        skipSplash: false,
        startFullscreen: false 
    };

    public function new()
    {
        super();
        
        var initialState:Class<flixel.FlxState> = if (checkFirstRun()) WarningState else MainMenuState;

        addChild(new FlxGame(config.width, config.height, initialState, 
            #if (flixel < "5.0.0") config.zoom, #end 
            config.framerate, config.framerate, config.skipSplash, config.startFullscreen));

        // There's probably a way better way to do this but this works so yeah
        /*
        var timer = new Timer(1000); // checking for obs every second xd
        timer.addEventListener(TimerEvent.TIMER, onCheckObs);
        timer.start();
        */
    }

    private function checkFirstRun():Bool
    {
        var firstRunFile = "firstrun";
        var firstRunExists = FileSystem.exists(firstRunFile);

        if (!firstRunExists) {
            // Create the "firstrun" file
            var file = File.write(firstRunFile, true);
            file.close();
        }

        // Check if the necessary character files exist
        var monikaExists = FileSystem.exists("assets/characters/monika.chr");
        var sayoriExists = FileSystem.exists("assets/characters/sayori.chr");

        if (!monikaExists) {
            trace("monika.chr is missing!");
            deleteDirRecursively("assets/characters");
            trace("deleted characters folder lol!");
            Sys.exit(1);
            trace("The game can't run without monika and sayori lol!");
        }

        return !firstRunExists && monikaExists && sayoriExists;
    }

    // Credits: https://ashes999.github.io/learnhaxe/recursively-delete-a-directory-in-haxe.html
    private function deleteDirRecursively(path:String) : Void
    {
        if (sys.FileSystem.exists(path) && sys.FileSystem.isDirectory(path))
        {
            var entries = sys.FileSystem.readDirectory(path);
            for (entry in entries) {
                if (sys.FileSystem.isDirectory(path + '/' + entry)) {
                    deleteDirRecursively(path + '/' + entry);
                    sys.FileSystem.deleteDirectory(path + '/' + entry);
                } else {
                    sys.FileSystem.deleteFile(path + '/' + entry);
                }
            }
        }
    }

    private function isObsRunning():Bool
    {
        var result = "";
        try {
            var process = new Process("tasklist", []);
            var output = process.stdout.readAll().toString();
            result = output.toLowerCase();
        } catch (e:Dynamic) {
            trace("Failed to check running processes: " + e);
            return false;
        }

        return result.indexOf("obs64.exe") != -1 || result.indexOf("obs32.exe") != -1;
    }

    private function onCheckObs(event:TimerEvent):Void
    {
        if (isObsRunning()) {
           // oogh
        }
    }
}
