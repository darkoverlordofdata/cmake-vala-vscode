using Entitas;
namespace Systems 
{

	/**
	* game systems
	*/
	public class SoundSystem : System 
	{
		public SoundSystem(Game game, Factory world) 
		{

			var effects = world.GetGroup(Matcher.AllOf({ Components.SoundComponent }));
			
			/**
			 * Remove exired entities
			 */
			Execute = (delta) => 
			{
				effects.entities.ForEach(entity => 
				{
					if (entity.IsActive()) 
					{
						entity.sound.sound.Play();
					}
				});
			};
		}
	}
}


