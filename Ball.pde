// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2010
// PBox2D example

// A rectangular box
class Ball {

  // We need to keep track of a Body and a width and height
  Body body;
  float w;
  float h;
  VimeoGrabber grab;
  String user;
  PImage userPic;
  // Constructor
  Ball(float x, float y, String tempuser) {
    user = tempuser;
    w = 20;
    h = 20;
    grab = new VimeoGrabber();
    grab.requestImage(user);
    String photo = grab.getuserPhoto();
    // println(user);
    userPic = loadImage(photo);
    // Add the box to the box2d world
    makeBody(new Vec2(x, y), w, h);
    body.setUserData(this);
  }

  // This function removes the particle from the box2d world
  void killBody() {
    box2d.destroyBody(body);
  }

  int win() {
    // Let's find the screen position of the particle
    Vec2 pos = box2d.getBodyPixelCoord(body);
   
    // Is it off the bottom of the screen?
    if (pos.x > width+w*h) {
      killBody();
      return 1;
    }
    else if (pos.x < 0) {
      killBody();
      return 2;
    }
    else {
      return 3;
    }
   
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
    fill(175);
    stroke(0);
    image(userPic, 0, 0, w, h);
    popMatrix();
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
    fd.density = .8;
    fd.friction = 0.0;
    fd.restitution = 1.0;

    // Define the body and make it from the shape
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));

    body = box2d.createBody(bd);
    body.createFixture(fd);

    // Give it some initial random velocity
    //    body.setLinearVelocity(new Vec2(random(-5, 5), random(2, 5)));
    //    body.setAngularVelocity(random(-5, 5));
  //  body.setGravityScale(-3);
    body.setLinearVelocity(new Vec2(-50, 50));
    //  body.setAngularVelocity(random(-5, 5));
  }
}

