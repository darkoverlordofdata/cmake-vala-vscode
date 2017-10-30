[indent=4]
uses
    SDL
    SDLMixer
    Bosco
    Bosco.ECS

class SoundEffectSystem : DarkMatter implements ISystem, ISetWorld, IInitializeSystem, IExecuteSystem
    _group: Group
    _game : Game
    _pew : Chunk
    _asplode : Chunk
    _smallasplode : Chunk

    construct(game : Game)
        _game = game

    def setWorld(world:World)
        _group = world.getGroup(Matcher.AllOf({Component.SoundEffect}))

    def initialize()
        _pew = new Chunk.WAV("res/sounds/pew.wav")
        _asplode = new Chunk.WAV("res/sounds/asplode.wav")
        _smallasplode = new Chunk.WAV("res/sounds/smallasplode.wav")

    def execute()
        for var entity in _group.getEntities()
            case entity.soundEffect.effect
                when 0  //Effect.PEW
                    SDLMixer.play(-1, _pew)
                when 1  //Effect.ASPLODE
                    SDLMixer.play(-1, _asplode)
                when 2  //Effect.SMALLASPLODE
                    SDLMixer.play(-1, _smallasplode)



