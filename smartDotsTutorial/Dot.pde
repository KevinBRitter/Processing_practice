class Dot
{
  PVector pos;
  PVector vel;
  PVector acc;
  Brain brain;
  Random randNum;
  
  boolean isDead = false, reachedGoal = false, isBest = false;
  
  float fitness = 0;
  
  Dot()
  {
    brain = new Brain(300);
    
    pos = new PVector(width/2, height - 10);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
  }
  
  //-----------------------------------
  
  void show()
  {
    if(isBest)
    {
      fill(0, 255, 0);
      ellipse(pos.x, pos.y, 8, 8);
    }
    else
    {
      fill(0);
      ellipse(pos.x, pos.y, 4, 4);
    }
  }

  //-----------------------------------


  void move()
  {
    if(brain.directions.length > brain.step)
    {
      acc = brain.directions[brain.step];
      brain.step++;
    }
    else
    {
      isDead = true;
    }
      vel.add(acc);
      vel.limit(5);
      pos.add(vel);
  }
  
  //----------------------------------
  
  void update()
  {
    if(!isDead && !reachedGoal)
    {
      move();
      if(pos.x < 2 || pos.y < 2 || pos.x > width - 2 || pos.y > height - 2)
      {
        isDead = true;
      }
      else if(dist(pos.x, pos.y, goal.x, goal.y) < 5)
      {
        // If reached goal
        reachedGoal = true;
      }
      else if(pos.x < 150 && pos.y > 200 && pos.y < 210)
      {
        isDead = true;
      }
      else if(pos.x > 200 && pos.x < 600 && pos.y > 200 && pos.y < 210)
      {
        isDead = true;
      }
      else if(pos.x > 650 && pos.y > 200 && pos.y < 210)
      {
        isDead = true;
      }
      else if(pos.x < 375 && pos.y > 500 && pos.y < 510)
      {
        isDead = true;
      }
      else if(pos.x > 425 && pos.y > 500 && pos.y < 510)
      {
        isDead = true;
      }
  //rect(0, 200, 150, 10);
  //rect(200, 200, 400, 10);
  //rect(650, 200, 150, 10);
  //rect(0, 500, 375, 10);
  //rect(425, 500, 375, 10);
    }
  }
  
  //----------------------------------
  
  void calculateFitness()
  {
    if(reachedGoal)
    {
      fitness = 1.0/16.0 + 10000.0/(float)(brain.step*brain.step);
    }
    else
    {
      float distanceToGoal = dist(pos.x, pos.y, goal.x, goal.y);
      fitness = 1.0/(distanceToGoal*distanceToGoal);
    }
  }
    
  //----------------------------------
  // Cloning method
  Dot gimmeBaby()
  {
    Dot baby = new Dot();
    baby.brain = brain.clone();
    return baby;
  }
  
  //----------------------------------
  void newGenes (Brain parent1, Brain parent2)
  {
    randNum = new Random();
    for(int i = 0; i < brain.directions.length; i++)
    {
      int rand = randNum.nextInt(2);
      if(rand == 0)
      {
        brain.directions[i] = parent1.directions[i];
      }
      else
      {
        brain.directions[i] = parent2.directions[i];
      }
    }
  }
  
  //----------------------------------
  
  float getFitness()
  {
    return fitness;
  }
}
