using Sdx;
using Entitas;
using Systems;
	
/**
 * Game controller 
 */
public class Game : AbstractGame 
{
	public Game(Sdx.Ui.Window window) 
	{
		width = (int)window.bounds.w;
		height = (int)window.bounds.h;

		print("%d,%d\n", width, height);
		//
		//  Sdx.SetResourceBase("/darkoverlordofdata/shmupwarz");
		Sdx.SetSmallFont("assets/fonts/OpenDyslexic-Bold.otf", 16);
		print("SetSmallFont\n");
		Sdx.SetDefaultFont("assets/fonts/OpenDyslexic-Bold.otf", 24);
		print("SetDefaultFont\n");
		Sdx.SetLargeFont("assets/fonts/OpenDyslexic-Bold.otf", 36);
		print("SetLargeFont\n");
		Sdx.SetAtlas("assets/assets.atlas");
		print("Set Atlas\n");
		
		/**  
		 * Create the UI 
		 */
		var world = new Factory();
		var label = new Sdx.Ui.Label.Text(window.name, largeFont, Sdx.Color.NavajoWhite, Sdx.Color.DodgerBlue);
		var button = new Sdx.Ui.Button.NinePatch("Start", largeFont, Sdx.Color.Black, "btn", "btnPressed");
		
		window.Add(label.SetPos(width/2-label.width/2, 10));
		window.Add(button.SetPos(width/2-button.width/2, height/3));

		/**
		 * Start Button clicked
		 */
		button.OnMouseClick = (c, x, y) => 
		{
			window.Remove(label);
			window.Remove(button);
			world.AddPlayer(x, y);
			Update = () =>
			{
				world.Execute(Sdx.delta);
			};
		};
		
		/**
		 * Set up the game
		 */
		var display = new DisplaySystem(this, world);
		
		world.AddSystem(new SpawnSystem(this, world))
			.AddSystem(new InputSystem(this, world))
			.AddSystem(new PhysicsSystem(this, world))
			.AddSystem(new CollisionSystem(this, world))
			.AddSystem(new AnimationSystem(this, world))
			.AddSystem(new ExpireSystem(this, world))
			.AddSystem(new SoundSystem(this, world))
			.AddSystem(new ScoreSystem(this, world));

		world.Initialize();
		world.AddBackground(0, 0);

	}
}
