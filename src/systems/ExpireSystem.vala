using Entitas;
namespace Systems 
{

	/**
	* game systems
	*/
	public class ExpireSystem : System 
	{
		public ExpireSystem(Game game, Factory world) 
		{

			var expiring = world.GetGroup(Matcher.AllOf({ Components.ExpiresComponent }));
			
			/**
			 * Remove exired entities
			 */
			Execute = (delta) => 
			{
				expiring.entities.ForEach(entity => 
				{
					if (entity.IsActive()) 
					{
						entity.expires.value -= delta; 
						if (entity.expires.value < 0)	
							world.DeleteEntity(entity.SetShow(false));
					}
				});
			};
		}
	}
}


