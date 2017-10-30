[indent=4]
uses
    Bosco
    Bosco.ECS

class RemoveOffscreenShipsSystem : DarkMatter implements ISystem, ISetWorld, IInitializeSystem, IExecuteSystem
    _world : World
    _group : Group
    _game : Game

    construct(game : Game)
        _game = game

    def setWorld(world : World)
        _world = world

    def initialize()
        _group = _world.getGroup(Matcher.AllOf({Component.Position, Component.Bounds}))

    def execute()
        for var entity in _group.getEntities()
            if entity.hasComponent(Component.Position)
                if entity.position.y > _game.height - entity.bounds.radius
                    if !entity.isPlayer
                        entity.setDestroy(true)
                        



