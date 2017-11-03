/**
 * Entity Factory
 */
using Entitas;
using Systems;
using GLib.Math;

const double TAU = 2.0 * Math.PI; 

/** Allocations for entity pools */
const int COUNT_BACKGROUND 	=   1;
const int COUNT_PLAYER 		=   1;
const int COUNT_BULLET 		=  20;
const int COUNT_ENEMY1 		=  15;
const int COUNT_ENEMY2 		=   5;
const int COUNT_ENEMY3 		=   4;
const int COUNT_EXPLOSION 	=  10;
const int COUNT_BANG 		=  12;
const int COUNT_PARTICLE 	= 100;

const int COUNT_ALL 
		= COUNT_BACKGROUND
		+ COUNT_PLAYER
		+ COUNT_BULLET
		+ COUNT_ENEMY1
		+ COUNT_ENEMY2
		+ COUNT_ENEMY3
		+ COUNT_EXPLOSION
		+ COUNT_BANG
		+ COUNT_PARTICLE;

/* entity types - each gets a pool partition  */
enum Pool 
{
	BACKGROUND,
	ENEMY1,
	ENEMY2,
	ENEMY3,
	PLAYER,
	BULLET,
	EXPLOSION,
	BANG,
	PARTICLE,
	HUD,
	Count
}


/**
 * fabricate specialized entities
 */
public class Factory : World 
{

	//public static Sdx.Graphics.TextureAtlas atlas;
	public Factory() 
	{
		base();		
		//atlas = new Sdx.Graphics.TextureAtlas(Sdx.Files.Default("assets/assets.atlas"));
		SetPool(COUNT_ALL, Pool.Count, 
			{
				Buffer(Pool.BACKGROUND,	COUNT_BACKGROUND,	CreateBackground),
				Buffer(Pool.PLAYER, 	COUNT_PLAYER, 		CreatePlayer),
				Buffer(Pool.BULLET, 	COUNT_BULLET, 		CreateBullet),
				Buffer(Pool.ENEMY1, 	COUNT_ENEMY1, 		CreateEnemy1),
				Buffer(Pool.ENEMY2,  	COUNT_ENEMY2, 		CreateEnemy2),
				Buffer(Pool.ENEMY3,  	COUNT_ENEMY3, 		CreateEnemy3),
				Buffer(Pool.EXPLOSION, 	COUNT_EXPLOSION, 	CreateExplosion),
				Buffer(Pool.BANG,      	COUNT_BANG, 		CreateBang),
				Buffer(Pool.PARTICLE,  	COUNT_PARTICLE, 	CreateParticle)
			}
		);
	}



	/**
	 * The stuff that all entities have
	 */
	public Entity* CreateBase(string name, int pool, float scale = Sdx.pixelFactor, bool active = false, bool centered = true) 
	{
		return CreateEntity(name, pool, active)
			.SetTransform(Sdx.atlas.CreateSprite(name).SetScale(scale, scale).SetCentered(centered))
			.AddLayer(pool);
	}

	/** 
	 *	factory methods:
	 */
	public Entity* CreateBackground() 
	{
		return CreateBase("background", Pool.BACKGROUND, 2*Sdx.pixelFactor, true, false)
			.SetBackground(true);
	}

	public Entity* CreatePlayer() 
	{
		return CreateBase("spaceshipspr", Pool.PLAYER, Sdx.pixelFactor, true)
			.SetPlayer(true);
	}

	public Entity* CreateBullet() 
	{
		return CreateBase("bullet", Pool.BULLET)
			.AddSound(new Sdx.Audio.Sound(Sdx.Files.Resource("assets/sounds/pew.wav")))
			.AddTint(0xd2, 0xfa, 0, 0xfa)
			.AddHealth(2, 2)
			.AddVelocity(0, -800*Sdx.pixelFactor)
			.SetBullet(true);
	}

	public Entity* CreateEnemy1() 
	{
		return CreateBase("enemy1", Pool.ENEMY1)
			.AddHealth(10, 10)
			.AddVelocity(0, 40)
			.AddText("100%", new Sdx.Graphics.Sprite.TextSprite("100%", Sdx.smallFont, Sdx.Color.LimeGreen))
			.SetEnemy1(true);
	}

	public Entity* CreateEnemy2() 
	{
		return CreateBase("enemy2", Pool.ENEMY2)
			.AddHealth(20, 20)
			.AddVelocity(0, 30)
			.AddText("100%", new Sdx.Graphics.Sprite.TextSprite("100%", Sdx.smallFont, Sdx.Color.LimeGreen))
			.SetEnemy2(true);
	}

	public Entity* CreateEnemy3() 
	{
		return CreateBase("enemy3", Pool.ENEMY3)
			.AddHealth(60, 60)
			.AddVelocity(0, 20)
			.AddText("100%", new Sdx.Graphics.Sprite.TextSprite("100%", Sdx.smallFont, Sdx.Color.LimeGreen))
			.SetEnemy3(true);
	}

	public Entity* CreateExplosion() 
	{
		return CreateBase("explosion", Pool.EXPLOSION, 0.6f)
			.AddSound(new Sdx.Audio.Sound(Sdx.Files.Resource("assets/sounds/asplode.wav")))
			.AddTint(0xd2, 0xfa, 0xd2, 0x7f)
			.AddExpires(0.2f)
			.AddTween(0.006f, 0.6f, -3f, false, true);
	}

