module input;

import derelict.sdl2.sdl;

class InputHandler
{
    private InputView inputView_;

    this()
    {
        inputView_ = new InputView();
    }

    InputView getInputView()
    {
        return inputView_;
    }

    void handle()
    {
        inputView_.setClockAhead();

        SDL_Event e;
        while(SDL_PollEvent(&e))
        {
            switch(e.type)
            {
                case SDL_KEYDOWN:
                    inputView_.isKeysPressed_[e.key.keysym.scancode] = true;
                    inputView_.isKeysPressedNow_[e.key.keysym.scancode] = true;

                    break;

                case SDL_KEYUP:
                    inputView_.isKeysPressed_[e.key.keysym.scancode] = false;
                    break;

                default:{}
            }
        }
    }
}

class InputView
{
    private bool[SDL_NUM_SCANCODES] isKeysPressed_;
    private bool[SDL_NUM_SCANCODES] isKeysPressedNow_;

    private void setClockAhead()
    {
        isKeysPressedNow_[] = false;
    }
    
    bool isKeyPressed(SDL_Scancode code) const pure @safe nothrow
    {
        return isKeysPressed_[code];
    }

    bool isKeyTriggered(SDL_Scancode code) const pure @safe nothrow
    {
        return isKeysPressed_[code] && isKeysPressedNow_[code];
    }
}
