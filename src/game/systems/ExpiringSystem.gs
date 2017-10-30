[indent=4]
uses
    Bosco
    Bosco.ECS

class ExpiringSystem : DarkMatter implements ISystem, ISetWorld, IInitializeSystem, IExecuteSystem
    _world : World
    _group : Group
    _game : Game

    construct(game : Game)
        _game = game

    def setWorld(world:World)
        _world = world

    def initialize()
        _group = _world.getGroup(Matcher.AllOf({Component.Expires}))

    def execute()
        for var entity in _group.getEntities()
            if (entity.expires.delay -= _game.delta) <= 0
                entity.setDestroy(true)


