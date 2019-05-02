Population test;

PVector goal = new PVector(400, 10);

void setup()
{
  size(800, 800);
  test = new Population(800);
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
  
  rect(200, 400, 400, 10);
  
  if(test.allDotsDead())
  {
    // Genetic algorithm
    test.calculateFitness();
    test.naturalSelection();
    test.mutateDemBabies();
  }
  else
  {
    test.update();
    test.show();
  }
}
