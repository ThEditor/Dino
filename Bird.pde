class Bird extends Enemy {
  int type;
  int[] b_y = {435, 480, 370};
  
  Bird() {
    this((int) random(3));
  }
  
  Bird(int type) {
    w = 84;
    h = 40;
    y = b_y[type];
    sprite = "bird_flying_1";
    sprite_offset[0] = -4;
    sprite_offset[1] = -16;
  }
  
  void toggle_sprite() {
    if (sprite.equals("bird_flying_1")) {
      sprite = "bird_flying_2";
    } else {
      sprite = "bird_flying_1";
    }
  }
}
