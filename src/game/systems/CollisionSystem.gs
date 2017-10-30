[indent=4]
uses
    Bosco
    Bosco.ECS
    GLib

class CollisionSystem : DarkMatter implements ISystem, ISetWorld, IInitializeSystem, IExecuteSystem
    _world : World
    _game : Game
    _bullets : Group
    _enemies : Group

    construct(game : Game)
        _game = game

    def setWorld(world : World)
        _world = world

    def initialize()
        _bullets = _world.getGroup(Matcher.AllOf({Component.Bullet}))
        _enemies = _world.getGroup(Matcher.AllOf({Component.Enemy}))


    def execute()
        for var entityA in _bullets.getEntities()
            for var entityB in _enemies.getEntities()
                if collisionExists(entityA, entityB)
                    handleCollision(entityA, entityB)


    def collisionExists(e1: Entity, e2: Entity): bool
        var result = false

        if e1 == null || e2 == null do return result

        var p1 = e1.position
        var p2 = e2.position
        var b1 = e1.bounds
        var b2 = e2.bounds
        var a = p1.x - p2.x
        var b = p1.y - p2.y

        result = Math.sqrt(a * a + b * b) - (b1.radius) < (b2.radius)

        return result

    def handleCollision(bullet: Entity, ship: Entity)
        var bp = bullet.position
        var health = ship.health
        var position = ship.position
        var x = bp.x
        var y = bp.y

        createBang(x, y)
        var i = 5
        while --i > 0 do createParticle(x, y)

        if !bullet.isDestroy do bullet.setDestroy(true)
        health.health -= 1
        if health.health < 0
            if !ship.isDestroy do ship.setDestroy(true)
            createExplosion(position.x, position.y)


