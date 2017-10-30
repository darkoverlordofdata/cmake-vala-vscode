[indent=4]
uses
    SDL
    SDLTTF
    Bosco
    Bosco.ECS

class HudRenderSystem : DarkMatter implements ISystem, ISetWorld, IInitializeSystem, IExecuteSystem

    const WHITE : Video.Color = {250, 250, 250}

    const ACTIVE_ENTITIES : string  = "Active entities:         %3d"
    const TOTAL_RETAINED : string   = "Total reusable:          %3d"
    const TOTAL_REUSABLE : string   = "Total retained:          %3d"

    _game : Game
    _world : World
    _font: SDLTTF.Font
    _activeEntities : Sprite
    _totalRetained : Sprite
    _totalReusable : Sprite
    _renderer : unowned Video.Renderer

    construct(game : Game)
        _game = game
        _renderer = _game.renderer

    def setWorld(world : World)
        _world = world

    def initialize()
        _font = new Font(RES+"/TitanOne-Regular.ttf", 16)
        if _font == null
            print "Failed to load font"

        _game.sprites.add(_activeEntities = createText(0, 40, ACTIVE_ENTITIES.printf(_world.count)))
        _game.sprites.add(_totalRetained = createText(0, 60, TOTAL_RETAINED.printf(_world.reusableEntitiesCount)))
        _game.sprites.add(_totalReusable = createText(0, 80, TOTAL_REUSABLE.printf(_world.retainedEntitiesCount)))

    def execute()
        setText(_activeEntities, ACTIVE_ENTITIES.printf(_world.count))
        setText(_totalRetained, TOTAL_RETAINED.printf(_world.retainedEntitiesCount))
        setText(_totalReusable, TOTAL_REUSABLE.printf(_world.reusableEntitiesCount))

    def createText(x : int, y : int, text : string) : Sprite
        var sprite = Sprite.fromRenderedText(_renderer, _font, text, WHITE)
        sprite.x = x
        sprite.y = y
        sprite.layer = Layer.HUD
        sprite.centered = false
        return sprite

    def setText(sprite : Sprite, text : string)
        sprite.setText(_renderer, _font, text, WHITE)


