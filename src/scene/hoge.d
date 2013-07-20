module scene.hoge;

import util;
import view;
import scene.scene;

import derelict.sdl2.sdl;

class HogeScene: Scene
{
    mixin SINGLETON;

    this(){}

    override
    Scene update(in View view)
    {
        if(view.input.isKeyPressed(SDL_SCANCODE_ESCAPE))
        {
            return null;
        }
        if(view.input.isKeyTriggered(SDL_SCANCODE_S))
        {
            import std.stdio;
            "S".writeln;
        }
        return this;
    }
}
