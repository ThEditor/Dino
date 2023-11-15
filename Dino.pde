class Dino extends GameObject implements Comparable<Dino> {
  float jump_percent;
  boolean alive = true;
  int score;
  
  Dino() {
    x = (int) random(100, 300);
    y = 450;
    w = 80;
    h = 86;
    
    jump_percent = 0;
    
    sprite = "walking_dino_1";
    sprite_offset[0] = -4;
    sprite_offset[1] = -2;
  }
  
  void display() {
    if (alive)
      image(sprites.get(sprite), x + sprite_offset[0], y + sprite_offset[1]);
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
  
  void kill() {
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
