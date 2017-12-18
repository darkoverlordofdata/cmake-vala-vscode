using SDL;
using SDL.Video;


public inline void logSDLError(string reason)
{
    print("Unable to %s, SDL error: %s\n", reason, SDL.get_error());
}

public int main(string[] args)
{
    new Main("Alliance", 720, 600);
    return 0;
}

public class Main : Object {

    public string title;
    public int width;
    public int height;
    public Window window;
    public Renderer renderer;
    public double delta;
    public double d;
    public int fps;
    public int k;
    public double t;
    public double avg;
    public int k2;
    public Game game;
    public double freq;
    public double mark1;


    public bool isRunning() {
        return game.isRunning();
    }
    
    public Main(string title, int width, int height) {
        this.title = title;
        this.width = width;
        this.height = height;

        print("Hello %s\n", title);

        if (SDL.init(SDL.InitFlag.VIDEO | SDL.InitFlag.TIMER | SDL.InitFlag.EVENTS) < 0)
            logSDLError("initialize SDL");

        if (SDLTTF.init() < 0) 
            logSDLError("initialize TTF fonts");

        if (SDLImage.init(SDLImage.InitFlags.PNG) < 0)
            logSDLError("initialize PNG images");
        
        #if (!EMSCRIPTEN)
        if (SDLMixer.open(22050, SDL.Audio.AudioFormat.S16LSB, 2, 4096) == -1)
            logSDLError("initialize WAV audio");
        #endif
        
        window = new Window(title, Window.POS_CENTERED, Window.POS_CENTERED, width, height, WindowFlags.SHOWN);
        renderer = Renderer.create(window, -1, RendererFlags.ACCELERATED | RendererFlags.PRESENTVSYNC);
        delta = 0.0;
        d = 0.0;
        fps = 60;
        k = 0;
        t = 0.0;
        avg = 0.0;
        k2 = 0;
        game = new Game(title, width, height, window, renderer);
        freq = SDL.Timer.get_performance_frequency();
        mark1 = (double)SDL.Timer.get_performance_counter()/freq;
        
        MersenneTwister.InitGenrand((ulong)SDL.Timer.get_performance_counter());
        game.start();
        #if (EMSCRIPTEN)
        Emscripten.set_main_loop_arg(it => ((Main)it).run(), this, 0, 1);
        #else
        while (isRunning()) run();
        #endif
    }        

    public void run() {
        var mark2 = (double)SDL.Timer.get_performance_counter()/freq;
        delta = mark2 - mark1;
        mark1 = mark2;
        k += 1;
        d += delta;
        if (d >= 1.0)
        {
            fps = k;
            k = 0;
            d = 0;
        }
        
        game.handleEvents();
        if (game.getKey(SDL.Input.Keycode.ESCAPE) != 0) game.stop();
        var m1 = (double)SDL.Timer.get_performance_counter()/freq; 
        game.update(delta);
        var m2 = (double)SDL.Timer.get_performance_counter()/freq; 
        k2 = k2 +1;
        t += m2 - m1;

        if (k2 >= 1000)
        {
            avg = t/1000;
            print("%f\n", avg);
            k2 = 0;
            t = 0.0;
        }
        
        game.draw(fps, avg);
    }
    
}

