[indent=4]
uses
    Bosco
    Bosco.ECS

class ColorTweenSystem : DarkMatter implements ISystem, ISetWorld, IInitializeSystem, IExecuteSystem
    _world : World
    _group : Group
    _game : Game

    construct(game : Game)
        _game = game

    def setWorld(world : World)
        _world = world

    def initialize()
        _group = _world.getGroup(Matcher.AllOf({Component.ColorTween, Component.Tint}))

    def execute()
        var delta = _game.delta
        for var entity in _group.getEntities()
            var tint = entity.tint
            var tween = entity.colorTween
            
            if tween.redAnimate
                tint.r = tint.r + (int)((double)tween.redSpeed * delta)
                if tint.r > tween.redMax || tint.r < tween.redMin
                    if tween.repeat
                        tween.redSpeed = -tween.redSpeed
                    else
                        tween.redAnimate = false
                        
            if tween.greenAnimate
                tint.g = tint.g + (int)((double)tween.greenSpeed * delta)
                if tint.g > tween.greenMax || tint.g < tween.greenMin
                    if tween.repeat
                        tween.greenSpeed = -tween.greenSpeed
                    else
                        tween.greenAnimate = false
                        
            if tween.blueAnimate
                tint.b = tint.b + (int)((double)tween.blueSpeed * delta)
                if tint.b > tween.blueMax || tint.b < tween.blueMin
                    if tween.repeat
                        tween.blueSpeed = -tween.blueSpeed
                    else
                        tween.blueAnimate = false
                        
            if tween.alphaAnimate
                tint.a = tint.a + (int)((double)tween.alphaSpeed * delta)
                if tint.a > tween.alphaMax || tint.a < tween.alphaMin
                    if tween.repeat
                        tween.alphaSpeed = -tween.alphaSpeed
                    else
                        tween.alphaAnimate = false

            var sprite = entity.resource.sprite
            sprite.color.r = (uint8)tint.r
            sprite.color.g = (uint8)tint.g
            sprite.color.b = (uint8)tint.b
            //stdout.printf("color: %d %d %d", tint.r, tint.g, tint.b)
                        

