using SDL;
using SDL.Video;

public enum Actor {
    BACKGROUND,
    ENEMY1,
    ENEMY2,
    ENEMY3,
    PLAYER,
    BULLET,
    EXPLOSION,
    BANG,
    PARTICLE
}

public enum Category {
    BACKGROUND,
    BULLET,
    ENEMY,
    EXPLOSION,
    PARTICLE,
    PLAYER
}

public enum Effect {
    PEW,
    SMALLASPLODE,
    ASPLODE
}

public struct Sound {
    public Effect value;
}

[SimpleType]
public struct Double {
    public double value;
}

[SimpleType]
public struct Point2d {
    public double x;
    public double y;
}

[SimpleType]
public struct Vector2d {
    public double x;
    public double y;
}

[SimpleType]
public struct Scale {
    public double x;
    public double y;
}

[SimpleType]
public struct Color {
    public int r;
    public int g;
    public int b;
    public int a;
}

[SimpleType]
public struct Health {
    public int current;
    public int maximum;
}

[SimpleType]
public struct Tween {
    public double min;
    public double max;
    public double speed;
    public bool repeat;
    public bool active;
}

public struct Sprite {
    public Texture* texture;
    public int width;
    public int height;
}

