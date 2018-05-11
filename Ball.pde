class Ball {
  PVector ballPos;
  PVector ballSpeed;
  float ballSize;
  boolean start;
  
  Ball(PVector ballPos, float ballSize, boolean start) {
    this.ballPos = ballPos;
    this.ballSize = ballSize;
    this.start = start;
  }
  
  PVector getPos() { // comp paddle tracking ball
    return ballPos.copy();
  }
  
  void begin() {
    ballPos.set(width/2, height/2);
    ellipse(ballPos.x, ballPos.y, ballSize, ballSize);
  }
  
  void moveTo(PVector newPos) {
    ballPos.set(ballPos.x + newPos.x, ballPos.y + newPos.y);
    start = false;
    ellipse(ballPos.x, ballPos.y, ballSize, ballSize);
  }
  
  boolean scores() {
    if(ball.getPos().x < 0) {
      compScore++;
      return true;
    } else if(ball.getPos().x > width) {
      playerScore++;
      return true;
    } else {
      return false;
    }
  }
  
  void checkCollision() {
  
  }
  
  void reset() {
    ballPos.set(width/2, height/2);
    ellipse(ballPos.x, ballPos.y, ballSize, ballSize);
    start = true;
    begin();
  }
}