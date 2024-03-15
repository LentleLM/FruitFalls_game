PImage apple, grape, cherry, banana, coconut, basket, car, bk_scene0, bomb;
PImage bg1, bg2, bg3, bgControls,theEnd,pause;
// Define variables
int basketWidth = 80;
int basketHeight = 20;
int basketX, basketY;
int fruitSize = 30;
int bombSize = 30;
int numFruits = 10;
int numBombs = 20;
int[] fruitX, fruitY, fruitSpeed, fruitType;
int[] bombX, bombY, bombSpeed;
float carspeed = 0;
boolean isAccelerating;
float MAX_CAR_SPEED = 100;
long money = 0;

int score = 0;
int lives = 10;
int scene = 0;

//for final scene
float carX = -500, y = height/2;
PFont font1;

void setup() {
  //size(400, 600);
  fullScreen();
  basketX = width / 2 - basketWidth / 2;
  basketY = height - basketHeight - 10;
  // Initialize arrays for fruits
  fruitX = new int[numFruits];
  fruitY = new int[numFruits];
  fruitSpeed = new int[numFruits];
  fruitType = new int[numFruits];

  // Initialize arrays for bombs
  bombX = new int[numBombs];
  bombY = new int[numBombs];
  bombSpeed = new int[numBombs];

  // Initialize fruits and bombs
  for (int i = 0; i < numFruits; i++) {
    resetFruit(i);
  }

  for (int i = 0; i < numBombs; i++) {
    resetBomb(i);
  }

  // Loading Images:
  apple = loadImage("apple.png");
  coconut = loadImage("coconut.png");
  cherry = loadImage("cherry.png");
  grape = loadImage("grape.png");
  banana = loadImage("banana.png");
  basket = loadImage("basket2.png");
  pause = loadImage("PAUSE (1).png");

  bg2=loadImage("SCENE1.png");
  theEnd=loadImage("THEEND.png");
  bgControls=loadImage("INSTRUCTIONS (1).png");
  bg1=loadImage("TRUCK (2).png");
  bg3=loadImage("THEEND.png");
  car = loadImage("Idle.png");
  bk_scene0= loadImage("WELCOME.png"); // this is the pause screen
  
  
  bk_scene0.resize(width, height);
  pause.resize(width,height);
  bgControls.resize(width,height);
  theEnd.resize(width,height);
  bomb = loadImage("bomb-pepper.png");

  //load the font
  font1 = loadFont("BaiJamjuree-BoldItalic-48.vlw");
}

void draw() {
  if (lives <= 0) {
    scene = 2;
  }
  // Check for scenes
  switch (scene) {
  case 0:
    scene0();
    break;
  case 1:
    scene1();
    break;
  case 2 :
    finalScene();
    break;
  case 3 :
    controlscene();
    break;
   case 4:
     gameOverScene();
     break;
     
    case 5:
    pause();
    break;
  }
}

void scene1() {
  imageMode(CORNER);
  bg2.resize(width, height);
  image(bg2, 0, 0, width, height);

  // Draw basket
  //rect(basketX, basketY, basketWidth, basketHeight);

  // Draw fruits
  for (int i = 0; i < numFruits; i++) {
    drawFruit(i);
    moveFruit(i);
    checkCollision(i);
  }

  // Draw bombs
  for (int i = 0; i < numBombs; i++) {
    drawBomb(i);
    moveBomb(i);
    checkCollisionBomb(i);
  }
  
  basketX = constrain(mouseX - basketWidth / 2, 0, width - basketWidth);
  image(basket, basketX, basketY);

  // Display score and lives
  fill(0);
  textSize(50);
  text("Score: " + score, 90, 120);
  text("Lives: " + lives, width - 300, 120);
  text("Money: $" + money, 90, 220); 
  
}

void finalScene() { //scene 2
  updateCarMovement();
  image(bg1, 0, 0, width, height);
  strokeWeight(4);
  textSize(55);
  text("Press the right arrow to deliver your basket of fruits! ", 120, height/2 -250);
  scale(0.8);
  //line(0, y+1000, 5000, y+1000); //ground
  carX+=carspeed;
  image(car, carX, y+840); //cars
  if (carX> 2070 ) {
    gameOverScene();
  }
}

void scene0() {
  background(bk_scene0);

  
}

void pause() {
  background(pause);
  fill(255);
  textSize(30);
  textFont(font1, 60);
  textMode(CENTER);
  text("Hit 'P' to return to game!",width/5+160, height/2-45);
}



void controlscene() {
  background(bgControls);
  fill(255);
  textSize(30);
  textFont(font1, 60);
  textMode(CENTER);
  text("Hit 'P' to play, 'E' to exit.",width/5+160, height/2-145);
  text("Move basket with mouse.",width/5+165, height/2-65);
  
  textSize(60);
  text("Collect as many fruits at possible!", width/5+50, height/2+140); 
  text("AVOID the peppers!", width/5+205, height/2+220); 
  text("Press L to buy 5 lives.", width/5+180, height/2+300); 
}

void gameOverScene() {
  background(theEnd);
  fill(255);
  textSize(30);
  textFont(font1, 90);
  
  
}


void keyPressed() {
  // Move the basket with left and right arrow keys
  if (keyCode == LEFT && basketX > 0) {
    basketX -= 20;
  } else if (keyCode == RIGHT && basketX + basketWidth < width) {
    basketX += 20;
  }


  if (keyCode == RIGHT) {
    isAccelerating = true;
  }
  
    if (key == 'L' || key == 'l') {
    if (money >= 100) { // Check if the player has enough money
      money -= 100; // Deduct $100
      lives += 5; // Add 5 lives
    }
  }



  if ( scene == 2 && (key=='M'||key=='m')) //doesnt work to make game loop??
    scene = 0;
}












