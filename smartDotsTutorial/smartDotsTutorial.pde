import java.util.Random;
Population test;

// goal is the target
// PVector is an x-y pair
PVector goal = new PVector(400, 10);
PVector spawn = new PVector(400, 590);
int newGen = 1;

void setup()
{
  // Define window size
  size(800, 600);
  // Create a population of x# of dots
  test = new Population(1000);
}

void draw()
{
  // draw runs 60 times a second
  background(255);
  // draw the goal rgb
  fill(255, 0, 0);
  // ellipse is (center x, y, x diameter, y diameter)
  ellipse(goal.x, goal.y, 10, 10);
  
  // draw some walls rgb
  fill(0, 0, 255);
  // rect is (top left x, y, x length, y length)
  rect(0, 200, 150, 10);
  rect(200, 200, 400, 10);
  rect(650, 200, 150, 10);
  rect(0, 500, 375, 10);
  rect(425, 500, 375, 10);
  noFill();
  //arc(400, 10, 400, 400, 270, 360, PIE);
  
  if(test.allDotsDead())
  {
    // Genetic algorithm
    test.calculateFitness();
    // Code Bullets method
    //test.naturalSelection1();
    //test.mutateDemBabies();
        
    // my method
    test.naturalSelection2();
    
    //newGen++;
  }
  else
  {
    test.update();
    test.show();
  }
}
