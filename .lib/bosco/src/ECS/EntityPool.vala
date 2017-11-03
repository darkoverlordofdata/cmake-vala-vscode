namespace Bosco.ECS {
  public class EntityPool : DarkMatter {
    public static Entity[,] db;

    public static void createDb(int components, int count) {

        db = new Entity[components, count];
    }

  }
}
