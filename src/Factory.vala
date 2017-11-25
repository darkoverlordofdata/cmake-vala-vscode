using SDL;
using SDL.Video;
#if (!EMSCRIPTEN)
using SDLMixer;
#endif
/** 
 * Entity Factory
 */

public class Factory : Object {
    public List<Entity*> active = new List<Entity*>();

    const int KBULLET = 12;
    const int KENEMY1 = 15;
    const int KENEMY2 = 5;
    const int KENEMY3 = 4;
    const int KEXPLODE = 10;
    const int KBANG = 12;
    const int KPARTICLE = 100;
    const int KALL = 2+KBULLET+KENEMY1+KENEMY2+KENEMY3+KEXPLODE+KBANG+KPARTICLE;
        
    private Game game;
    private Systems systems;
    private int nextId;
    private Entity* player;
    private Entity[] pool;
    
    public Factory(Game game, Renderer renderer) {
        this.game = game;
        systems = new Systems(game, this);
        pool = new Entity[KALL];
        nextId = 0;

        game.addSprite(createBackground(renderer));
        game.addSprite(createPlayer(renderer));

        for (int i=0; i<KBULLET; i++)   createBullet(renderer);
        for (int i=0; i<KENEMY1; i++)   createEnemy1(renderer);
        for (int i=0; i<KENEMY2; i++)   createEnemy2(renderer);
        for (int i=0; i<KENEMY3; i++)   createEnemy3(renderer);
        for (int i=0; i<KEXPLODE; i++)  createExplosion(renderer);
        for (int i=0; i<KBANG; i++)     createBang(renderer);
        for (int i=0; i<KPARTICLE; i++) createParticle(renderer);
        
    }

    public Entity* createBackground(Renderer renderer) {
        var id = nextId++;
        var scale = 2.0;
        var surface = loadImg("assets/images/background.png");
        var w = (int)((double)surface.w*scale);
        var h = (int)((double)surface.h*scale);

        pool[id] = Entity() { 
            id          = id, 
            name        = "background", 
            active      = true, 
            actor       = Actor.BACKGROUND, 
            category    = Category.BACKGROUND,
            position    = { 0, 0 }, 
            bounds      = { 0, 0, w, h }, 
            scale       = { scale, scale },
            sprite      = { Video.Texture.create_from_surface(renderer, surface), w, h }
        };
        return &pool[id];
    }

    public Entity* createPlayer(Renderer renderer) {
        var id = nextId++;
        var scale = 1.0;
        var surface = loadImg("assets/images/spaceshipspr.png");
        var w = (int)((double)surface.w*scale);
        var h = (int)((double)surface.h*scale);

        pool[id] = Entity() { 
            id          = id, 
            name        = "player", 
            active      = true, 
            actor       = Actor.PLAYER, 
            category    = Category.PLAYER,
            position    = { 0, 0 }, 
            bounds      = { 0, 0, w, h }, 
            scale       = { scale, scale },
            sprite      = { Video.Texture.create_from_surface(renderer, surface), w, h }
        };
        player = &pool[id];
        return &pool[id];
    }

    public void createBullet(Renderer renderer) {
        var id = nextId++;
        var scale = 1.0;
        var surface = loadImg("assets/images/bullet.png");
        var w = (int)((double)surface.w*scale);
        var h = (int)((double)surface.h*scale);

        pool[id] = Entity() { 
            id          = id, 
            name        = "bullet", 
            active      = false, 
            actor       = Actor.BULLET, 
            category    = Category.BULLET,
            position    = { 0, 0 }, 
            bounds      = { 0, 0, w, h }, 
            scale       = { scale, scale },
            sprite      = { Video.Texture.create_from_surface(renderer, surface), w, h },
            sound       = { Effect.PEW },
            tint        = { 0xd2, 0xfa, 0x00, 0xffa },
            expires     = { 1.0 },
            health      = { 2, 2 },
            velocity    = { 0, -800 }
        };
    }

    public void refreshBullet(ref Entity* entity, int x, int y)
    { 
        entity.position.x = x;
        entity.position.y = y;
        entity.expires.value = 1.0;
        entity.active = true;
        game.addSprite(entity);
    }

