module util;

import std.range : Cycle, cycle;

mixin template SINGLETON()
{
    static assert(__traits(compiles, new typeof(this)()));
    public static typeof(this) instance;

    static this()
    {
        instance = new typeof(this)();
    }

    static typeof(this) opCall()
    {
        return instance;
    }
}

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

    static typeof(this) opCall()
    {
        typeof(this) instance = buffer.front;
        buffer.popFront();
        return instance;
    }
}
