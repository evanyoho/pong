class Paddle {
  PVector paddlePos;
  PVector compPaddlePos;
  PVector paddleSpeed;
  float paddleWidth;
  float paddleLength;
  boolean isPlayer;
  boolean goingUp = true;

  Paddle(PVector paddlePos, float paddleWidth, float paddleLength) { // player paddle constructor
    this.paddlePos = paddlePos;
    this.paddleWidth = paddleWidth;
    this.paddleLength = paddleLength;
  }
  
  Paddle(PVector compPaddlePos, PVector paddleSpeed, float paddleWidth, float paddleLength) { // computer paddle constructor
    this.compPaddlePos = compPaddlePos;
    this.paddleSpeed = paddleSpeed;
    this.paddleWidth = paddleWidth;
    this.paddleLength = paddleLength;
  }
  
  void movePlayer() {
    rectMode(CENTER);
    paddlePos.set(1*meter,mouseY);
      
    if(paddlePos.y < paddleLength/2) { // draw paddle at top of screen
      paddlePos.set(1*meter, paddleLength/2);
      rect(paddlePos.x, paddlePos.y, paddleWidth, paddleLength);
        
    } else if(paddlePos.y > height-paddleLength/2) { // draw paddle at botom of screen
      paddlePos.set(1*meter, height-paddleLength/2);
      rect(paddlePos.x, height-paddleLength/2, paddleWidth, paddleLength);
        
    } else {
      rect(paddlePos.x, paddlePos.y, paddleWidth, paddleLength); // draw paddle at mouse
    }
  }
  
  void moveComp() {
    rectMode(CENTER);
    if(ball.getPos().x > width/2+1*meter) { // ball on comp side
    
      if(compPaddlePos.y < ball.getPos().y) { // if comp paddle is above the ball
        compPaddlePos.add(paddleSpeed);
      } else {
        compPaddlePos.sub(paddleSpeed);
      }
      
    } else { // ball on player side
      float rand = random(1);
      if(rand < 0.01) { // 1% chance of changing direction
        if(goingUp) {         
          goingUp = false;
        } else {              
          goingUp = true;
        }
      } 

      if(goingUp) {
        compPaddlePos.set(compPaddlePos.sub(paddleSpeed)); // towards top of screen (up) = decrease in height
      } else {
        compPaddlePos.set(compPaddlePos.add(paddleSpeed)); // towards bottom (down) = increase in height
      }
    }

    if(compPaddlePos.y - paddleLength/2 < 0 ) { // hits top of screen and changes direction
      compPaddlePos.set(compPaddlePos.add(paddleSpeed));
      goingUp = false;
      
    } else if(compPaddlePos.y + paddleLength/2 > height) { // hits bottom of screen and changes direction
      compPaddlePos.set(compPaddlePos.sub(paddleSpeed));
      goingUp = true;
    }
    rect(compPaddlePos.x, compPaddlePos.y, paddleWidth, paddleLength);
  }
}
