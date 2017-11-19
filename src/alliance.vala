using SDL;
using SDL.Video;


public inline int logSDLError(string reason)
{
    print("Unable to %s, SDL error: %s\n", reason, SDL.get_error());
    return 0;
}

public int main(string[] args)
{
    if (SDL.init(SDL.InitFlag.VIDEO | SDL.InitFlag.TIMER | SDL.InitFlag.EVENTS) < 0)
        return logSDLError("initialize SDL");

    if (SDLTTF.init() < 0) 
        return logSDLError("initialize TTF fonts");

    if (SDLImage.init(SDLImage.InitFlags.PNG) < 0)
        return logSDLError("initialize PNG images");
    
    if (SDLMixer.open(22050, SDL.Audio.AudioFormat.S16LSB, 2, 4096) == -1)
        return logSDLError("initialize WAV audio");
 
    var title = "Alliance";
    var width = 720;
    var height = 600;

    var window = new Window(title, Window.POS_CENTERED, Window.POS_CENTERED, width, height, WindowFlags.SHOWN);
    var renderer = Renderer.create(window, -1, RendererFlags.ACCELERATED | RendererFlags.PRESENTVSYNC);
    var delta = 0.0;
    var d = 0.0;
    var fps = 60;
    var k = 0;
    var t = 0.0;
    var avg = 0.0;
    var k2 = 0;
    var game = new Game(title, width, height, window, renderer);
    var freq = SDL.Timer.get_performance_frequency();
    var mark1 = (double)SDL.Timer.get_performance_counter()/freq;
    
    MersenneTwister.InitGenrand((ulong)SDL.Timer.get_performance_counter());
    
    game.start();
    while (game.isRunning())
    {
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
    return 0;
    
}
