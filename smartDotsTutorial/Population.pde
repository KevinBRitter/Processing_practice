class Population
{
  Dot[] dots;
  float fitnessSum;
  int generation = 1, bestDot = 0, minStep = 400;
  
  Population(int size)
  {
    dots = new Dot[size];
    for(int i = 0; i < size; i++)
    {
      dots[i] = new Dot();
    }
  }
  
  //------------------------------------
  
  void show()
  {
    for(int i = 1; i < dots.length; i++)
    {
      dots[i].show();
    }
    dots[0].show();
    fill(50);
    String g = "Gen:" + generation;
    text(g, 10, 10, 30, 30);
  }
  
  //------------------------------------
  
  void update()
  {
    for(int i = 0; i < dots.length; i++)
    {
      if(dots[i].brain.step > minStep)
      {
        dots[i].isDead = true;
      }
      else
      {
        dots[i].update();
      }
    }
  }
  
  //-----------------------------------
  
  void calculateFitness()
  {
    for(int i = 0; i < dots.length; i++)
    {
      dots[i].calculateFitness();
    }
  }
  
  //-----------------------------------
  
  boolean allDotsDead()
  {
    for(int i = 0; i < dots.length; i++)
    {
      if(!dots[i].isDead && !dots[i].reachedGoal)
      {
        return false;
      }
    }
    return true;
  }
  
  //-----------------------------------
  
  void naturalSelection1()
  {
    Dot[] newDots = new Dot[dots.length];
    setBestDot();
    calculateFitnessSum();
    
    newDots[0] = dots[bestDot].gimmeBaby();
    newDots[0].isBest = true;
    for(int i = 1; i < newDots.length; i++)
    {
      // Select parents based on fitness
      Dot parent = selectParent();
      
      // get baby from them
      newDots[i] = parent.gimmeBaby();
    }
    
    dots = newDots.clone();
    generation++;
  }
  //-----------------------------------
  // My new selection method
  void naturalSelection2()
  {
    Dot[] newDots = new Dot[dots.length];
    setBestDot();
    calculateFitnessSum();
    
    newDots = dots.clone();
    
    newDots[0] = dots[bestDot].gimmeBaby();
    newDots[0].isBest = true;
    
    for(int i = 1; i < newDots.length; i++)
    {
      // Select parents based on fitness
      int parent1, parent2, parent3;
      parent1 = selectParent2();
      parent2 = selectParent2();
      parent3 = selectParent2();

      // get baby from them
      //newDots[i] = parent.gimmeBaby();
    }
    
    dots = newDots.clone();
    generation++;
  }
  
  //-----------------------------------
  
  void calculateFitnessSum()
  {
    fitnessSum = 0;
    for(int i = 0; i < dots.length; i++)
    {
      fitnessSum += dots[i].fitness;
    }
  }

  //-----------------------------------
  
  Dot selectParent1()
  {
    float rand = random(fitnessSum);
    float runningSum = 0;
    for(int i = 0; i < dots.length; i++)
    {
      runningSum += dots[i].fitness;
      if(runningSum > rand)
      {
        return dots[i];
      }
    }
    // Should never get to this point
    return null;
  }
  
    //-----------------------------------
  
  int selectParent2()
  {
    float rand = random(fitnessSum);
    float runningSum = 0;
    for(int i = 0; i < dots.length; i++)
    {
      runningSum += dots[i].fitness;
      if(runningSum > rand)
      {
        return i;
      }
    }
    // Should never get to this point
    //return null;
  }
  
  //-----------------------------------
  
  void mutateDemBabies()
  {
    for(int i = 1; i < dots.length; i++)
    {
      dots[i].brain.mutate();
    }
  }
  
  //----------------------------------
  
  void setBestDot()
  {
    float max = 0;
    int maxIndex = 0;
    for(int i = 0; i < dots.length; i++)
    {
      if(dots[i].fitness > max)
      {
        max = dots[i].fitness;
        maxIndex = i;
      }
    }
    
    bestDot = maxIndex;
    if(dots[bestDot].reachedGoal)
    {
      minStep = dots[bestDot].brain.step;
    }
  }
  
  //-----------------------------------
  
  Dot worstParent(Dot parent1_, Dot parent2_, Dot parent3_)
  {
    Dot worst = new Dot();
    Dot tempParent1, tempParent2, tempParent3;
    tempParent1 = parent1_;
    tempParent2 = parent2_;
    tempParent3 = parent3_;
    if(tempParent1.getFitness() <= tempParent2.getFitness() && tempParent1.getFitness() <= tempParent3.getFitness())
    {
      worst = tempParent1;
    }
    else if(tempParent2.getFitness() <= tempParent1.getFitness() && tempParent2.getFitness() <= tempParent3.getFitness())
    {
      worst = tempParent2;
    }
    else if(tempParent3.getFitness() <= tempParent1.getFitness() && tempParent3.getFitness() <= tempParent2.getFitness())
    {
      worst = tempParent3;
    }
    return worst;
     
  }
}
