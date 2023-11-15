import java.util.Collections;
import java.util.Iterator;

HashMap<String, PImage> sprites = new HashMap<String, PImage>();

Game game;

int lastMillis1 = 0;
int lastMillis2 = 0;

void setup() {
  size(1280, 720);
  initialize_sprites();
  game = new Game();
}

void draw() {
  background(247);
  game.display();
  game.update();
  if (millis() - lastMillis1 >= 100) {
    game.tenth_second();
    lastMillis1 = millis();
  }
  if (millis() - lastMillis2 >= 250) {
    game.quater_second();
    lastMillis2 = millis();
  }
}

void initialize_sprites() {
  PImage sprite_map = loadImage("sprites.png");
  sprites.put("standing_dino", sprite_map.get(1338, 2, 88, 94));
  sprites.put("walking_dino_1", sprite_map.get(1514, 2, 88, 94));
  sprites.put("walking_dino_2", sprite_map.get(1602, 2, 88, 94));
  sprites.put("dead_dino", sprite_map.get(1690, 2, 88, 94));
  sprites.put("crouching_dino_1", sprite_map.get(1866, 36, 118, 60));
  sprites.put("crouching_dino_2", sprite_map.get(1984, 36, 118, 60));
  sprites.put("cactus_type_1", sprite_map.get(446, 2, 34, 70));
  sprites.put("cactus_type_2", sprite_map.get(480, 2, 68, 70));
  sprites.put("cactus_type_3", sprite_map.get(548, 2, 102, 70));
  sprites.put("cactus_type_4", sprite_map.get(652, 2, 50, 100));
  sprites.put("cactus_type_5", sprite_map.get(702, 2, 100, 100));
  sprites.put("cactus_type_6", sprite_map.get(802, 2, 150, 100));
  sprites.put("bird_flying_1", sprite_map.get(260, 2, 92, 80));
  sprites.put("bird_flying_2", sprite_map.get(352, 2, 92, 80));
  sprites.put("ground", sprite_map.get(2, 104, 2400, 24));
}
