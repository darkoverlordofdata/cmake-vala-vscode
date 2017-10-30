[indent=4]
uses
    SDL
    Bosco
    Bosco.ECS

class ViewManagerSystem : DarkMatter implements ISystem, IInitializeSystem, ISetWorld

    _renderer : unowned Video.Renderer
    _sprites : GenericArray of Sprite
    _group : Group
    _world : World
    _game : Game

    construct(game : Game)
        _game = game
        _renderer = _game.renderer

    def setWorld(world : World)
        _world = world

    /**
     * Listen for resources to be added
     * and then load them in from the file
     */
    def initialize()
        _group = _world.getGroup(Matcher.AllOf({Component.Resource}))
        _group.onEntityAdded.add(onEntityAdded)
        _game.sprites = new GenericArray of Sprite
        _sprites = _game.sprites


    /**
     *  OnEntityAdded event:
     */
    def onEntityAdded(g : Group, e : Entity, ix : int, c : IComponent)

        scale : ScaleComponent
        layer : LayerComponent
        ordinal : int = 0

        var res = (ResourceComponent)c
        res.sprite = Sprite.fromFile(_renderer, res.path)
        if res.sprite == null
            print "Failed to load %s", res.path
            return

        if e.hasScale
            res.sprite.scale.x = e.scale.x
            res.sprite.scale.y = e.scale.y

        if e.hasLayer
            res.sprite.layer = e.layer.ordinal
            ordinal = e.layer.ordinal

        if e.hasTint
            res.sprite.color.r = (uint8)e.tint.r
            res.sprite.color.g = (uint8)e.tint.g
            res.sprite.color.b = (uint8)e.tint.b

        if res.bgd
            res.sprite.centered = false

        /**
         * Insert sprite in layer order
         */
        if _sprites.length == 0
            _sprites.add(res.sprite)
        else
            for var i=0 to (_sprites.length-1)
                if ordinal <= _sprites[i].layer
                    _sprites.insert(i, res.sprite)
                    return
            _sprites.add(res.sprite)



