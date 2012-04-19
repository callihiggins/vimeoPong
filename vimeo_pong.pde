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

// A reference to our box2d world
PBox2D box2d;
// A list we'll use to track fixed objects
ArrayList<Boundary> boundaries;
// A list for all of our rectangles
Paddle [] paddles = new Paddle[2];
ArrayList <Ball> balls;
PFont f;
String response = " ";
int score1, score2, counter;
void setup() {
  size(640, 360);
  smooth();
  f = createFont("Georgia", 12, true);
  // Initialize box2d physics and create the world
  box2d = new PBox2D(this);
  box2d.createWorld();
  // We are setting a custom gravity
  box2d.setGravity(0, 0);

  // Create ArrayLists	
  boundaries = new ArrayList<Boundary>();
  balls = new ArrayList<Ball>();

  // Add a bunch of fixed boundaries
  boundaries.add(new Boundary(0, height, width*2, 10));
  boundaries.add(new Boundary(0, 0, width*2, 10));
  //  boundaries.add(new Boundary(0, 0, 10, height/3));
  //  boundaries.add(new Boundary(width, height, 10, height/3));
  paddles[0] = new Paddle(0, 0, 10, height/3);
  paddles[1] = new Paddle(width, height, 10, height/3);
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
  
  if(score1 == 5 && counter < 200){
    println("player one wins");
    text("PLAYER ONE WINS", width/2, height/2);
   counter++;
  }
  if(score2 == 5 && counter < 200){
   text("PLAYER TWO WINS", width/2, height/2);
   counter++;
  }
  if (counter == 199){
   score1 = 0;
   score2 = 0;
  }

  paddles[0].setLocation(mouseY);  
  paddles[1].setLocation(mouseY);
}

void keyPressed() {

  if (key == 'a' || key == 'A') { 
    float y = paddles[0].y;
    // println(paddles[0].y);
    y = y--;
    //  println(y);
    paddles[0].setLocation(y);
  }
  if (key == 'z' || key == 'Z') { 
    Vec2 pos = paddles[0].getLocation();
    float y = pos.y;
    y = box2d.scalarWorldToPixels(y);
    y = y + 1;
    paddles[0].setLocation(y);
    //y = y+ 1;
    //    println(y);
    //  paddles[0].setLocation(y);
    //        println(paddles[0].y);
  }
  if (key == 'k' || key == 'K') { 
    float y = paddles[0].y;
    y = y--;
    paddles[0].setLocation(mouseY);
  }
  if (key == 'm' || key == 'M') { 
    float y = paddles[0].y;
    y = y++;
    paddles[0].setLocation(y);
  }

  if (key == 'b' || key == 'B') { 
    Ball p = new Ball(mouseX, mouseY, "calli");
    balls.add(p);
  }
}