    public void createEnemy1(Renderer renderer)
    {
        var id = nextId++;
        var scale = 1.0;
        var surface = loadImg("assets/images/enemy1.png");
        var w = (int)((double)surface.w*scale);
        var h = (int)((double)surface.h*scale);

        pool[id] = Entity() { 
            id          = id, 
            name        = "enemy1", 
            active      = false, 
            actor       = Actor.ENEMY1, 
            category    = Category.ENEMY,
            position    = { 0, 0 }, 
            bounds      = { 0, 0, w, h }, 
            scale       = { scale, scale },
            sprite      = { Video.Texture.create_from_surface(renderer, surface), w, h },
            health      = { 10, 10 },
            velocity    = { 0, 40 }
        };
    }

    public void refreshEnemy1(ref Entity* entity, int x, int y)
    { 
        entity.position.x = x;
        entity.position.y = y;
        entity.health.current = 10;
        entity.active = true;
        game.addSprite(entity);
    }

    public void createEnemy2(Renderer renderer)
    {
        var id = nextId++;
        var scale = 1.0;
        var surface = loadImg("assets/images/enemy2.png");
        var w = (int)((double)surface.w*scale);
        var h = (int)((double)surface.h*scale);

        pool[id] = Entity() { 
            id          = id, 
            name        = "enemy2", 
            active      = false, 
            actor       = Actor.ENEMY2, 
            category    = Category.ENEMY,
            position    = { 0, 0 }, 
            bounds      = { 0, 0, w, h }, 
            scale       = { scale, scale },
            sprite      = { Video.Texture.create_from_surface(renderer, surface), w, h },
            health      = { 20, 20 },
            velocity    = { 0, 30 }
        };
    }

    public void refreshEnemy2(ref Entity* entity, int x, int y)
    {
        entity.position.x = x;
        entity.position.y = y;
        entity.health.current = 20;
        entity.active = true;
        game.addSprite(entity);
    }

    public void createEnemy3(Renderer renderer)
    {
        var id = nextId++;
        var scale = 1.0;
        var surface = loadImg("assets/images/enemy3.png");
        var w = (int)((double)surface.w*scale);
        var h = (int)((double)surface.h*scale);

        pool[id] = Entity() { 
            id          = id, 
            name        = "enemy3", 
            active      = false, 
            actor       = Actor.ENEMY3, 
            category    = Category.ENEMY,
            position    = { 0, 0 }, 
            bounds      = { 0, 0, w, h }, 
            scale       = { scale, scale },
            sprite      = { Video.Texture.create_from_surface(renderer, surface), w, h },
            health      = { 60, 60 },
            velocity    = { 0, 20 }
        };
    }

    public void refreshEnemy3(ref Entity* entity, int x, int y)
    {
        entity.position.x = x;
        entity.position.y = y;
        entity.health.current = 60;
        entity.active = true;
        game.addSprite(entity);
    }

    public void createExplosion(Renderer renderer)
    {
        var id = nextId++;
        var scale = 0.6;
        var surface = loadImg("assets/images/explosion.png");
        var w = (int)((double)surface.w*scale);
        var h = (int)((double)surface.h*scale);

        pool[id] = Entity() { 
            id          = id, 
            name        = "explosion", 
            active      = false, 
            actor       = Actor.EXPLOSION, 
            category    = Category.EXPLOSION,
            position    = { 0, 0 }, 
            bounds      = { 0, 0, w, h }, 
            scale       = { scale, scale },
            sprite      = { Video.Texture.create_from_surface(renderer, surface), w, h },
            sound       = { Effect.ASPLODE },
            tint        = { 0xd2, 0xfa, 0xd2, 0xfa },
            expires     = { 0.2 },
            tween       = { scale/100.0, scale, -3, false, true }
        };
    }

    public void refreshExplosion(ref Entity* entity, int x, int y)
    {
        entity.position.x = x;
        entity.position.y = y;
        entity.bounds.x = x;
        entity.bounds.y = y;
        entity.scale.x = 0.6;
        entity.scale.y = 0.6;
        entity.tween.active = true;
        entity.expires.value = 0.2;
        entity.active = true;
        game.addSprite(entity);
    }

