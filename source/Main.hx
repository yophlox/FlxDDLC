package;

import flixel.FlxGame;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.utils.Timer;
import openfl.events.TimerEvent;
import sys.io.File;
import sys.FileSystem;
import sys.io.Process;
import states.PlayState;
import states.SayoriQuickEndState;

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
        
        var initialState:Class<flixel.FlxState> = if (checkFiles()) PlayState else SayoriQuickEndState;

        addChild(new FlxGame(config.width, config.height, initialState, 
            #if (flixel < "5.0.0") config.zoom, #end 
            config.framerate, config.framerate, config.skipSplash, config.startFullscreen));

        // There's probably a way better way to do this but this works so yeah
        var timer = new Timer(1000); // checking for obs every second xd
        timer.addEventListener(TimerEvent.TIMER, onCheckObs);
        timer.start();

        if (!isObsRunning()) {
            trace("OBS is not running!");
        }
        else
        {
            trace("OBS is started and running!");
        }
    }

    private function checkFiles():Bool
    {
        var monikaExists = FileSystem.exists("assets/characters/monika.chr");
        var sayoriExists = FileSystem.exists("assets/characters/sayori.chr");
        var charsexist:Bool = true;
        
        if (!monikaExists) {
            trace("monika.chr is missing!");
           // Credits: https://ashes999.github.io/learnhaxe/recursively-delete-a-directory-in-haxe.html
           deleteDirRecursively("assets/characters");
           trace("deleted characters folder lol!");
           charsexist = false;
        }

        if (!sayoriExists) {
            trace("sayori.chr is missing!");
            charsexist = true;
        }

        if (!charsexist)
        {
            Sys.exit(1);
            trace("The game can't run without monika and sayori lol!");
        }    

        return monikaExists && sayoriExists;
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
        if (!isObsRunning()) {
            trace("OBS is not running!");
        }
        else
        {
            trace("OBS started and running!");
        }
    }
}
