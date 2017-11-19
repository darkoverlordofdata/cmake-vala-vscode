using SDL;
using SDL.Video;

public struct Entity {
    /* Core components: */
    public int id;              //  4
    public string name;         //  4
    public bool active;         //  4
    public Actor actor;         //  4
    public Category category;   //  4
    public Point2d position;    //  16
    public Rect bounds;         //  16
    public Vector2d scale;      //  16
    public Sprite sprite;       //  12
    
    /* Optional components: */
    public Sound? sound;        //  4
    public Color? tint;         //  4
    public Double? expires;     //  8
    public Health? health;      //  8
    public Tween? tween;        //  32
    public Vector2d? velocity;  //  16
                                //  152
                                
    public Entity(int id=0, string name="", bool active=false) {
        this.id = id;
        this.name = name;
        this.active = active;
    }
}

