using SDL;
using SDL.Video;
using SDLImage;
#if (!EMSCRIPTEN)
using SDLMixer;
#endif
/**
 *
 */

public class Systems : Object {
    
    const double TIMER1 = 1.0;
    const double TIMER2 = 4.0;
    const double TIMER3 = 6.0;
    const double FIRE_RATE = 0.1;
    
    private Game game;
    private Factory factory;
    private double timeToFire;
    private double enemyT1;
    private double enemyT2;
    private double enemyT3;
    #if (!EMSCRIPTEN)
    private Chunk pew;
    private Chunk asplode;
    private Chunk smallasplode;
    #endif
    private List<Point2d?> bullets = new List<Point2d?>();
    private List<Point2d?> enemies1 = new List<Point2d?>();
    private List<Point2d?> enemies2 = new List<Point2d?>();
    private List<Point2d?> enemies3 = new List<Point2d?>();
    private List<Point2d?> explosions = new List<Point2d?>();
    private List<Point2d?> bangs = new List<Point2d?>();
    private List<Point2d?> particles = new List<Point2d?>();
    
    public Systems(Game game, Factory factory) {
        this.game = game;
        this.factory = factory;
        timeToFire = 0.0;
        enemyT1 = TIMER1;
        enemyT2 = TIMER2;
        enemyT3 = TIMER3;
            
        #if (!EMSCRIPTEN)
        pew = factory.loadWav("assets/sounds/pew.wav");
        asplode = factory.loadWav("assets/sounds/asplode.wav");
        smallasplode = factory.loadWav("assets/sounds/smallasplode.wav");
        #endif
    }
    
    public void inputSystem(ref Entity* entity) {
        entity.position.x = game.mouseX;
        entity.position.y = game.mouseY;
        if (game.getKey(122) != 0 || game.mouseDown) {
            timeToFire -= game.delta;
            if (timeToFire < 0.0) {
                bullets.append({ entity.position.x - 27, entity.position.y + 2 });
                bullets.append({ entity.position.x + 27, entity.position.y + 2 });
                timeToFire = FIRE_RATE;
            }
        }
    }

    public void soundSystem(ref Entity* entity) {
        if (entity.active && entity.sound != null) {
            switch(entity.sound.value) {

                case Effect.PEW: 
                    #if (!EMSCRIPTEN)
                    SDLMixer.play(-1, pew, 0);
                    #endif
                    break;

                case Effect.ASPLODE: 
                    #if (!EMSCRIPTEN)
                    SDLMixer.play(-1, asplode, 0);
                    #endif
                    break;

                case Effect.SMALLASPLODE: 
                    #if (!EMSCRIPTEN)
                    SDLMixer.play(-1, smallasplode, 0);
                    #endif
                    break;
            }
        }
    }

    public void physicsSystem(ref Entity* entity) {
        if (entity.active && entity.velocity != null) {
            entity.position.x += entity.velocity.x * game.delta;
            entity.position.y += entity.velocity.y * game.delta;
        }
    }

    public void expireSystem(ref Entity* entity) {
        if (entity.active && entity.expires != null) {
            var exp = entity.expires.value - game.delta;
            entity.expires.value = exp;
            if (entity.expires.value < 0) {
                entity.active = false;
            }
        }
    }

    public void tweenSystem(ref Entity* entity) {
        if (entity.active && entity.tween != null) {

            var x = entity.scale.x + (entity.tween.speed * game.delta);
            var y = entity.scale.y + (entity.tween.speed * game.delta);
            var active = entity.tween.active;

            if (x > entity.tween.max) {
                x = entity.tween.max;
                y = entity.tween.max;
                active = false;
            } else if (x < entity.tween.min) {
                x = entity.tween.min;
                y = entity.tween.min;
                active = false;
            }
            entity.scale.x = x; 
            entity.scale.y = y; 
            entity.tween.active = active;
        }
    }

    public void removeSystem(ref Entity* entity) {
        if (entity.active) {
            switch(entity.category) {

                case Category.ENEMY:
                    if (entity.position.y > game.height) {
                        entity.active = false;
                    }
                    break;

                case Category.BULLET:
                    if (entity.position.y < 0) {
                        entity.active = false;
                    }
                    break;

                default:
                    break;
            }
        }
    }

