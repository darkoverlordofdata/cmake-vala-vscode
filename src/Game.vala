using SDL;
using SDL.Video;

public class Game : Object {

    public int width = 0;
    public int height = 0;
    public int mouseX = 0;
    public int mouseY = 0;
    public double delta = 0.0;
    public bool mouseDown = false;
    
    private int fps = 0;
    private bool running = false;
    private string title;
    private uint8[] keys = new uint8[255];
    private Factory factory;
    private List<Entity*> sprites = new List<Entity*>();
    private unowned Window window;
    private unowned Renderer renderer;
        
    public Game(string title, int width, int height, Window window, Renderer renderer) {
        this.title = title;
        this.width = width;
        this.height = height;
        this.window = window;
        this.renderer = renderer;
    }

    public void draw(int f, double avg=-1.0) {
        fps = fps != f ? drawFps(f, avg) : fps;
        renderer.set_draw_color(0x00, 0x00, 0x00, 0x00);
        renderer.clear();
        sprites.foreach(e => e.active ? drawSprite(ref e) : 0 );
        renderer.present();
    }
    
    public int drawSprite(ref Entity* e) {
        if (e.category != Category.BACKGROUND) {
            e.bounds.w = (int)((double)e.sprite.width * e.scale.x);
            e.bounds.h = (int)((double)e.sprite.height * e.scale.y);
            e.bounds.x = (int)((double)e.position.x - e.bounds.w / 2);
            e.bounds.y = (int)((double)e.position.y - e.bounds.h / 2);
        }
        if (e.tint != null) {
            var c = e.tint;
            e.sprite.texture->set_color_mod((uint8)c.r, (uint8)c.g, (uint8)c.b);
        }
        renderer.copy(e.sprite.texture, null, e.bounds);
        return 1;
    }

    public int drawFps(int fps, double avg) {
        window.title = avg > -1.0  
            ? "%s [%d / %f]".printf(title, fps, avg)
            : "%s [%d fps]".printf(title, fps);
        return fps;
    }
    
    public void update(double delta) {
        this.delta = delta;
        factory.update();
    }
        
    public void addSprite(Entity* e) {
        var rank = (int)e.actor;
        if (sprites.length() == 0) sprites.append(e);
        else {
            var i = 0;
            foreach (var s in sprites) {
                if (rank <= (int)s.actor) {
                    sprites.insert(e, i);
                    return;
                }
                else i++;
            }
            sprites.append(e);
        }
    }

    public void removeSprite(Entity* e) {
        sprites.remove(e);
    }

    public int getKey(int key) {
        return (0 < key < 255) ? keys[key] : 0;
    }
    
    public void start() {
        factory = new Factory(this, renderer);
        running = true;
    }
    
    public void stop() {
        running = false;  
    }

    public bool isRunning() {
        return running;
    }
    

    public void handleEvents() {
        SDL.Event evt;
        
        while (SDL.Event.poll(out evt) != 0) {
            switch (evt.type) {

                case SDL.EventType.QUIT:    
                    running = false;  
                    break;

                case SDL.EventType.KEYDOWN: 
                    if (0 < evt.key.keysym.sym < 255)
                        keys[ evt.key.keysym.sym ] = 1;
                    break;

                case SDL.EventType.KEYUP:   
                    if (0 < evt.key.keysym.sym < 255)
                        keys[ evt.key.keysym.sym ] = 0;
                    break;

                case SDL.EventType.MOUSEBUTTONDOWN:
                    mouseDown = true;
                    break;

                case SDL.EventType.MOUSEBUTTONUP:
                    mouseDown = false;
                    break;

                case SDL.EventType.MOUSEMOTION:
                    mouseX = evt.motion.x;
                    mouseY = evt.motion.y;
                    break;
            }
        }    
    }
    
}