using Entitas;
using Sdx;
namespace Systems 
{
	/**
	* game systems
	*/
	public class InputSystem : System 
	{

		const float FIRE_RATE = 0.1f;
		public InputSystem(Game game, Factory world) 
		{

			var x = 0;
			var y = 0;
			var mouseDown = false;
			var shoot = false;
			var timeToFire = FIRE_RATE;
			var player = world.GetGroup(Matcher.AllOf({ Components.PlayerComponent }));

			/**
			 * get player input
			 */
			Execute = (delta) => 
			{
				player.GetSingleEntity().SetPosition(x, y);
				if (shoot || mouseDown) timeToFire -= delta;
				if (timeToFire < 0) 
				{
					world.AddBullet(x + 27, y + 2);
					world.AddBullet(x - 27, y + 2);
					timeToFire = FIRE_RATE;
				}
			};

			/**
			 * process input events
			 */
			Sdx.AddInputProcessor(new InputProcessor() 
			
				.SetKeyDown((keycode) => 
				{
					if (keycode == SDL.Input.Keycode.z) shoot = true;
					return false;
				})

				.SetKeyUp((keycode) => 
				{
					if (keycode == SDL.Input.Keycode.z) shoot = false;
					return false;
				})

				.SetTouchDown((screenX, screenY, pointer, button) => 
				{
					x = screenX;
					y = screenY;
					mouseDown = true;
					return false;
				})

				.SetTouchUp((screenX, screenY, pointer, button) => 
				{
					x = screenX;
					y = screenY;
					mouseDown = false;
					return false;
				})

				.SetTouchDragged((screenX, screenY, pointer) => 
				{
					x = screenX;
					y = screenY;
					return false;
				})

				.SetMouseMoved((screenX, screenY) => 
				{
					x = screenX;
					y = screenY;
					return false;
				})
			);
		}
	}
}