	public Entity* CreateBang() 
	{
		return CreateBase("explosion", Pool.BANG, 0.1f)
			.AddSound(new Sdx.Audio.Sound(Sdx.Files.Resource("assets/sounds/smallasplode.wav")))
			.AddTint(0xd2, 0xfa, 0xd2, 0x9f)
			.AddExpires(0.2f)
			.AddTween(0.001f, 0.1f, -3f, false, true);
	}

	public Entity* CreateParticle() 
	{
		return CreateBase("star", Pool.PARTICLE)
			.AddTint(0xd2, 0xfa, 0xd2, 0xfa)
			.AddExpires(0.75f)
			.AddVelocity(0, 0);
	}
	/**
	 * Get entity from the pool and
	 * put it on the screen at (x,y)
	 */
	public void AddBackground(int x, int y) 
	{
		if (cache[Pool.BACKGROUND].IsEmpty()) 
			cache[Pool.BACKGROUND].Push(CreateBackground());

		var entity = cache[Pool.BACKGROUND].Pop();
		entity.SetShow(true);
	}
		
	public void AddPlayer(int x, int y) 
	{
		if (cache[Pool.PLAYER].IsEmpty()) 
			cache[Pool.PLAYER].Push(CreatePlayer());
			
		var entity = cache[Pool.PLAYER].Pop();
		entity.SetShow(true);
	}

	public void AddBullet(int x, int y) 
	{
		if (cache[Pool.BULLET].IsEmpty()) 
			cache[Pool.BULLET].Push(CreateBullet());
			
		var entity = cache[Pool.BULLET].Pop();
		entity.SetShow(true)
			.SetPosition(x, y)
			.SetActive(true);
	}

	public void AddEnemy1(int x, int y) 
	{
		if (cache[Pool.ENEMY1].IsEmpty()) 
			cache[Pool.ENEMY1].Push(CreateEnemy1());

		var entity = cache[Pool.ENEMY1].Pop();
		entity.SetShow(true)
			.SetPosition(x, y)
			.SetHealth(10, 10)
			.SetActive(true);
	}

	public void AddEnemy2(int x, int y) 
	{
		if (cache[Pool.ENEMY2].IsEmpty()) 
			cache[Pool.ENEMY2].Push(CreateEnemy2());
			
		var entity = cache[Pool.ENEMY2].Pop();
		entity.SetShow(true)
			.SetPosition(x, y)
			.SetHealth(20, 20) 
			.SetActive(true);
	}

	public void AddEnemy3(int x, int y) 
	{
		if (cache[Pool.ENEMY3].IsEmpty()) 
			cache[Pool.ENEMY3].Push(CreateEnemy3());
			
		var entity = cache[Pool.ENEMY3].Pop();
		entity.SetShow(true)
			.SetPosition(x, y)
			.SetHealth(60, 60)
			.SetActive(true);
	}

	public void AddExplosion(int x, int y) 
	{
		if (cache[Pool.EXPLOSION].IsEmpty()) 
			cache[Pool.EXPLOSION].Push(CreateExplosion());
			
		var entity = cache[Pool.EXPLOSION].Pop();
		entity
			.SetShow(true)
			.SetBounds(x, y, (int)entity.transform.aabb.w, (int)entity.transform.aabb.h)
			.SetTween(0.006f, 0.6f, -3f, false, true)
			.SetPosition(x, y)
			.SetScale(0.6f*Sdx.pixelFactor, 0.6f*Sdx.pixelFactor)
			.SetExpires(0.2f)
			.SetActive(true);
	}

	public void AddBang(int x, int y) 
	{
		if (cache[Pool.BANG].IsEmpty()) 
			cache[Pool.BANG].Push(CreateBang());
			
		var entity = cache[Pool.BANG].Pop();
		entity
			.SetShow(true)
			.SetBounds(x, y, (int)entity.transform.aabb.w, (int)entity.transform.aabb.h)
			.SetTween(0.003f, 0.3f, -3f, false, true)
			.SetPosition(x, y)
			.SetScale(0.3f*Sdx.pixelFactor, 0.3f*Sdx.pixelFactor)
			.SetExpires(0.2f)
			.SetActive(true);
	}

	public void AddParticle(int x, int y) 
	{
		if (cache[Pool.PARTICLE].IsEmpty()) 
			cache[Pool.PARTICLE].Push(CreateParticle());
			
		var radians = Sdx.GetRandom() * TAU;
		var magnitude = Sdx.GetRandom() * 200;
		var velocityX = magnitude * Math.cos(radians);
		var velocityY = magnitude * Math.sin(radians);
		var scale = (float)Sdx.GetRandom();
		var entity = cache[Pool.PARTICLE].Pop();
		entity
			.SetShow(true)
			.SetBounds(x, y, (int)entity.transform.aabb.w, (int)entity.transform.aabb.h)
			.SetPosition(x, y)
			.SetScale(scale*Sdx.pixelFactor, scale*Sdx.pixelFactor)
			.SetVelocity((float)velocityX, (float)velocityY)
			.SetExpires(0.75f)
			.SetActive(true);
	}
}
