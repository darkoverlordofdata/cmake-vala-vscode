using Entitas;
using Sdx.Graphics;

namespace Systems 
{
	/**
	* Display systems
	*/
	public class DisplaySystem : Object 
	{
		public List<Entity*> sprites = new List<Entity*>();

		public DisplaySystem(Game game, Factory world) 
		{
			/**
			 * Wire up the events
			 */
			var show = world.GetGroup(Matcher.AllOf({ Components.ShowComponent }));
			/**
			 * Remove the entity from the display
			 */
			show.onEntityRemoved.Add((group, entity, index, comp) => sprites.Remove(entity));
			/**
			 * Add the entity to the display 
			 * insert in z-Order
			 */
			show.onEntityAdded.Add((group, entity, index, comp) => {
				var layer = entity.layer.value;
				if (sprites.Length() == 0) 
					sprites.Add(entity);
				else 
				{
					var i = 0;
					foreach (var sprite in sprites) 
					{
						if (layer <= sprite.layer.value) 
						{
							sprites.Insert(entity, i);
							return;
						} 
						i++;
					}
					sprites.Add(entity);
				}
			});
			/** 
			 * Delegate draw 
			 */
			//  game.Draw = Draw;
			game.Draw = () => {
				Sdx.Begin();
				sprites.ForEach(entity => 
				{
					if (entity.IsActive()) 
						Draw(entity, ref entity.transform);
				});
				Sdx.ui.Render();
				Sdx.End();
			};
		}

		public bool Draw(Entity* e, ref Transform t) 
		{
			if (t.sprite != null) 
			{

				t.aabb.w = (int)((float)t.sprite.width * t.scale.x);
				t.aabb.h = (int)((float)t.sprite.height * t.scale.y);
				if (t.sprite.centered) 
				{
					t.aabb.x = (int)((float)t.position.x - t.aabb.w / 2);
					t.aabb.y = (int)((float)t.position.y - t.aabb.h / 2);
				}
				if (e.HasTint()) 
				{
					t.sprite.texture.SetColorMod((uint8)e.tint.r, (uint8)e.tint.g, (uint8)e.tint.b);
					t.sprite.texture.SetAlphaMod((uint8)e.tint.a);
				}
				Sdx.Render(t.sprite.texture, null, 
					{ t.aabb.x, t.aabb.y, (uint)t.aabb.w, (uint)t.aabb.h });

			if (e.HasText())
				Sdx.Render(e.text.sprite.texture, null, 
					{ 
						(int)t.position.x, 
						(int)t.position.y, 
						e.text.sprite.width, 
						e.text.sprite.height 
					});
			}
			return true;
		}
	}
}
