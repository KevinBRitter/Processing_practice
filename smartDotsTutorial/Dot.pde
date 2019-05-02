class Dot
{
  PVector pos;
  PVector vel;
  PVector acc;
  Brain brain;
  
  boolean isDead = false, reachedGoal = false, isBest = false;
  
  float fitness = 0;
  
  Dot()
  {
    brain = new Brain(200);
    
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
      else if(pos.x > 200 && pos.x < 600 && pos.y > 400 && pos.y < 410)
      {
        isDead = true;
      }
  //rect(200, 400, 200, 10);
  //rect(0, 200, 150, 10);
  //rect(200, 200, 400, 10);
  //rect(650, 200, 150, 10);
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
}