    double spawnEnemy(double delta, double t, int enemy) {
        var d1 = t-delta;
        if (d1 < 0.0) {
            switch(enemy) {

                case 1:
                    var x = (int)(MersenneTwister.GenrandReal2() * (game.width-70)) + 35;
                    enemies1.append({ x, 35 });
                    return TIMER1;

                case 2:
                    var x = (int)(MersenneTwister.GenrandReal2() * (game.width-172)) + 85;
                    enemies2.append({ x, 85 });
                    return TIMER2;

                case 3:
                    var x = (int)(MersenneTwister.GenrandReal2() * (game.width-320)) + 160;
                    enemies3.append({ x, 160 });
                    return TIMER3;

                default:
                    return 0;
            }
        } else return d1;    
    }

    public void spawnSystem(ref Entity* entity) {
        enemyT1 = spawnEnemy(game.delta, enemyT1, 1);
        enemyT2 = spawnEnemy(game.delta, enemyT2, 2);
        enemyT3 = spawnEnemy(game.delta, enemyT3, 3);

    }

    public void entitySystem(ref Entity* entity) {
        if (!entity.active) {
            switch(entity.actor) {

                case Actor.BULLET: 
                    if (bullets.length() == 0) break;
                    factory.refreshBullet(ref entity, (int)bullets.first().data.x, (int)bullets.first().data.y);
                    bullets.delete_link(bullets.first());
                    break;

                case Actor.ENEMY1:
                    if (enemies1.length() == 0) break;
                    factory.refreshEnemy1(ref entity, (int)enemies1.first().data.x, (int)enemies1.first().data.y);
                    enemies1.delete_link(enemies1.first());
                    break;

                case Actor.ENEMY2:
                    if (enemies2.length() == 0) break;
                    factory.refreshEnemy2(ref entity, (int)enemies2.first().data.x, (int)enemies2.first().data.y);
                    enemies2.delete_link(enemies2.first());
                    break;

                case Actor.ENEMY3:
                    if (enemies3.length() == 0) break;
                    factory.refreshEnemy3(ref entity, (int)enemies3.first().data.x, (int)enemies3.first().data.y);
                    enemies3.delete_link(enemies3.first());
                    break;

                case Actor.EXPLOSION:  
                    if (explosions.length() == 0) break;
                    factory.refreshExplosion(ref entity, (int)explosions.first().data.x, (int)explosions.first().data.y);
                    explosions.delete_link(explosions.first());
                    break;

                case Actor.BANG:
                    if (bangs.length() == 0) break;
                    factory.refreshBang(ref entity, (int)bangs.first().data.x, (int)bangs.first().data.y);
                    bangs.delete_link(bangs.first());
                    break;

                case Actor.PARTICLE:
                    if (particles.length() == 0) break;
                    factory.refreshParticle(ref entity, (int)particles.first().data.x, (int)particles.first().data.y);
                    particles.delete_link(particles.first());
                    break;

                default:
                    break;
            }
        }

    }

    public void handleCollision(ref Entity* a, ref Entity* b) {
        bangs.append({ b.bounds.x, b.bounds.y });
        b.active = false;
        for (int i=0; i<3; i++) particles.append({ b.bounds.x, b.bounds.y });
        if (a.health != null) { 
            var h = a.health.current - 2;
            if (h < 0) {
                explosions.append({ a.position.x, a.position.y });
                a.active = false;
            } else {
                a.health = { h, a.health.maximum };
            }   
        }
    }

    public void collisionSystem(ref Entity* entity) {
        if (entity.active && entity.category == Category.ENEMY) {
            foreach (var bullet in factory.active) {
                if (bullet.active && bullet.category == Category.BULLET) {
                    if (entity.bounds.is_intersecting(bullet.bounds)) {
                        if (entity.active && bullet.active) handleCollision(ref entity, ref bullet);
                        return;
                    }
                }
            }
        }
    }

}
    
    