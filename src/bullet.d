module bullet;

import util;
import derelict.opengl3.gl;

alias DrawFunction = void function();
alias MoveFunction = void function(ref double, ref double, in Bullet);

class Bullet
{
    mixin POOLIZE!65536;

    double x_ = 0, y_ = 0, angle_ = 0;
    size_t frame_;
    bool available_;

    DrawFunction drawFunc_;
    MoveFunction moveFunc_;

    T x(this T)(double x)
    {
        x_ = x;

        return cast(T)this;
    }

    T y(this T)(double y)
    {
        y_ = y;

        return cast(T)this;
    }

    T angle(this T)(double angle)
    {
        angle_ = angle;

        return cast(T)this;
    }

    T available(this T)(bool available)
    {
        available_ = available;

        return cast(T)this;
    }

    T drawFunc(this T)(DrawFunction drawFunc)
    {
        drawFunc_ = drawFunc;

        return cast(T)this;
    }

    T moveFunc(this T)(MoveFunction moveFunc)
    {
        moveFunc_ = moveFunc;

        return cast(T)this;
    }

    void draw()
    {
        if(drawFunc_ !is null && available_)
        {
            glPushMatrix();
            glTranslated(x_, y_, 0);
            glRotated(angle_, 0, 0, 1);

            drawFunc_();

            glPopMatrix();
        }
    }

    void move()
    {
        if(moveFunc_ !is null)
        {
            moveFunc_(x_, y_, this);
        }
    }
}
