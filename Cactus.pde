class Cactus extends Enemy {
  int type;
  int[] c_widths = {30, 64, 98, 46, 96, 146};
  int[] c_heights = {66, 66, 66, 96, 96, 96};
  int[] c_y = {470, 470, 470, 444, 444, 444};
  
  Cactus() {
    this((int) random(6));
  }
  
  Cactus(int type) {
    w = c_widths[type];
    h = c_heights[type];
    y = c_y[type];
    sprite = "cactus_type_" + (type + 1);
    sprite_offset[0] = -2;
    sprite_offset[1] = -2;
  }
}
