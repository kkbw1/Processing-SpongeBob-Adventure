class Map
{
  int i;

  int[] LENGTH = new int[3];

  PImage[] imgBack = new PImage[3];
  PImage[] imgRoad = new PImage[3];

  PImage imgMark;

  PImage imgHeart; 
  PImage imgHam;
  
  int[] lengthMap = new int[3];

  int startTime;
  int playTime;

  Map()
  {
    imgBack[0] = loadImage("image/back1.jpg");
    imgBack[0].resize(width, height);

    imgBack[1] = loadImage("image/back2.jpg");
    imgBack[1].resize(width, height);

    imgBack[2] = loadImage("image/back3.jpg");
    imgBack[2].resize(width, height);

    imgRoad[0] = loadImage("image/road0.png");
    imgRoad[1] = loadImage("image/road1.png");
    imgRoad[2] = loadImage("image/road2.png");

    imgMark = loadImage("image/lengthMark.png");
    imgMark.resize(40, 40);

    imgHam = loadImage("image/ham.png");
    imgHam.resize(40, 40);
    
    imgHeart = loadImage("image/heart.png");
    imgHeart.resize(40, 40);

    LENGTH[0] = 1000;
    LENGTH[1] = 1500;
    LENGTH[2] = 2000;

    lengthMap[0] = LENGTH[0];
    lengthMap[1] = LENGTH[1];
    lengthMap[2] = LENGTH[2];
  }

  void Show(int numMap)
  {
    if (numMap == 0)
    {
      // Background
      imageMode(CORNER);
      image(imgBack[0], 0, 0);

      // Upper width: 140px, Lower width: 640px, Real Lower width: 840px, height: 200px
      noStroke();
      fill(200, 200);
      quad(250, 200, 0, 400, 640, 400, 390, 200);  
      rectMode(CORNER);
      rect(0, 400, 640, 80);

      image(imgRoad[0], 0, 200);

      //stroke(0);
      // line(285, 200, 130, height);
      // line(320, 200, 320, height);
      // line(355, 200, 510, height);

      stroke(255, 0, 0);
      strokeWeight(1);
      line(278, 200, 68, height);
      line(306, 200, 236, height);
      line(334, 200, 404, height);
      line(362, 200, 572, height);
    } else if (numMap == 1)
    {
      // Background
      imageMode(CORNER);
      image(imgBack[1], 0, 0);

      // Upper width: 140px, Lower width: 640px, Real Lower width: 840px, height: 200px
      noStroke();
      fill(200, 200);
      quad(250, 200, 0, 400, 640, 400, 390, 200);  
      rectMode(CORNER);
      rect(0, 400, 640, 80);

      image(imgRoad[1], 0, 200);

      //stroke(0);
      // line(285, 200, 130, height);
      // line(320, 200, 320, height);
      // line(355, 200, 510, height);

      stroke(255, 0, 0);
      strokeWeight(1);
      line(278, 200, 68, height);
      line(306, 200, 236, height);
      line(334, 200, 404, height);
      line(362, 200, 572, height);
    } else if (numMap == 2)
    {
      // Background
      imageMode(CORNER);
      image(imgBack[2], 0, 0);

      // Upper width: 140px, Lower width: 640px, Real Lower width: 840px, height: 200px
      noStroke();
      fill(200, 200);
      quad(250, 200, 0, 400, 640, 400, 390, 200);  
      rectMode(CORNER);
      rect(0, 400, 640, 80);

      image(imgRoad[2], 0, 200);

      //stroke(0);
      // line(285, 200, 130, height);
      // line(320, 200, 320, height);
      // line(355, 200, 510, height);

      stroke(255, 0, 0);
      strokeWeight(1);
      line(278, 200, 68, height);
      line(306, 200, 236, height);
      line(334, 200, 404, height);
      line(362, 200, 572, height);
    }
  }

  void Menu(int numMap, int mapLen)
  {
    /////////////////////// Menu Block //////////////////////////////
    fill(50, 110, 142, 209);
    stroke(#496F8E);
    strokeWeight(3);
    rectMode(CORNER);
    rect(0, 0, width, 50); 
    /////////////////////////////////////////////////////////////////
    ////////////////////// Time View ////////////////////////////////
    fill(0);
    textSize(20);
    text("Time: " + (time / 1000) + " sec", 10, 30);
    /////////////////////////////////////////////////////////////////
    ////////////////////// Score View ///////////////////////////////
    fill(0);
    textSize(20);
    text("Score: " + score, 150, 30);
    /////////////////////////////////////////////////////////////////
    /////////////////////// Map Length View /////////////////////////
    fill(#F5E95E);
    stroke(#37392E);
    strokeWeight(2);
    rectMode(CORNER);
    rect(120, 70, 400, 10);

    fill(#4D44E0);
    strokeWeight(4);
    ellipseMode(CENTER);
    ellipse(120, 75, 20, 20);

    fill(#DE2231);
    ellipse(520, 75, 20, 20);

    int xLen = (LENGTH[numMap] - lengthMap[numMap]) * 400 / LENGTH[numMap];
    imageMode(CENTER);
    image(imgMark, 120 + xLen, 75);
    //////////////////////////////////////////////////////////////////
    //////////////////////// Bullet Number view //////////////////////
    for(i=0; i<numBullet; i++)
    {
       image(imgHam,  460 - i * 30, 25);
    }
    //////////////////////////////////////////////////////////////////
    //////////////////////// Life View ///////////////////////////////
    // image(imgHeart, 550, 25);
    // image(imgHeart, 580, 25);
    // image(imgHeart, 610, 25);
    for(i=0; i<life; i++)
    {
      image(imgHeart, 610 - i * 30, 25);
    }
    //////////////////////////////////////////////////////////////////
  }

  void initMap(int numMap)
  {
    startTime = millis();
    playTime = 0;
    lengthMap[numMap] = LENGTH[numMap];
  }

  int getLength(int numMap)
  {
    return lengthMap[numMap];
  }

  boolean decLength(int numMap)    // Length = 0 Return True, Length != 0 Return False
  {
    lengthMap[numMap]--;

    if (lengthMap[numMap] == 0)
    {
      return true;
    } else
    {
      return false;
    }
  }

  int currentTime(int curTime)
  {
    playTime = curTime - startTime;

    return playTime;
  }
}
