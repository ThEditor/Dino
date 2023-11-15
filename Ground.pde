class Ground extends GameObject {
  Ground() {
    x = 2400;
    y = 515;
    sprite = "ground";
  }
  
  void update(int speed) {
    x -= speed;
    if (x <= 0) {
      x = 2400;
    }
  }
  
  void display() {
    image(sprites.get(sprite), x, y);
    image(sprites.get(sprite), x - 2400, y);
  }
}
