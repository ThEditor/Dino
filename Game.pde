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
    score = 0;
    speed = 15;
    enemies.clear();
    
    int total_score = 0;
    for (Dino dino: dinos)
      total_score += dino.score;
    last_gen_avg_score = total_score / DINOS;
    Collections.sort(dinos);
    Collections.reverse(dinos);
    last_gen_max_score = dinos.get(0).score;
    
    ArrayList<Dino> new_dinos = new ArrayList<Dino>();
    // Best 10% as is
    for (int i = 0; i < DINOS * 0.1; i++) {
      new_dinos.add(dinos.get(i));
      new_dinos.get(i).reset();
    }
    // New 10%
    for (int i = 0; i < DINOS * 0.1; i++) {
      new_dinos.add(new Dino());
    }
    // 20% Mutate from best
    for (int i = 0; i < DINOS * 0.2; i++) {
      Dino dino = new Dino();
      dino.genome = dinos.get(0).genome.mutate();
      dino.init_brain();
      new_dinos.add(dino);
    }
    // 30% father from best 5%
    for (int i = 0; i < DINOS * 0.3; i++) {
      Dino father = dinos.get((int)random(DINOS * 0.05));
      Dino son = new Dino();
      son.genome = father.genome.mutate();
      son.init_brain();
      new_dinos.add(son);
    }
    // 30% father & mother from best 5%
    for (int i = 0; i < DINOS * 0.2; i++) {
      Dino father = dinos.get((int)random(DINOS * 0.05));
      Dino mother = dinos.get((int)random(DINOS * 0.05));
      Dino son = new Dino();
      son.genome = father.genome.crossover(mother.genome);
      son.init_brain();
      new_dinos.add(son);
    }
    dinos = new_dinos;
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
      }
    score++;
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
