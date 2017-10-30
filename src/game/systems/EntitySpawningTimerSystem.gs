[indent=4]
uses
    Bosco
    Bosco.ECS

class EntitySpawningTimerSystem : DarkMatter implements ISystem, ISetWorld, IInitializeSystem, IExecuteSystem
    _game : Game
    _world : World
    _timer1 : double
    _timer2 : double
    _timer3 : double

    construct(game : Game)
        _game = game

    def setWorld(world : World)
        _world = world

    def initialize()
        _timer1 = 2.0
        _timer2 = 6.0
        _timer3 = 12.0

    def execute()
        _timer1 = spawnEnemy(_timer1, Enemy.Enemy1)
        _timer2 = spawnEnemy(_timer2, Enemy.Enemy2)
        _timer3 = spawnEnemy(_timer3, Enemy.Enemy3)

    def spawnEnemy(t : double, enemy : Enemy) : double
        var delta = t - _game.delta
        result : double
        if delta < 0
            case enemy
                when Enemy.Enemy1
                    createEnemy1()
                    result = 2.0
                when Enemy.Enemy2
                    createEnemy2()
                    result = 6.0
                when Enemy.Enemy3
                    createEnemy3()
                    result = 12.0
                default
                    result = 0
        else
            result = delta
        return result


