abstract class GameObject {
  float x, y;
  float w, h;
  String sprite;
  int[] sprite_offset = {0, 0};
  
  void display() {
    image(sprites.get(sprite), x + sprite_offset[0], y + sprite_offset[1]);
  }
  
  boolean is_colliding(GameObject obj) {
    return (x + w > obj.x && x < obj.x + obj.w) &&
           (y + h  > obj.y && y < obj.y + obj.h);
  }
  
  void toggle_sprite() {}
}
