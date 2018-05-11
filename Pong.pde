// every hit of ball and paddle
// change paddle color, background color, ball color, indiv letter of score

// point point collision detection will tunnel at high speeds and small objects


import java.util.Random;

int meter;
PShape playerPaddle;
PShape computerPaddle;
PShape ballHitbox;

PVector computerPos;
PVector paddleSpeed;
PVector ballPos = new PVector(width/2, height/2);
PVector ballDirection = new PVector(0,0);

float ballSize;
float ballSpeed;
float paddleWidth;
float paddleLength;

IntList quadrants;
boolean negative;

int playerScore = 0;
int compScore = 0;

Paddle player;
Paddle computer;
Ball ball;

void setup() {
  // fullScreen();
  size(1280, 720);
  meter = width/16;
  
  // initial settings
  paddleWidth = 0.2*meter; 
  paddleLength = 1.25*meter;
  playerPaddle = createShape();
  
  ballSize = 0.3*meter;
  ballSpeed = 4;
  
  computerPos = new PVector(width-1*meter, height/2); // start computer paddle in the middle
  paddleSpeed = new PVector(0,5);
  
  quadrants = new IntList();
  quadrants.append(1);
  quadrants.append(2);
  quadrants.append(3);
  quadrants.append(4);
  
  // Paddle(PVector paddlePos, float paddleWidth, float paddleHeight)
  player = new Paddle(new PVector(1*meter, mouseY), paddleWidth, paddleLength);
  
  // Paddle(PVector computerPos, PVector paddleSpeed, float paddleWidth, float paddleHeight)
  computer = new Paddle(computerPos, paddleSpeed, paddleWidth, paddleLength);
  
  // Ball(PVector ballPos, float ballSize, boolean start)
  ball = new Ball(ballPos, (float)ballSize, true);
}

void draw() {
  clear();
  background(0);
  stroke(200);
  
  // display court lines
  line(8*meter,0,8*meter,height);
  line(2*meter,0,2*meter,height);
  line(width-2*meter,0,width-2*meter,height);
  
  // display scores
  textSize(32);
  textAlign(CENTER);
  text(playerScore, 7*meter, 1*meter);
  text(compScore, 9*meter, 1*meter);
  
  player.movePlayer();
  computer.moveComp();
  
  if(ball.start) {
    ball.begin();
    float rand = random(1);
    Random randomizer = new Random();
    int quadrant = quadrants.get(randomizer.nextInt(quadrants.size()));
    
    switch(quadrant) {
      case 1 : 
        ballDirection.set(width-1*meter, (-1)*(rand*height));
        break;
        
      case 2 : 
        ballDirection.set((-1)*(width-1*meter), (-1)*(rand*height));
        break;
        
      case 3 : 
        ballDirection.set((-1)*(width-1*meter), rand*height);
        break;
        
      case 4 : 
        ballDirection.set(width-1*meter, rand*height);
        break;
    }
    ballDirection.normalize();
    ballDirection.mult(ballSpeed);
  }
  ball.moveTo(ballDirection);
  
  if(ballDirection.heading() < 0) {
    negative = true;
  } else {
    negative = false;
  }
  
  // player paddle collision
  if(ball.getPos().x - ballSize/2 < 1*meter+paddleWidth/2) { // if ball has same xcoord as player paddle
  
    if(mouseY - paddleLength/2 < ball.getPos().y & mouseY + paddleLength/2 > ball.getPos().y) { // ball is between the top and bottom of paddle
      
      if(ballDirection.heading() < 0) { // ball is moving low to high on screen, negative angles of rotation
        ballDirection.rotate(PI+ballDirection.heading());
      } else {
        ballDirection.rotate(-PI+ballDirection.heading());
      }
    }
  
  // computer paddle collision
  } else if(ball.getPos().x + ballSize/2 > (width-1*meter)-(paddleWidth/2)) { // if ball has same xcoord as computer paddle
    if(computerPos.y - paddleLength/2 < ball.getPos().y & computerPos.y + paddleLength/2 > ball.getPos().y) {
      ballDirection.rotate(HALF_PI);
    }
  }
  
  // if ball collides with top or bottom wall
  if(ball.getPos().y-ballSize/2 < 0) { // top wall
    ballDirection.rotate(1.5708);
  } else if(ball.getPos().y+ballSize/2 > height) { // bottom wall
    ballDirection.rotate(1.5708);
  }
  
  if(ball.scores()) {
    ball.reset();
  }
}

void keyPressed() {
  if(key == 'q') {
    ballDirection.rotate(PI/2);
  }
}
