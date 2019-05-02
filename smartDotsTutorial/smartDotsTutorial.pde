Population test;

PVector goal = new PVector(400, 10);

void setup()
{
  size(800, 700);
  test = new Population(1000);
}

void draw()
{
  background(255);
  fill(255, 0, 0);
  ellipse(goal.x, goal.y, 10, 10);
  
  fill(0, 0, 255);
  rect(0, 200, 150, 10);
  rect(200, 200, 400, 10);
  rect(650, 200, 150, 10);
  rect(0, 500, 375, 10);
  rect(425, 500, 375, 10);
  
  if(test.allDotsDead())
  {
    // Genetic algorithm
    test.calculateFitness();
    test.naturalSelection1();
    test.mutateDemBabies();
  }
  else
  {
    test.update();
    test.show();
  }
}
