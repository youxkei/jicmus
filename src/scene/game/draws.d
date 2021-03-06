module draws;

import std.math : PI, sin, cos;
import derelict.opengl3.gl;

private enum resolution = 32;

immutable creal[resolution + 1] cir = {
    creal[resolution + 1] cir;
    foreach(i; 0 .. resolution + 1)
    {
        cir[i] = cos(2 * PI / resolution * i) + sin(2 * PI / resolution * i) * 1i;
    }
    return cir;
}();

void drawArc(double a, double b, float width)()
{
    glColor3d(1, 1, 1);
    glLineWidth(width);
    glBegin(GL_LINES);

    foreach(i; 0 .. resolution)
    {
        glVertex3d(a * cir[i].re    , b * cir[i].im    , 0);
        glVertex3d(a * cir[i + 1].re, b * cir[i + 1].im, 0);
    }

    glEnd();
}
