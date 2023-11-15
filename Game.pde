class Game {
  Dino dino;
  ArrayList<Enemy> enemies;
  
  float speed;
  
  Ground ground;
  
  Game() {
    dino = new Dino();
    enemies = new ArrayList<Enemy>();
    speed = 15;
    ground = new Ground();
  }
  
  void update() {
    if (dino.alive) {
      dino.update();
    }
  }
  
  void dino_jump() {
    if (dino.alive && !dino.jumping()) {
      dino.jump();
    }
  }
  
  void display() {
    ground.display();
    for (Enemy enemy : enemies) {
      enemy.display();
    }
    dino.display();
  }
}
