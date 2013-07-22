module scene.game.game;

import util;
import view;
import scene.scene;

import derelict.sdl2.sdl;

class GameScene: Scene
{
    mixin SINGLETON;

    override Scene update(in View view)
    {
        if(view.input.isKeyPressed(SDL_SCANCODE_ESCAPE))
        {
            return null;
        }
        return this;
    }

    override void draw()
    {}
}
