import java.util.Collections;
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
    
    //newDots.sort(Comparator.comparing(Dot::getFitness));
    //Collections.sort(newDots, Comparator(Dot.getFitness()));
    newDots[0] = dots[bestDot].gimmeBaby();
    newDots[0].isBest = true;
    for(int i = 1; i < newDots.length; i++)
    {
      // Select parents based on fitness
      Dot parent1 = selectParent();
      Dot parent2 = selectParent();
      
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
  
  Dot selectParent()
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
}
