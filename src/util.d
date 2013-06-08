module util;

import std.range : Cycle, cycle;

mixin template POOLIZE(size_t max)
{
    static assert(__traits(compiles, new typeof(this)()));

    public static typeof(this)[] pool;
    private static Cycle!(typeof(this)[]) buffer;

    static this()
    {
        pool = new typeof(this)[](max);
        buffer = cycle(pool);

        foreach(ref elem; pool)
        {
            elem = new typeof(this)();
        }
    }

    static typeof(this) get()
    {
        typeof(this) instance = buffer.front;
        buffer.popFront();
        return instance;
    }
}
