// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2012
// PBox2D example

// A fixed boundary class

class Paddle {

  // A boundary is a simple rectangle with x,y,width,and height
  float x;
  float y;
  float w;
  float h;
  
  // But we also have to make a body for box2d to know about it
  Body b;

  Paddle(float x_,float y_, float w_, float h_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    makeBody(new Vec2(x,y),w,h);
    b.setUserData(this);

    // Define the polygon
 /*   PolygonShape ps = new PolygonShape();
    // Figure out the box2d coordinates
    float box2dW = box2d.scalarPixelsToWorld(w);
    float box2dH = box2d.scalarPixelsToWorld(h);
    // We're just a box
    ps.setAsBox(box2dW, box2dH);
  

    // Create the body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.KINEMATIC;
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    b = box2d.createBody(bd);
    
    // Attached the shape to the body using a Fixture
    b.createFixture(ps,1);*/
  }
  
  void setAngularVelocity(float a) {
    b.setAngularVelocity(a); 
  }
  void setVelocity(Vec2 v) {
     b.setLinearVelocity(v);
  }
  
  void setLocation(float y) {
    Vec2 pos = b.getWorldCenter();
    Vec2 target = box2d.coordPixelsToWorld(x,y);
    Vec2 diff = new Vec2(target.x-pos.x,target.y-pos.y);
    diff.mulLocal(50);
    setVelocity(diff);
    setAngularVelocity(0);
  }
  
    Vec2 getLocation() {
     Vec2 pos = b.getWorldCenter();
     return pos;
    
  }

// Drawing the box
  void display() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(b);
    // Get its angle of rotation
    float a = b.getAngle();

    rectMode(PConstants.CENTER);
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(a);
    fill(175);
    stroke(0);
    rect(0,0,w,h);
    popMatrix();
  }


  // This function adds the rectangle to the box2d world
  void makeBody(Vec2 center, float w_, float h_) {
    // Define and create the body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.KINEMATIC;
    bd.position.set(box2d.coordPixelsToWorld(center));
    bd.fixedRotation = true;
    b = box2d.createBody(bd);

    // Define a polygon (this is what we use for a rectangle)
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w_/2);
    float box2dH = box2d.scalarPixelsToWorld(h_/2);
    sd.setAsBox(box2dW, box2dH);

    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    // Parameters that affect physics
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.5;

    b.createFixture(fd);
  }

}




