using Entitas;
namespace Systems 
{

	/**
	* game systems
	*/	
	public class SpawnSystem : System 
	{
		public delegate float SpawnEnemyFunc(float delta, float t, int enemy);

		public SpawnSystem(Game game, Factory world) 
		{
			var enemyT1 = 1.0f;
			var enemyT2 = 4.0f;
			var enemyT3 = 6.0f;

			SpawnEnemyFunc SpawnEnemy = (delta, t, enemy) => 
			{
				var d1 = t-delta;
				if (d1 < 0.0) 
				{
					switch (enemy) 
					{
						case 1:
							var x = (int)(Sdx.GetRandom() * (game.width-70)) + 35;
							world.AddEnemy1(x, -35);
							return 1;
						case 2:
							var x = (int)(Sdx.GetRandom() * (game.width-172)) + 85;
							world.AddEnemy2(x, -85);
							return 4;
						case 3:
							var x = (int)(Sdx.GetRandom() * (game.width-320)) + 160;
							world.AddEnemy3(x, -160);
							return 6;
						default:
							return 0;
					}
				} 
				else 
				{
					return d1;
				}    
				
			};

			/**
			 * Spawn enemy ships
			 */
			Execute = (delta) => 
			{
				enemyT1 = SpawnEnemy(delta, enemyT1, 1);
				enemyT2 = SpawnEnemy(delta, enemyT2, 2);
				enemyT3 = SpawnEnemy(delta, enemyT3, 3);
			};

		}
	}
}
