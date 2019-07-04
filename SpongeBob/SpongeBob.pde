final int DELAY_KEY = 250;
final int DELAY_HIT = 1000;
final int DELAY_RELOAD = 2000;

final int PERIOD_MAX = 100;
final int PERIOD_MIN = 3;

int i, j, k;

PFont fnt;

PImage imgBackMain;
PImage imgSelect;
PImage imgComplete;
PImage imgDead;

int menu;
int selectY;
int cntStart;
int time;

boolean isPause;
boolean isComplete;
boolean isDead;

int runTime;
int keyTime;
int hitTime;
int reloadTime;

int runPeriod;

int addLength;
int[] addInterval = new int[3];

Map map;
int numMap;

Player pl;
int chX;
int chY;
int flagMotion;

int life;
int score;
int numBullet;

final int SIZE_OB = 40;
Obstacle[] ob = new Obstacle[SIZE_OB];

final int SIZE_BULLET = 10;
Bullet[] bul = new Bullet[SIZE_BULLET];

void setup()
{
  fnt = loadFont("fnt.vlw");
  textFont(fnt);

  frameRate(60);
  size(640, 480);

  ellipseMode(CENTER);
  imageMode(CENTER);

  imgBackMain = loadImage("image/backMain.jpg");
  imgBackMain.resize(width, height);

  imgSelect = loadImage("image/select.png");
  imgSelect.resize(45, 45);

  imgComplete = loadImage("image/complete.png");
  imgComplete.resize(550, 398);

  imgDead = loadImage("image/dead.png");
  imgDead.resize(550, 398);

  map = new Map();

  pl = new Player();

  for (i=0; i<SIZE_OB; i++)
  {
    ob[i] = new Obstacle();
  }

  for (i=0; i<SIZE_BULLET; i++)
  {
    bul[i] = new Bullet();
  }

  initSystem();
}

void keyReleased()
{
  if (menu == 2)
  {
    if (keyCode == 32)    // Release Space, Fire Bullet
    {
      if (isPause == false && isComplete == false && isDead == false)
      {
        flagMotion = 1;          // Active Jump
        if (numBullet != 0)
        {
          numBullet -= 1;
          for (k=0; k<SIZE_BULLET; k++)
          {
            if (!bul[k].visible)
            {
              bul[k].Add(chX);
              break;
            }
          }
        }
      }
    }

    if (keyCode == 10)   // Release Enter, pause
    {

      if (isPause == false && isComplete == false && isDead == false)
      {// Game Pause
        isPause = true;
        selectY = 240;
      } else if (isPause == true && (isComplete == true || isDead == true))
      {// Game Success Or Dead
        isPause = true;
        initSystem();
      }
    }

    if (keyCode == 65)    // Release 'a'
    {
      for (k=0; k<SIZE_OB; k++)
      {
        if (!ob[k].visible)
        {
          ob[k].Add(int(random(0, 4)));
          break;
        }
      }
    }
  }
}

