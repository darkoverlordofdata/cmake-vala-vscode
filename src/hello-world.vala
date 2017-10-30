using SDL;
using SDL.Video;
using SDLImage;
public class DarkMatter: Object {}

int main (string[] args) {

    var height = 400;
    var width = 640;
    var name = "Frodo";

    print("Hello World\n");
    var x = Math.cos(2*Math.PI);
    print("%f\n", x);

    if (SDL.init(SDL.InitFlag.VIDEO) < 0) {
        print("SDL could not initialize! SDL Error: %s\n", SDL.get_error());
        return 1;
    }

	if (SDLImage.init(SDLImage.InitFlags.PNG) < 0) {
        print("SDLImage could not initialize! SDL Error: %s\n", SDL.get_error());
        return 1;
    }

    var window = new Window(name, Window.POS_CENTERED, Window.POS_CENTERED, width, height, WindowFlags.SHOWN);
    if (window == null) {
        print("Window could not be created! SDL Error: %s\n", SDL.get_error());
        return 1;
    }

    var renderer = Renderer.create(window, -1, RendererFlags.ACCELERATED | RendererFlags.PRESENTVSYNC);
    if (renderer == null) {
        print("Renderer could not be created! SDL Error: %s\n", SDL.get_error());
        return 1;
    }

    var texture = SDLImage.load_texture(renderer, "background.png");

    SDL.Event evt;
    
    var running = true;
    while (running) {
		while (SDL.Event.poll(out evt) != 0) {
			switch (evt.type) {
				case SDL.EventType.QUIT:
					running = false;
                    break;
            }
        }
        renderer.set_draw_color(0xFF, 0xFF, 0xFF, 0);
        renderer.copy(texture, null, null);
        renderer.present();        
    }



    return 0;    
}