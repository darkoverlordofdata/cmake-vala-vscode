[indent=4]
uses
    Bosco
    Bosco.ECS
    GLib
    GLib.Math
    Utils

const Tau : double = 2 * Math.PI
const SCREEN_WIDTH: int = 800
const SCREEN_HEIGHT: int = 600


// #if WINDOWS
const RES: string = "./res" 
// #endif
// #if !WINDOWS
// const RES: string = Constants.PKGDATADIR
// #endif

enum Enemy
    Enemy1
    Enemy2
    Enemy3


enum Layer
    DEFAULT
    BACKGROUND
    TEXT
    LIVES
    MINES
    ACTORS_1
    ACTORS_2
    ACTORS_3
    PLAYER
    BULLET
    PARTICLE
    HUD

enum Effect
    PEW
    ASPLODE
    SMALLASPLODE



/**
 *  Create Background
 */
def createBackground() : Entity
    return World.instance.createEntity("background"
        ).addPosition(0, 0 
        ).addScale(2, 1
        ).addResource(RES+"/BackdropBlackLittleSparkBlack.png", null, true)

/**
 *  Create Player
 */
def createPlayer() : Entity
    return World.instance.createEntity("player"
        ).setPlayer(true
        ).addBounds(43
        ).addHealth(100, 100
        ).addVelocity(0, 0
        ).addLayer(Layer.PLAYER
        ).addPosition(SCREEN_WIDTH/2, SCREEN_HEIGHT-80
        ).addResource(RES+"/fighter.png", null, false)

/**
 *  Create Bullet
 */
def createBullet(x : double, y : double) : Entity
    return World.instance.createEntity("bullet"
        ).setBullet(true
        ).addPosition(x, y
        ).addVelocity(0, -800
        ).addTint(0xAD, 0xFF, 0x2F, 255
        ).addBounds(5
        ).addExpires(1
        ).addLayer(Layer.BULLET
        ).addResource(RES+"/bullet.png", null, false
        ).addSoundEffect(Effect.PEW)

/**
 *  Create Particle
 */
def createParticle(x : double, y : double) : Entity
    var radians = UUID.random.next_double() * Tau
    var magnitude = UUID.random.int_range(0, 200)
    var velocityX = magnitude * Math.cos(radians)
    var velocityY = magnitude * Math.sin(radians)
    var scale = UUID.random.double_range(0.1, 1.0)
    return World.instance.createEntity("particle"
        ).addPosition(x, y
        ).addVelocity(velocityX, velocityY
        ).addExpires(1
        ).addLayer(Layer.PARTICLE
        ).addScale(scale, scale
        ).addTint(0xFA, 0xFA, 0xD2, 255
        ).addResource(RES+"/star.png", null, false)

/**
 *  Create Explosion
 */
def createExplosion(x: double, y: double) : Entity
    return World.instance.createEntity("explosion"
        ).addPosition(x, y
        ).addExpires(1.0
        ).addLayer(Layer.PARTICLE
        ).addScale(0.5, 0.5
        ).addSoundEffect(Effect.ASPLODE
        ).addScaleTween(0.001, 0.5, -3, false, true
        ).addTint(0xFA, 0xFA, 0xD2, 255
        ).addResource(RES+"/explosion.png", null, false)

def createBang(x: double, y: double) : Entity
    return World.instance.createEntity("explosion"
        ).addPosition(x, y
        ).addExpires(1.0
        ).addLayer(Layer.PARTICLE
        ).addScale(1.0, 1.0
        ).addSoundEffect(Effect.SMALLASPLODE
        ).addScaleTween(0.001, 1.0, -3, false, true
        ).addTint(0xEE, 0xE8, 0xAA, 255
        ).addResource(RES+"/bang.png", null, false)

def createEnemy1() : Entity
    var x = UUID.random.int_range(0, SCREEN_WIDTH)
    var y = SCREEN_HEIGHT/2 - 200
    return World.instance.createEntity("enemy1"
        ).setEnemy(true
        ).addBounds(20
        ).addHealth(10, 10
        ).addVelocity(0, 40
        ).addLayer(Layer.ACTORS_1
        ).addPosition(x, y
        ).addResource(RES+"/enemy1.png", null, false)


def createEnemy2() : Entity
    var x = UUID.random.int_range(0, SCREEN_WIDTH)
    var y = SCREEN_HEIGHT/2 - 100
    return World.instance.createEntity("enemy2"
        ).setEnemy(true
        ).addBounds(40
        ).addHealth(20, 20
        ).addVelocity(0, 30
        ).addLayer(Layer.ACTORS_2
        ).addPosition(x, y
        ).addResource(RES+"/enemy2.png", null, false)


def createEnemy3() : Entity
    var x = UUID.random.int_range(0, SCREEN_WIDTH)
    var y = SCREEN_HEIGHT/2 - 50
    return World.instance.createEntity("enemy3"
        ).setEnemy(true
        ).addBounds(70
        ).addHealth(60, 60
        ).addVelocity(0, 20
        ).addLayer(Layer.ACTORS_3
        ).addPosition(x, y
        ).addResource(RES+"/enemy3.png", null, false)