void keyReleased() {
  if (scene==0 && (key==ENTER))
    scene = 3;
  if (scene==3 && (key=='P' || key=='p'))
    scene = 1;
  if (scene==0 && (key=='E'||key=='e'))
    exit();
  if (scene==1 && (key=='M'||key=='m')) //doesnt work to make game loop??
    scene = 0;
     if (scene==4 && (key=='P' ||key=='p'))
    scene = 1;
    if (scene==1 && (key=='Q' ||key=='q'))
    scene = 5;
    if (scene==5 && (key=='P' ||key=='p'))
    scene = 1;

  if (keyCode == RIGHT) {
    isAccelerating = false;
  }
}
void resetFruit(int index) {
  fruitX[index] = (int) random(width - fruitSize);
  fruitY[index] = (int) random(-500, -50);
  fruitSpeed[index] = (int) random(2, 5);
  fruitType[index] = (int) random(1, 6);  // Adjust the range accordingly
  
}
void resetBomb(int index) {
  bombX[index] = (int) random(width - bombSize);
  bombY[index] = (int) random(-500, -50);
  bombSpeed[index] = (int) random(2, 5);
}
void drawFruit(int index) {
  int currentFruitType = fruitType[index];

  switch (currentFruitType) {
  case 1: // Apple
    image(apple, fruitX[index] + fruitSize / 2, fruitY[index] + fruitSize / 2, fruitSize*1.5, fruitSize*1.5);
    break;
  case 2: // Banana
    image(banana, fruitX[index] + fruitSize / 2, fruitY[index] + fruitSize / 2, fruitSize*1.5, fruitSize*1.5);
    break;
  case 3: // Cherry
    image(cherry, fruitX[index] + fruitSize / 2, fruitY[index] + fruitSize / 2, fruitSize*1.5, fruitSize*1.5);
    break;
  case 4: // Coconut
    image(coconut, fruitX[index] + fruitSize / 2, fruitY[index] + fruitSize / 2, fruitSize*1.5, fruitSize*1.5);
    break;
  case 5: // Grape
    image(grape, fruitX[index] + fruitSize / 2, fruitY[index] + fruitSize / 2, fruitSize*1.5, fruitSize*1.5);
    break;
  }
}
void drawBomb(int index) {
  image(bomb, bombX[index] + bombSize / 2, bombY[index] + bombSize / 2, bombSize, bombSize);
  //ellipse(bombX[index] + bombSize / 2, bombY[index] + bombSize / 2, bombSize, bombSize);
}
void moveFruit(int index) {
  fruitY[index] += fruitSpeed[index];
  if (fruitY[index] > height) {
    resetFruit(index);
    
  }
}
void moveBomb(int index) {
  bombY[index] += bombSpeed[index];
  if (bombY[index] > height) {
    resetBomb(index);
  }
}
void checkCollision(int index) {
  // Calculate the actual dimensions of the fruit considering the scaling
  float fruitWidth = fruitSize * 1.5;
  float fruitHeight = fruitSize * 1.5; // Assuming the height is scaled the same as width

  // Calculate the actual position of the fruit considering it's drawn centered
  float fruitLeft = fruitX[index];
  float fruitRight = fruitX[index] + fruitWidth;
  float fruitTop = fruitY[index];
  float fruitBottom = fruitY[index] + fruitHeight;

  // Basket position and dimensions
  float basketLeft = mouseX; // Using mouseX since the basket follows the mouse horizontally
  float basketRight = mouseX + basketWidth;
  float basketTop = basketY; // Y position of the basket
  float basketBottom = basketY + basketHeight;

  // Check for collision
  boolean collision = fruitRight > basketLeft && fruitLeft < basketRight && fruitBottom > basketTop && fruitTop < basketBottom;

  if (collision) {
    resetFruit(index);
    score += getFruitPoints(fruitType[index]); // Existing logic
    // New logic to increment money based on the fruit type
    money += getFruitValue(fruitType[index]);
  }
}

int getFruitValue(int type) {
  switch (type) {
  case 1: // Apple
    return 10;
  case 2: // Banana
    return 5;
  case 3: // Cherry
    return 15;
  case 4: // Pear
    return 20;
  case 5: // Strawberry
    return 25;
  default:
    return 0; // Unknown fruit type
  }
}




void checkCollisionBomb(int index) {
  float d = dist(bombX[index] + bombSize / 2, bombY[index] + bombSize / 2, basketX + basketWidth / 2, basketY + basketHeight / 2);
  if (d < bombSize / 2 + basketWidth / 2 && bombY[index] + bombSize > basketY) {
    resetBomb(index);
    lives--;  // Player hit a bomb
  }
}

int getFruitPoints(int type) {
  switch (type) {
  case 1:
    return 10;
  case 2:
    return 5;
    // Adjust cases according to the reduced number of fruit types
  default:
    return 0; // Handle unknown fruit types
  }
}

void updateCarMovement() {
  if (isAccelerating) {
    // Apply acceleration
    carspeed += 0.5; // Adjust for desired acceleration rate
    carspeed = constrain(carspeed, 0, MAX_CAR_SPEED); // Limit speed to a maximum value
  } else {
    // Apply deceleration
    carspeed -= 0.5; // Adjust for desired deceleration rate
    carspeed = max(carspeed, 0); // Ensure speed does not go below 0
  }

  // Update car's position
  carX += carspeed;

  // Optional: Implement logic to handle car position limits
}