void draw()
{
  if (menu == 0)          // select START or EXIT
  {
    background(imgBackMain);

    fill(255);
    textSize(30);
    text("START", 520, 350);
    text("EXIT", 520, 400);

    textSize(25);
    text("<Press Space>", 500, 430);
    image(imgSelect, 490, selectY);

    keyEvent0();
  } else if (menu == 1)    // select Map
  {
    background(imgBackMain);

    rectMode(CENTER);
    fill(178, 222, 245);
    stroke(0); 
    rect(width/2 + 10, height/2 + 60, 250, 180, 10);

    fill(0);
    textSize(30);
    text("Map1", 290, 250);
    text("Map2", 290, 310);
    text("Map3", 290, 370);

    fill(255);
    textSize(25);
    text("<Press Space>", 260, 410);
    text("<Press Esc If You Want Exit>", 195, 435);

    image(imgSelect, 260, selectY);

    keyEvent1();
  } else if (menu == 2)    // select Playing Game
  {   
    //background(0);
    if (cntStart == 4)     // Playing Game
    {
      map.Show(numMap);
      map.Menu(numMap, map.getLength(numMap));

      for (i=0; i<SIZE_OB; i++)
      {
        if (ob[i].visible == true && ob[i].y > 400 && ob[i].y < 450 && abs(ob[i].x - chX) < 60)
        {
          fill(255, 0, 0);
          textSize(100);
          text("HIT", 240, 150);

          int passedTime = millis() - hitTime;
          if (passedTime > DELAY_HIT)
          {
            hitTime = millis();

            life--;
            score -= 5;
            if (score < 0)
            {
              score = 0;
            }
            runPeriod = PERIOD_MAX;
          }
        }

        for (j=0; j<SIZE_BULLET; j++)
        {
          if (ob[i].visible == true && bul[j].visible == true)
          {
            if (((bul[j].x - bul[j].w/2) <= ob[i].x) && ((bul[j].x + bul[j].w/2) >= ob[i].x)
              && ((bul[j].y - bul[j].h/2) <= ob[i].y) && ((bul[j].y + bul[j].h/2) >= ob[i].y))
            {
              ob[i].visible = false;

              bul[j].flagHit = 1;
              bul[j].visible = false;

              score += 1;
            }
          }
        }
      }

      for (i=SIZE_OB-1; i>=0; i--)
      {
        ob[i].Show(runPeriod, isPause, numMap);
      }

      for (i=SIZE_BULLET-1; i>=0; i--)
      {
        bul[i].Show(runPeriod, isPause);
      }

      pl.Show(chX, chY, 1, runPeriod, flagMotion, isPause);

      if (!isPause)    // count playing time & decrease map length
      {
        // Enemy Add Interval Check (as Map's Length)
        int nowLength = addLength - map.getLength(numMap);
        if (nowLength > addInterval[numMap] && map.getLength(numMap) > 200)
        {
          addLength = map.getLength(numMap);

          for (j=0; j<SIZE_OB; j++)
          {
            if (!ob[j].visible)
            {
              ob[j].Add(int(random(0, 4)));
              break;
            }
          }
        }

        // Playing Time Check
        int passedTime0 = millis() - runTime;
        if (passedTime0 > runPeriod) 
        {
          runTime = millis();
        }

        // Check Game Success 
        if (isComplete = map.decLength(numMap))
        {
          isPause = true;
        }
        // Check Player Dead
        if (life == 0)
        {
          isPause = true;
          isDead = true;
        }

        if (numBullet != 5)
        {
          int passedTime1 = millis() - reloadTime;
          if (passedTime1 > DELAY_RELOAD)
          {
            reloadTime = millis();

            numBullet++;
          }
        }

        time = map.currentTime(millis());
      } else if (isPause)
      {
        if (isComplete)
        {
          imageMode(CENTER);
          image(imgComplete, 320, 200);
          fill(255);
          textSize(40);
          text("<Press Enter>", 210, 400);
          
          if(numMap == 1)
          {
            fill(0);
          }
          else
          {
            fill(255);
          }
              
          text("Time: " + (time / 1000) + "sec        Score: " + score, 140, 450);
        } else if (isDead)
        {
          imageMode(CENTER);
          image(imgDead, 320, 300);
          fill(255);
          textSize(40);
          text("<Press Enter>", 210, 170);
          fill(255, 0, 0);
          textSize(70);
          text("D E A D", 200, 400);
        } else
        {
          rectMode(CORNER);
          fill(0, 100);
          rect(0, 0, width, height);

          rectMode(CENTER);
          fill(#708ED6);
          stroke(0);
          rect(320, 270, 250, 150, 10);

          fill(0);
          textSize(30);
          text("Resume", 280, 250);
          text("Menu", 280, 310);
          textSize(20);
          text("<Press Space>", 260, 340);

          image(imgSelect, 250, selectY);
        }
      }

      keyEvent2();
    } else                // Count Start 3sec
    {
      background(0);
      map.Show(numMap);
      map.Menu(numMap, map.getLength(numMap));

      pl.Show(chX, chY, 1, runPeriod, flagMotion, isPause);

      fill(#708ED6);
      textSize(75);
      text(3 - cntStart, width/2 - 10, height/2);

      cntStart++;

      delay(100);

      if (cntStart == 4)
      {
        isPause = false;
        map.initMap(numMap);
        addLength = map.getLength(numMap);
      }
    }
  }

  ////////////////////////////// Code for Debugging ///////////////////////////////
  // fill(0);
  // textSize(15);
  // text("keyCode:" + keyCode, 0, 75);
  // text("RunPeriod:" + runPeriod, 0, 90);
  // text("fps:" + int(frameRate), 0, 105);
  // text("length:" + map.lengthMap[0], 0, 120);
  // text("time:" + time, 0, 135);
  /////////////////////////////////////////////////////////////////////////////////
}

void keyEvent0()
{
  int passedTime = millis()-keyTime;
  if (keyPressed && (passedTime > DELAY_KEY)) 
  {
    keyTime = millis();
    if (key == CODED)      // Press Direction Key
    {
      switch(keyCode)
      {
      case UP:
        selectY = 340;
        break;
      case DOWN:
        selectY = 390;
        break;
      }
    } else if (key == 32)  // Press Space
    {
      if (selectY == 340)
      {
        delay(100);

        menu = 1;
        selectY = 240;
      } else if (selectY == 390)
      {
        delay(100);

        exit();
      }
    }
  }
}

void keyEvent1()
{
  int passedTime = millis()-keyTime;
  if (keyPressed && (passedTime > DELAY_KEY))
  {
    keyTime = millis();
    if (key == CODED)      // Press Direction Key
    {
      switch(keyCode)
      {
      case UP:
        if (selectY == 360)
        {
          selectY = 300;
        } else if (selectY == 300)
        {
          selectY = 240;
        }
        break;
      case DOWN:
        if (selectY == 240)
        {
          selectY = 300;
        } else if (selectY == 300)
        {
          selectY = 360;
        }
        break;
      }
    } else if (key == 32)  // Press Space
    {
      switch(selectY)
      {
      case 240:
        menu = 2;
        numMap = 0;
        map.initMap(numMap);
        break;
      case 300:
        menu = 2;
        numMap = 1;
        map.initMap(numMap);
        break;
      case 360:
        menu = 2;
        numMap = 2;
        map.initMap(numMap);
        break;
      }
    }
  }
}

void keyEvent2()
{
  if (!isPause && keyPressed)    // playing character Control
  {
    if (key == CODED)
    {
      if (keyCode == LEFT)
      {
        if (chX > 50)
        {
          chX -= 5;
        }
      } else if (keyCode == RIGHT)
      {
        if (chX < width - 50)
        {
          chX += 5;
        }
      } else if (keyCode == UP)
      {
        if (runPeriod > PERIOD_MIN)
        {
          runPeriod -= 2;
        }
      } else if (keyCode == DOWN)
      {
        if (runPeriod < PERIOD_MAX)
        {
          runPeriod += 2;
        }
      }
    } else if (key == 32)    // Press Space
    {
    }
  } else if (isPause && !isComplete && !isDead && keyPressed)    // select Pause menu
  {
    int passedTime = millis()-keyTime;
    if (keyPressed && (passedTime > DELAY_KEY))
    {
      keyTime = millis();
      if (key == CODED)      // Press Direction Key
      {
        switch(keyCode)
        {
        case UP:               // pos Resume
          selectY = 240;
          break;
        case DOWN:             // pos Menu
          selectY = 300;
          break;
        }
      } else if (key == 32)  // Press Space
      {
        switch(selectY)
        {
        case 240:              // select Resume
          isPause = false;
          break;
        case 300:              // select Menu
          isPause = true;
          initSystem();
          break;
        }
        delay(200);
      }
    }
  }
}

void initSystem()
{
  // about System
  menu = 0;
  selectY = 340;
  cntStart = 0;
  isPause = true;
  isComplete = false;
  isDead = false;

  addInterval[0] = 30;
  addInterval[1] = 25;
  addInterval[2] = 18;

  runPeriod = PERIOD_MAX;

  // about Map
  numMap = 0;

  // about Player
  chX = width/2;
  chY = height-80;
  flagMotion = 0;

  life = 3;
  score = 0;
  numBullet = 5;

  for (i=0; i<SIZE_OB; i++)
  {
    ob[i].visible = false;
  }

  for (i=0; i<SIZE_BULLET; i++)
  {
    bul[i].visible = false;
  }
}
