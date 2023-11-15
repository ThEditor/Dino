abstract class Enemy extends GameObject {
  Enemy() {
    x = 1400;
  }
  
  void update(int speed) {
    x -= speed;
  }
  
  boolean is_offscreen() {
    return x + w < 0;
  }
}