    public void createBang(Renderer renderer)
    {
        var id = nextId++;
        var scale = 0.4;
        var surface = loadImg("assets/images/explosion.png");
        var w = (int)((double)surface.w*scale);
        var h = (int)((double)surface.h*scale);

        pool[id] = Entity() { 
            id          = id, 
            name        = "bang", 
            active      = false, 
            actor       = Actor.BANG, 
            category    = Category.EXPLOSION,
            position    = { 0, 0 }, 
            bounds      = { 0, 0, w, h }, 
            scale       = { scale, scale },
            sprite      = { Video.Texture.create_from_surface(renderer, surface), w, h },
            sound       = { Effect.SMALLASPLODE },
            tint        = { 0xd2, 0xfa, 0xd2, 0xfa },
            expires     = { 0.2 },
            tween       = { scale/100.0, scale, -3, false, true }
        };
    }

    public void refreshBang(ref Entity* entity, int x, int y)
    {
        entity.position.x = x;
        entity.position.y = y;
        entity.bounds.x = x; 
        entity.bounds.y = y; 
        entity.scale.x = 0.4;
        entity.scale.y = 0.4;
        entity.tween.active = true;
        entity.expires.value = 0.2;
        entity.active = true;
        game.addSprite(entity);
    }

    public void createParticle(Renderer renderer)
    {
        var id = nextId++;
        var scale = 1.0;
        var surface = loadImg("assets/images/star.png");
        var w = (int)((double)surface.w*scale);
        var h = (int)((double)surface.h*scale);

        pool[id] = Entity() { 
            id          = id, 
            name        = "particle", 
            active      = false, 
            actor       = Actor.PARTICLE, 
            category    = Category.PARTICLE,
            position    = { 0, 0 }, 
            bounds      = { 0, 0, w, h }, 
            scale       = { scale, scale },
            sprite      = { Video.Texture.create_from_surface(renderer, surface), w, h },
            tint        = { 0xd2, 0xfa, 0xd2, 0xfa },
            expires     = { 0.75 },
            velocity    = { 0, 0 }
        };
    }

    public void refreshParticle(ref Entity* entity, int x, int y) 
    {
        var radians = MersenneTwister.GenrandReal2() * 6.28;
        var magnitude = MersenneTwister.GenrandReal2() * 200; 
        var velocityX = magnitude * Math.cos(radians);
        var velocityY = magnitude * Math.sin(radians);
        var scale = (float)MersenneTwister.GenrandReal2();

        entity.position.x = x;
        entity.position.y = y;
        entity.bounds.x = x; 
        entity.bounds.y = y; 
        entity.scale.x = scale;
        entity.scale.y = scale;
        entity.velocity.x = velocityX;
        entity.velocity.y = velocityY;
        entity.expires.value = 0.75;
        entity.active = true;
        game.addSprite(entity);
    }

    public void update() {
        
        active = new List<Entity*>();
        var unused = new List<Entity*>();
        for (var i = 0; i<nextId-1; i++) 
            if (pool[i].active) active.append(&pool[i]);
            else unused.append(&pool[i]);
        
        systems.spawnSystem(ref player);
        systems.inputSystem(ref player);
        active.foreach(e => systems.collisionSystem(ref e));
        unused.foreach(e => systems.entitySystem(ref e));
        active.foreach(e => systems.soundSystem(ref e));
        active.foreach(e => systems.physicsSystem(ref e));
        active.foreach(e => systems.expireSystem(ref e));
        active.foreach(e => systems.tweenSystem(ref e));
        active.foreach(e => systems.removeSystem(ref e));
    }

    public Surface loadImg(string name) {
        var raw = new SDL.RWops.from_file(name, "r");
        if (raw == null) {
            print("Unable to load image %s\n", name);
        }
        return SDLImage.load_png(raw);
    }
    
    #if (!EMSCRIPTEN)

    public Chunk loadWav(string name) {
        var raw = new SDL.RWops.from_file(name, "r");
        if (raw == null) {
            print("Unable to load wav %s\n", name);
        }
        return new SDLMixer.Chunk.WAV_RW(raw);
    }
    #endif    
            
}