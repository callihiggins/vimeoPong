// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2010
// PBox2D example

// A rectangular box
class Video {

  // We need to keep track of a Body and a width and height
  Body body;
  float w;
  float h;
  int c;
  color col;
  boolean markforDeletion = false;
  Vec2 mouse = new Vec2(mouseX, mouseY);

  // Constructor
  Video(float x, float y, int _c) {
    // file = tempFile;
    w = 30;
    h = 30;
    c = _c;
    if (c==0){
    col = color(100,200,0);
    }
    else if (c==1){
    col = color(255,0,0);
    }
    else if(c==2){
     col = color(0,255,0); 
    }
      else if(c==3){
     col = color(0,0,255); 
    }
      else if(c==4){
     col = color(175,255,0); 
    }
      else if(c==5){
     col = color(0,255,175); 
    }
      else if(c==6){
     col = color(175,175,0); 
    }
      else if(c==7){
     col = color(0,255,255); 
    }
      else if(c==8){
     col = color(255,255,0); 
    }
      else if(c==9){
     col = color(255,0,255); 
    }
      else if(c==10){
     col = color(116,148,200); 
    }
      else if(c==11){
     col = color(200,255,200); 
    }
      else if(c==12){
     col = color(186,255,186); 
    }
      else if(c==13){
     col = color(200,255,20); 
    }

    // Add the box to the box2d world
    makeBody(new Vec2(x, y), w, h);
    body.setUserData(this);
  }

  // This function removes the particle from the box2d world
  void killBody() {
    box2d.destroyBody(body);
  }

  boolean done() {
    if (markforDeletion == true) {
      Vec2 pos = body.getWorldCenter();
      pos = box2d.coordWorldToPixels(pos);
      for (int i = 0; i < 13; i++) {
        videoparticles.add(new VideoParticle(pos, c));
      }
      killBody();
      return true;
    }
    return false;
  }

  // Drawing the box
  void display() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();

    rectMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    fill(col);
    stroke(0);
    rect(0, 0, w, h);
    popMatrix();
  }

  Vec2 getLocation() {
    Vec2 pos = body.getWorldCenter();
    return pos;
  }
  
 
  // This function adds the rectangle to the box2d world
  void makeBody(Vec2 center, float w_, float h_) {

    // Define a polygon (this is what we use for a rectangle)
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w_/2);
    float box2dH = box2d.scalarPixelsToWorld(h_/2);
    sd.setAsBox(box2dW, box2dH);

    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    // Parameters that affect physics
    fd.density = 1.0;
    fd.friction = .7;
    fd.restitution = .2;

    // Define the body and make it from the shape
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));

    body = box2d.createBody(bd);
    body.createFixture(fd);

    // Give it some initial random velocity
    //    body.setLinearVelocity(new Vec2(random(-5, 5), random(2, 5)));
    //    body.setAngularVelocity(random(-5, 5));
    body.setLinearVelocity(new Vec2(random(-5, 5), random(2, 5)));
    body.setAngularVelocity(random(-5, 5));    
    //  body.setAngularVelocity(random(-5, 5));
  }
}

