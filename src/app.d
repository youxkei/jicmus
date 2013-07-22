module app;

import bullet;
import draws;
import input;
import view;
import scene.scene;
import scene.game.game;

import std.exception : enforce;
import derelict.sdl2.sdl;
import derelict.opengl3.gl;

void main()
{ 
    DerelictSDL2.load();
    DerelictGL.load();

    SDL_Init(SDL_INIT_VIDEO);
    scope(exit) SDL_Quit();

    SDL_Window* window = enforce(SDL_CreateWindow("jicmus", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, 1280, 960, SDL_WINDOW_OPENGL));
    scope(exit) SDL_DestroyWindow(window);

    auto context = enforce(SDL_GL_CreateContext(window));

    initGL();

    auto inputHandler = new InputHandler();
    auto view = new View();
    view.input = inputHandler.getInputView();

    Scene scene = GameScene();

    SDL_ShowWindow(window);

    while(true)
    {
        inputHandler.handle();

        scene = scene.update(view);
        if(!scene) break;

        glClear(GL_COLOR_BUFFER_BIT);
        scene.draw();
        SDL_GL_SwapWindow(window);
    }
}

void initGL()
{
    glOrtho(0, 1280, 960, 0, -1, 1);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glEnable(GL_LINE_SMOOTH);
}
