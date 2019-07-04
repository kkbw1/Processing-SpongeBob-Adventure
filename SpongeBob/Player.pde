class Player
{
  int numRun;
  int numJump;

  PImage[] chRun = new PImage[10];
  PImage[] chJump = new PImage[10];

  PImage imgInitHam;
  PImage imgHam;

  int savedTime;

  int jumpPeriod;
  int flyPeriod;
  int cntFly;

  int[] jmpY = new int[10]; 

  Player()
  {
    numRun = 0;
    numJump = 0;

    //  String  url = "C:\\Users\\Administrator\\Desktop\\termTest\\";
    chRun[0] = loadImage("image/ri0.png");
    chRun[1] = loadImage("image/ri1.png");
    chRun[2] = loadImage("image/ri2.png");
    chRun[3] = loadImage("image/ri3.png");
    chRun[4] = loadImage("image/ri4.png");
    chRun[5] = loadImage("image/ri5.png");
    chRun[6] = loadImage("image/ri6.png");
    chRun[7] = loadImage("image/ri7.png");
    chRun[8] = loadImage("image/ri8.png");
    chRun[9] = loadImage("image/ri9.png");

    chJump[0] = loadImage("image/ji0.png");
    chJump[1] = loadImage("image/ji1.png");
    chJump[2] = loadImage("image/ji2.png");
    chJump[3] = loadImage("image/ji3.png");
    chJump[4] = loadImage("image/ji4.png");
    chJump[5] = loadImage("image/ji5.png");
    chJump[6] = loadImage("image/ji6.png");
    chJump[7] = loadImage("image/ji7.png");
    chJump[8] = loadImage("image/ji8.png");
    chJump[9] = loadImage("image/ji9.png");

    imgInitHam = loadImage("image/ham.png");
    imgHam = loadImage("image/ham.png");

    jmpY[0] = 0;
    jmpY[1] = 20;
    jmpY[2] = 40;
    jmpY[3] = 60;
    jmpY[4] = 90;
    jmpY[5] = 110;
    jmpY[6] = 135;
    jmpY[7] = 90;
    jmpY[8] = 50;
    jmpY[9] = 20;

    jumpPeriod = 20;
    flyPeriod = 1;
    cntFly = 0;
  }

  void Show(int x, int y, float ratio, int period, int motion, boolean pause)
  {
    imageMode(CENTER);
    noStroke();
    fill(150, 200);
    ellipse(x, y + 45, 57, 25);

    if (pause)
    {
      if (motion == 0)
      {
        image(chRun[numRun], x, y);
      } else if (motion == 1)
      {
        image(chJump[numJump], x, y - jmpY[numJump]);
      }
      return;
    }

    int passedTime = millis() - savedTime;
    if (motion == 0)          // Motion Run
    {
      image(chRun[numRun], x, y);

      if (passedTime > period) 
      {
        savedTime = millis();

        if (numRun == 9)
        {
          numRun = 0;
        } else
        {
          numRun++;
        }
      }
    } else if (motion == 1)  // Motion Jump
    {
//      image(chJump[numJump], x, y - jmpY[numJump]);
      image(chJump[numJump], x, y);

      if (passedTime > jumpPeriod) 
      //if (passedTime > period * 3) 
      {
        savedTime = millis();

        if (numJump == 9)
        {
          numJump = 0;

          flagMotion = 0;
        } else if (numJump == 6)
        {
          cntFly++;
          if (cntFly == 1)
          {
            cntFly = 0;
            numJump++;
          }
        } else
        {
          numJump++;
        }
      }
    }
  }
}
