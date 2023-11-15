float MIN_SPAWN_MILLIS = 500;
float MAX_SPAWN_MILLIS = 1500;

class Game {
  Dino dino;
  ArrayList<Enemy> enemies;
  
  float speed;
  
  Ground ground;
  
  float last_spawn_time;
  float time_to_spawn;
  
  Game() {
    dino = new Dino();
    enemies = new ArrayList<Enemy>();
    speed = 15;
    ground = new Ground();
    last_spawn_time = millis();
    time_to_spawn = random(MIN_SPAWN_MILLIS, MAX_SPAWN_MILLIS);
  }
  
  void update() {
    if (dino.alive) {
      dino.update();
    }
    Iterator<Enemy> iterator = enemies.iterator();
    while (iterator.hasNext()) {
      Enemy enemy = iterator.next();
      enemy.update((int)speed);
      if (enemy.is_offscreen()) {
        iterator.remove();
      }
    }
    if (millis() - last_spawn_time > time_to_spawn) {
      spawn_enemy();
      last_spawn_time = millis();
      time_to_spawn = random(MIN_SPAWN_MILLIS, MAX_SPAWN_MILLIS);
    }
    ground.update((int)speed);
    collision_check();
    speed += 0.001;
  }
  
  void collision_check() {
    for (Enemy enemy : enemies) {
      if (dino.alive && dino.is_colliding(enemy))
        dino.kill();
    }
  }
  
  void dino_jump() {
    if (dino.alive && !dino.jumping()) {
      dino.jump();
    }
  }
  
  void spawn_enemy() {
    if (random(1) < 0.5) {
      enemies.add(new Cactus());
    } else {
      enemies.add(new Bird());
    }
  }
  
  void display() {
    ground.display();
    for (Enemy enemy : enemies) {
      enemy.display();
    }
    dino.display();
    display_info();
  }
  
  void display_info() {
    fill(0);
    textSize(30);
    text(dino.score, 1200, 80);
  }
  
  void tenth_second() {
    if (dino.alive) {
      dino.toggle_sprite();
      dino.score++;
    }
  }
  
  void quater_second() {
    for (Enemy enemy : enemies) {
      enemy.toggle_sprite();
    }
  }
}
