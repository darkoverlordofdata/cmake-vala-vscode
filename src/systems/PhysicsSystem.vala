using Entitas;
namespace Systems 
{

	/**
	* game systems
	*/
	public class PhysicsSystem : System 
	{
		public PhysicsSystem(Game game, Factory world) 
		{

			var physics = world.GetGroup(Matcher.AllOf({ Components.VelocityComponent }));

			/**
			* physics system
			* model movement
			*/
			Execute = (delta) => 
			{
				physics.entities.ForEach(it => 
				{
					if (it.IsActive()) 
					{

						var x = it.transform.position.x + it.velocity.x * delta;
						var y = it.transform.position.y + it.velocity.y * delta;
						it.SetPosition(x, y);

						switch (it.pool) 
						{
							case Pool.ENEMY1:
								if (it.transform.position.y > game.height)  
								{
									world.DeleteEntity(it.SetShow(false));
								}
								break;
								
							case Pool.ENEMY2:
								if (it.transform.position.y > game.height) 
								{
									world.DeleteEntity(it.SetShow(false));
								}
								break;
								
							case Pool.ENEMY3:
								if (it.transform.position.y > game.height) 
								{
									world.DeleteEntity(it.SetShow(false));
								}
								break;
								
							case Pool.BULLET:
								if (it.transform.position.y < 0) 
								{
									world.DeleteEntity(it.SetShow(false));
								}
								break;
						}
					}
				});
			};
		}
	}
}



