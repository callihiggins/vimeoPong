// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2011
// PBox2D example

// Basic example of falling rectangles

import pbox2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
import oscP5.*;
import netP5.*;
// A reference to our box2d world
PBox2D box2d;
// A list we'll use to track fixed objects
ArrayList<Boundary> boundaries;
ArrayList<Video> videos;
ArrayList<VideoParticle> videoparticles;
// A list for all of our rectangles
Paddle [] paddles = new Paddle[2];
ArrayList <Ball> balls;
PFont f;
String response = " ";
int score1, score2, counter, pot1, pot2;
OscP5 oscP5;
//OscP5 oscP5_2;
NetAddress myRemoteLocation;
void setup() {
  size(640, 360);
  smooth();
  f = createFont("Georgia", 12, true);
  oscP5 = new OscP5(this, 12000);
  myRemoteLocation = new NetAddress("127.0.0.1", 12000);
  // Initialize box2d physics and create the world
  box2d = new PBox2D(this);
  box2d.createWorld();
  // We are setting a custom gravity
  box2d.setGravity(0, -20);

  // Create ArrayLists	
  boundaries = new ArrayList<Boundary>();
  balls = new ArrayList<Ball>();
  videos = new ArrayList<Video>();
  videoparticles = new ArrayList<VideoParticle>();

  // Add a bunch of fixed boundaries
  boundaries.add(new Boundary(0, height, width*2, 10));
  boundaries.add(new Boundary(0, 0, width*2, 10));
  //  boundaries.add(new Boundary(0, 0, 10, height/3));
  //  boundaries.add(new Boundary(width, height, 10, height/3));
  paddles[0] = new Paddle(0, 0, 10, height/3);
  paddles[1] = new Paddle(width, height, 10, height/3);
  // make the videos
  for (int i = 0; i < 14; i++) {
    videos.add(new Video(width/2, 230));
  }

  // Turn on collision listening!
  box2d.listenForCollisions();
}

void draw() {
  background(255);

  // We must always step through time!
  box2d.step();


  // Display all the boundaries
  for (Boundary wall: boundaries) {
    wall.display();
  }
  // Display the ball
  for (Ball ball: balls) {
    ball.display();
  }

  for (Video v: videos) {
    v.display();
  }

  for (VideoParticle v: videoparticles) {
    v.display();
  }

  for (int i = videos.size()-1; i >= 0; i--) {
    Video v = videos.get(i);
    if (v.done()) {
      videos.remove(i);
    }
  }





  // Display the paddles
  for (int i = 0; i < paddles.length; i++) {
    paddles[i].display();
  }

  // Boxes that leave the screen, we delete them
  // (note they have to be deleted from both the box2d world and our list
  fill(0);
  textFont(f);

  for (int i = balls.size()-1; i >= 0; i--) {
    Ball b = balls.get(i);
    if (b.win() == 1) {
      score1++;
      balls.remove(i);
    }
    else if (b.win() == 2) {
      score2++;
      balls.remove(i);
    }
  }
  text("Player One: " + score1, 10, 20);
  text("Player Two: " + score2, 500, 20);

  if (score1 == 5 && counter < 200) {
    println("player one wins");
    text("PLAYER ONE WINS", width/2, height/2);
    counter++;
  }
  if (score2 == 5 && counter < 200) {
    text("PLAYER TWO WINS", width/2, height/2);
    counter++;
  }
  if (counter == 199) {
    score1 = 0;
    score2 = 0;
    counter = 0;
  }

  paddles[0].setLocation(pot1);  
  paddles[1].setLocation(pot2);
}

void keyPressed() {
  if (key == 'b' || key == 'B') { 
    Ball p = new Ball(mouseX, mouseY, "blakewhitman");
    balls.add(p);
  }
}

// Collision event functions!
void beginContact(Contact cp) {
  // Get both fixtures
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  // Get both bodies
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();

  // Get our objects that reference these bodies
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();

  if (o1.getClass() == Ball.class && o2.getClass() == Video.class|| o1.getClass() == Video.class && o2.getClass() == Ball.class) {
    if (o1.getClass() == Video.class) {
      Video v = (Video) o1;
      v.markforDeletion = true;
      //  makeParticles(new Vec2(mouseX,mouseY));
    }
    else {
      Video v = (Video) o2;
      v.markforDeletion = true;
    }
  }
}

// Objects stop touching each other
void endContact(Contact cp) {
}

void oscEvent(OscMessage theOscMessage) {
  /* check if theOscMessage has the address pattern we are looking for. */
  
  if(theOscMessage.checkAddrPattern("/pot")==true) {
    
       pot1 = theOscMessage.get(0).intValue();  
       pot2 = theOscMessage.get(1).intValue();  
      print("### received an osc message ");
      println(" values: "+pot1+ ", "+pot2);
      return;
    }  
}


