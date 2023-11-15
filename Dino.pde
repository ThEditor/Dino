class Dino extends GameObject implements Comparable<Dino> {
  Brain brain;
  
  float jump_percent;
  boolean alive = true;
  int score;
  
  Dino() {
    x = (int) random(100, 300);
    y = 450;
    w = 80;
    h = 86;
    
    jump_percent = 0;
    
    brain = new Brain(new Genome());
    
    sprite = "walking_dino_1";
    sprite_offset[0] = -4;
    sprite_offset[1] = -2;
  }
  
  void update(Enemy nextEnemy, int speed) {
    if (nextEnemy != null) {
      float distance = nextEnemy.x - x; // d, x, y, w, h
      float[] inputs = {distance / 900, (nextEnemy.x - 450) / (1400 - 450), (nextEnemy.y - 370) / (480 - 370), (nextEnemy.w - 30) / (146 - 30), (nextEnemy.h - 40) / (96 - 40), (y - 278) / (484 - 278), (speed - 15) / (15)};
      brain.forward_feed(inputs);
      process_output();
    }
    if (jumping()) {
      update_jump();
    }
  }
  
  void process_output() {
    // 0 - jump, 1 - crouch, 2 - nothing
    if (brain.outputs[0] >= 0.5) {
      if (!crouching() && !jumping())
        jump();
    }
    if (brain.outputs[1] < 0.5) {
      if (crouching())
        stop_crouch();
    } else {
      if (jumping())
        stop_jump();
      crouch();
    }
  }
  
  void display() {
    if (alive)
      image(sprites.get(sprite), x + sprite_offset[0], y + sprite_offset[1]);
  }
  
  void update_jump() {
    y = (int)(450 - ((-4 * jump_percent * (jump_percent - 1)) * 172));
    jump_percent += 0.03;
    if (jump_percent > 1) {
      stop_jump();
    }
  }
  
  void jump() {
    jump_percent = 0.0001;
    sprite = "standing_dino";
  }
  
  void stop_jump() {
    jump_percent = 0;
    y = 450;
    sprite = "walking_dino_1";
  }
  
  void crouch() {
    if (!crouching()) {
      y = 484;
      w = 110;
      h = 52;
      sprite = "crouching_dino_1";
    }
  }
  
  void stop_crouch() {
    y = 450;
    w = 80;
    h = 86;
    sprite = "walking_dino_1";
  }
  
  boolean jumping() {
    return jump_percent > 0;
  }
  
  boolean crouching() {
    return w == 110;
  }
  
  void kill(int s) {
    score = s;
    alive = false;
  }
  
  void reset() {
    alive = true;
    score = 0;
  }
  
  void toggle_sprite() {
    if (sprite.equals("walking_dino_1")) {
      sprite = "walking_dino_2";
    } else if (sprite.equals("walking_dino_2")) {
      sprite = "walking_dino_1";
    } else if (sprite.equals("crouching_dino_1")) {
      sprite = "crouching_dino_2";
    } else if (sprite.equals("crouching_dino_2")) {
      sprite = "crouching_dino_1";
    }
  }
  
  @Override
  public int compareTo(Dino oD) {
    return Integer.compare(this.score, oD.score);
  }
}
