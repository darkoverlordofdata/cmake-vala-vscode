[indent=4]
uses
    SDL
    Bosco
    Bosco.ECS

class RenderPositionSystem : DarkMatter implements ISystem, ISetWorld, IInitializeSystem, IExecuteSystem
    _renderer : unowned Video.Renderer
    _group: Group
    _game : Game
    _sprites : GenericArray of Sprite

    construct(game : Game)
        _game = game
        _renderer = _game.renderer

    def setWorld(world:World)
        _group = world.getGroup(Matcher.AllOf({Component.Resource, Component.Position}))

    def initialize()
        _sprites = _game.sprites

    def execute()
        for var entity in _group.getEntities()
            var res = entity.resource
            var pos = entity.position
            res.sprite.x = (int)pos.x
            res.sprite.y = (int)pos.y



