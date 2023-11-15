int DINOS = 1000;
float MIN_SPAWN_MILLIS = 500;
float MAX_SPAWN_MILLIS = 1500;

class Game {
  ArrayList<Dino> dinos;
  ArrayList<Enemy> enemies;
  
  float speed;
  
  Ground ground;
  int alive;
  
  int gen;
  
  int score;
  int last_gen_avg_score;
  int last_gen_max_score;
  
  float last_spawn_time;
  float time_to_spawn;
  
  Game() {
    dinos = new ArrayList<Dino>();
    for (int i = 0; i < DINOS; i++) {
      dinos.add(new Dino());
    }
    enemies = new ArrayList<Enemy>();
    speed = 15;
    gen = 1;
    score = 0;
    last_gen_avg_score = 0;
    last_gen_max_score = 0;
    alive = DINOS;
    ground = new Ground();
    last_spawn_time = millis();
    time_to_spawn = random(MIN_SPAWN_MILLIS, MAX_SPAWN_MILLIS);
  }
  
  void update() {
    for (Dino dino: dinos) {
      if (dino.alive) {
        dino.update(find_next_enemy(dino), (int) speed);
      }
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
    alive = 0;
    for (Dino dino: dinos) {
      for (Enemy enemy : enemies) {
        if (dino.alive && dino.is_colliding(enemy))
          dino.kill(score);
      }
      if (dino.alive)
        alive++;
    }
    if (alive == 0)
      next_gen();
  }
  
  void next_gen() {
    gen++;
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
    for (Dino dino: dinos)
      dino.display();
    display_info();
  }
  
  void display_info() {
    fill(0);
    textSize(30);
    text(score, 1200, 80);
    text("Gen: " + gen, 80, 80);
    text("Last Gen Average Score: " + last_gen_avg_score, 80, 120);
    text("Last Gen Max Score: " + last_gen_max_score, 80, 160);
    text("Alive: " + alive, 80, 200);
  }
  
  void tenth_second() {
    for (Dino dino: dinos)
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
  
  Enemy find_next_enemy(Dino dino) {
    for (Enemy enemy : enemies) {
       if (enemy.x > dino.x) {
         return enemy;
       }
    }
    return null;
  }
}
