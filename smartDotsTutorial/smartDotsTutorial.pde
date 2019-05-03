Population test;

PVector goal = new PVector(400, 10);
int newGen = 1;

void setup()
{
  size(800, 600);
  test = new Population(200);
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
    test.naturalSelection2();
    //test.mutateDemBabies();
    
    //newGen++;
  }
  else
  {
    test.update();
    test.show();
    //if(newGen % 1 == 0)
    //{
      
    //}
  }
}
