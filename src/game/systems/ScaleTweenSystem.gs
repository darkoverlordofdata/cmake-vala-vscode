[indent=4]
uses
    Bosco
    Bosco.ECS

class ScaleTweenSystem : DarkMatter implements ISystem, ISetWorld, IInitializeSystem, IExecuteSystem
    _world : World
    _group : Group
    _game : Game

    construct(game : Game)
        _game = game

    def setWorld(world : World)
        _world = world

    def initialize()
        _group = _world.getGroup(Matcher.AllOf({Component.ScaleTween, Component.Resource}))

    def execute()
        for var entity in _group.getEntities()

            var scaleTween = entity.scaleTween

            if scaleTween.active
                var res = entity.resource
                var scale = res.sprite.scale

                res.sprite.scale.x += scaleTween.speed * _game.delta
                res.sprite.scale.y += scaleTween.speed * _game.delta

                if scale.x > scaleTween.max
                    res.sprite.scale.x = scaleTween.max
                    res.sprite.scale.y = scaleTween.max
                    scaleTween.active = false

                else if scale.x < scaleTween.min
                    res.sprite.scale.x = scaleTween.min
                    res.sprite.scale.y = scaleTween.min
                    scaleTween.active = false



