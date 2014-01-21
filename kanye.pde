
  import ddf.minum.*;
Minim minim;
AudioSample play;
class Walker
{

  PImage image;
  PVector position;
  int frameRow;
  int frameColumn;
  float frameTimer;
  PVector velocity;
  float speed;
}

Walker kanye;
float left = 0;
float right = 0;
float down = 0;
float up = 0;
 
void setup()
{
  size(1600, 400,P2D);
  minim = new Minim(this);
  play = minim.loadSample("Golddiger.mp3");
  play.loop();
  
  
  
  kanye = new Walker();
  kanye.image = loadImage("kanye.png");
  kanye.position = new PVector(600, 200);
  kanye.velocity = new PVector(0, 0);
  kanye.frameRow = 0; // which row from source image to use
  kanye.frameColumn = 0; // which column from source image to use
  kanye.frameTimer = 0; // determines which column to use to animate.
  kanye.speed = 2; // walk speed
}

void draw()
{
  background(100);
 
  kanye.velocity.x = kanye.speed * (left + right);
  kanye.velocity.y = kanye.speed * (up + down);
  kanye.position.add(kanye.velocity);
  
  kanye.frameTimer += 0.1; // 0.1 is the framerate or speed of animation.
  if (kanye.frameTimer >= 3) // reset at 6 because there's only 0-5 columns in the spritesheet
  {
    kanye.frameTimer = 1; // column 1 is the first frame of the walk animation
  }
  kanye.frameColumn = (int)kanye.frameTimer; // cast the timer to an int so it's an integer between 1 and 5
  
  if (kanye.velocity.x == 0 && kanye.velocity.y == 0)
  {
    kanye.frameColumn = 0; //column 0 is the stopped frame of animation
  }
  
  if (left != 0)
  {
    kanye.frameRow = 1; // column 1 is the left facing animation
  }
  if (right != 0)
  {
    kanye.frameRow = 2; // column 3 is the right facing animation
  }
  if (up != 0)
  {
    kanye.frameRow = 3; // etc.
  }
  if (down != 0)
  {
    kanye.frameRow = 0; // etc.
  }

  pushMatrix();
  translate(kanye.position.x, kanye.position.y);
  imageMode(CENTER);
  
  // Here we are creating a new image using the getSubImage function defined below.
  // we pass in the knight.image and get a sub image of the sprite sheet based on 
  // the size of a frame (32x64 here) and the row and column we want.
  PImage frameImage = getSubImage(kanye.image, kanye.frameRow, kanye.frameColumn, 32, 32);
  
  // Draw this image instead of knight.image
  image(frameImage, 0, 0);
  
  popMatrix();
}

// Our function to return a new smaller crop from the spritesheet.
PImage getSubImage(PImage image, int row, int column, int frameWidth, int frameHeight)
{
  return image.get(column * frameWidth, row * frameHeight, frameWidth, frameHeight); 
}

void keyPressed()
{
  if (keyCode == RIGHT)
  {
    right = 1;
  }
  if (keyCode == LEFT)
  {
    left = -1;
  }
  if (keyCode == UP)
  {
    up = -1;
  }
  if (keyCode == DOWN) 
  {
    down = 1;
  }
}

void keyReleased()
{
  if (keyCode == RIGHT)
  {
    right = 0;
  }
  if (keyCode == LEFT)
  {
    left = 0;
  }
  if (keyCode == UP)
  {
    up = 0;
  }
  if (keyCode == DOWN)  
  {
    down = 0;
  }
} 

