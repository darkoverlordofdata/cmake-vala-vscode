[indent=4]
uses
    Bosco
    Bosco.ECS

class DestroySystem : DarkMatter implements ISystem, ISetWorld, IInitializeSystem, IExecuteSystem
    _world : World
    _group : Group
    _game : Game
    _sprites : GenericArray of Sprite

    construct(game : Game)
        _game = game

    def setWorld(world : World)
        _world = world

    def initialize()
        _group = _world.getGroup(Matcher.AllOf({Component.Destroy}))
        _sprites = _game.sprites

    def execute()
        res : ResourceComponent

        for var entity in _group.getEntities()
            if entity.hasResource
                res = entity.resource
                for var i=0 to (_sprites.length-1)
                    if _sprites[i].id == res.sprite.id
                        _sprites.remove_index(i)
                        break

            _world.destroyEntity(entity)


