module scene.scene;

import view;

interface Scene
{
    Scene update(in View view);
    void draw();
}
