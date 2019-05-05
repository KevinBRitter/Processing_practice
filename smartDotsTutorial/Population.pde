class Population
{
  Dot[] dots;
  float fitnessSum;
  int generation = 1, bestDot = 0, minStep = 400, replacements = 0;
  int size;
  String g ="", h = "";
  
  Population(int size_)
  {
    size = size_;
    dots = new Dot[size];
    for(int i = 0; i < size; i++)
    {
      dots[i] = new Dot();
    }
  }
  
  //------------------------------------
  
  void show()
  {  
    if(replacements % 25 == 0)
    {
      for(int i = 1; i < dots.length; i++)
      {
        dots[i].show();
      }
      dots[0].show();
      fill(50);
      g = "Gen:" + generation;
      h = "Children: " + replacements;
    }
    else
    {
      g = "Children: " + replacements;
    }
    text(g, 10, 10, 100, 30);
    text(h, 10, 30, 100, 30);
  }
  
  //------------------------------------
  
  void update()
  {
    if(replacements % 25 == 0)
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
    else
    {
      for(int i = 0; i < dots.length; i++)
      {
        if(dots[i].brain.step > minStep)
        {
          dots[i].isDead = true;
        }
        else
        {
          for(int j = 0; j < dots[i].brain.directions.length; j++)
          {
            dots[i].update();
          }
        }
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
      Dot parent = selectParent1();
      
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
    

      // Select parents based on fitness
      int parent1, parent2, parent3;
      parent1 = selectParent2();
      parent2 = selectParent2();
      parent3 = selectParent2();
      
      // pick the dot to be replaced
      int newChild = worstParent(parent1, parent2, parent3);
      
      // pick the other two as parents for gene swap
      int newFam1 = bestParent(parent1, parent2, parent3);
      int newFam2 = secondBestParent(parent1, parent2, parent3);
      
    for(int i = 1; i < newDots.length; i++)
    {
      if(i == newChild)
      {
        //newDots[newChild] = newDots[0].gimmeBaby();
        newDots[newChild].newGenes(dots[newFam1].brain, dots[newFam2].brain);
        newDots[newChild].brain.mutate();
        replacements++;
      }
      else
      {
      // get baby from them
        newDots[i] = newDots[i].gimmeBaby();
      }
    }
    dots = newDots.clone();
    if(replacements % size == 0)
    {
      generation++;
      replacements = 0;
    }
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
    return 0;
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
  
  int worstParent(int parent1_, int parent2_, int parent3_)
  {
    int worst = 1;
    Dot tempParent1, tempParent2, tempParent3;
    tempParent1 = dots[parent1_];
    tempParent2 = dots[parent2_];
    tempParent3 = dots[parent3_];
    if(tempParent1.getFitness() <= tempParent2.getFitness() && tempParent1.getFitness() <= tempParent3.getFitness())
    {
      worst = parent1_;
    }
    else if(tempParent2.getFitness() <= tempParent1.getFitness() && tempParent2.getFitness() <= tempParent3.getFitness())
    {
      worst = parent2_;
    }
    else if(tempParent3.getFitness() <= tempParent1.getFitness() && tempParent3.getFitness() <= tempParent2.getFitness())
    {
      worst = parent3_;
    }
    return worst;
  }
  
    //-----------------------------------
  
  int bestParent(int parent1_, int parent2_, int parent3_)
  {
    int best = 1;
    Dot tempParent1, tempParent2, tempParent3;
    tempParent1 = dots[parent1_];
    tempParent2 = dots[parent2_];
    tempParent3 = dots[parent3_];
    if(tempParent1.getFitness() >= tempParent2.getFitness() && tempParent1.getFitness() >= tempParent3.getFitness())
    {
      best = parent1_;
    }
    else if(tempParent2.getFitness() >= tempParent1.getFitness() && tempParent2.getFitness() >= tempParent3.getFitness())
    {
      best = parent2_;
    }
    else if(tempParent3.getFitness() >= tempParent1.getFitness() && tempParent3.getFitness() >= tempParent2.getFitness())
    {
      best = parent3_;
    }
    return best;
  }
  
    //-----------------------------------
  
  int secondBestParent(int parent1_, int parent2_, int parent3_)
  {
    int middle = 1;
    Dot tempParent1, tempParent2, tempParent3;
    tempParent1 = dots[parent1_];
    tempParent2 = dots[parent2_];
    tempParent3 = dots[parent3_];
    
    if(tempParent1.getFitness() <= tempParent2.getFitness() && tempParent1.getFitness() >= tempParent3.getFitness())
    {
      middle = parent1_;
    }
    else if(tempParent1.getFitness() <= tempParent3.getFitness() && tempParent1.getFitness() >= tempParent2.getFitness())
    {
      middle = parent2_;
    }
    else if(tempParent2.getFitness() <= tempParent1.getFitness() && tempParent2.getFitness() >= tempParent3.getFitness())
    {
      middle = parent2_;
    }
    else if(tempParent2.getFitness() <= tempParent3.getFitness() && tempParent2.getFitness() >= tempParent1.getFitness())
    {
      middle = parent2_;
    }
    else if(tempParent3.getFitness() <= tempParent1.getFitness() && tempParent3.getFitness() >= tempParent2.getFitness())
    {
      middle = parent3_;
    }
    else if(tempParent3.getFitness() <= tempParent2.getFitness() && tempParent3.getFitness() >= tempParent1.getFitness())
    {
      middle = parent3_;
    }
    return middle;
  }
}
