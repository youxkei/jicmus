module app;

import bullet;
import draws;
import std.exception : enforce;
import derelict.sdl2.sdl;
import derelict.opengl3.gl;

void main()
{ 
    DerelictSDL2.load();
    DerelictGL.load();

    SDL_Init(SDL_INIT_VIDEO);
    scope(exit) SDL_Quit();

    auto window = enforce(SDL_CreateWindow("jicmus", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, 1280, 960, SDL_WINDOW_OPENGL));
    scope(exit) SDL_DestroyWindow(window);

    auto context = enforce(SDL_GL_CreateContext(window));

    initGL();
    auto b = Bullet.get().x(100).y(100).drawFunc(&drawArcBullet!(8, 12, 2));

    SDL_ShowWindow(window);

    double x = 200, y = 200;
    foreach(_; 0..180)
    {
        glClear(GL_COLOR_BUFFER_BIT);

        b.draw();
        b.angle_ += 1;

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
