[indent=4]
uses
    Bosco
    Bosco.ECS
    SDL




/** 
 * Start the application
 */
init
    var game = new Game()
    game.Run()

class Game : AbstractGame

    world : World
    player : PlayerInputSystem

    construct()
        name = "Shmup Warz"
        width = SCREEN_WIDTH
        height = SCREEN_HEIGHT
        running = true

    /**
     *  OnLoop
     *
     * Process the game engine
     */
    def override Update(delta: double)
        world.execute()
    /**
     *  OnInit
     *
     * load assets
     */
    def override Initialize():bool
        if super.Initialize()

            world = new World(components)
            world.add(new MovementSystem(this))
            world.add(player = new PlayerInputSystem(this))
            world.add(new SoundEffectSystem(this))
            world.add(new CollisionSystem(this))
            world.add(new ExpiringSystem(this))
            world.add(new EntitySpawningTimerSystem(this))
            world.add(new ColorTweenSystem(this))
            world.add(new ScaleTweenSystem(this))
            world.add(new RemoveOffscreenShipsSystem(this))
            world.add(new ViewManagerSystem(this))
            world.add(new RenderPositionSystem(this))
            // world.add(HealthRenderSystem())
            world.add(new HudRenderSystem(this))
            world.add(new DestroySystem(this))
            world.initialize()

            createBackground()
            createPlayer()

        return true

    /**
     *  OnEvent
     *
     * Handle events
     */
    def override Events(e:SDL.Event)
        if keys[Input.Keycode.ESCAPE] == 1
            running = false

        if e.type == SDL.EventType.QUIT
            running = false

        if e.type != EventType.MOUSEMOTION && e.type != EventType.MOUSEBUTTONDOWN && e.type != EventType.MOUSEBUTTONUP
            return
        /* Mouse Events*/
        x:int = 0
        y:int = 0
        Input.Cursor.get_state(ref x, ref y)
        player.onMouseEvent(e.type, x, y)

    /**
     *  OnCleanup
     *
     * release assets
     */
    def override Dispose()
        SDL.quit()
        SDLImage.quit()


