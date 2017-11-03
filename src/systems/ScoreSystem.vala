using Entitas;
namespace Systems 
{

	/**
	* game systems
	*/
	public class ScoreSystem : System 
	{
		public ScoreSystem(Game game, Factory world) 
		{

			var scoring = world.GetGroup(Matcher.AllOf(
				{
					Components.HealthComponent, 
					Components.TextComponent
				}));

			Execute = (delta) => 
			{
				scoring.entities.ForEach(entity => 
				{

					if (entity.IsActive()) 
					{
						var score = (int)Math.fmin(100, (float)entity.health.current/(float)entity.health.maximum*100);
						var pct = ((double)score).ToString();
						if (pct != entity.text.text) 
						{
							entity.text.text = pct;
							entity.text.sprite.SetText(pct, Sdx.smallFont, Sdx.Color.LimeGreen);
							entity.text.sprite.x = (int)entity.transform.position.x;
							entity.text.sprite.y = (int)entity.transform.position.y;
						}
					}
				});
			};
		}
	}
}

