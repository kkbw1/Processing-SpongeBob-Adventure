class Obstacle
{
  PImage[] imgInitOb = new PImage[3];

  PImage[] imgOb = new PImage[3];

  boolean visible;
  int savedTime;

  int[] initW = new int[3];
  int[] initH = new int[3];
  ;
  float initSZ;
  float initIncY;

  float x;
  float y;

  float w;
  float h;

  float sz;

  float rtXY;
  float incY;

  Obstacle()
  {
    imgInitOb[0] = loadImage("image/enemy1.png");
    imgInitOb[1] = loadImage("image/enemy2.png");
    imgInitOb[2] = loadImage("image/enemy3.png");

    imgOb[0] = loadImage("image/enemy1.png");
    imgOb[1] = loadImage("image/enemy2.png");
    imgOb[2] = loadImage("image/enemy3.png");

    visible = false;

    initW[0] = 25;
    initH[0] = 30;

    initW[1] = 25;
    initH[1] = 30;

    initW[2] = 30;
    initH[2] = 60;
    
    initSZ = 15;
    initIncY = 0.3;

    sz = initSZ;
  }

  void Add(int line)
  {
    switch(line)
    {
    case 0:
      rtXY = (68 - 278) / 280.0;
      x = 278 - 15;
      break;
    case 1:
      rtXY = (236 - 306) /280.0;
      x = 306;
      break;
    case 2:
      rtXY = (404 - 334) /280.0;
      x = 334;
      break;
    case 3:
      rtXY = (572 - 362) /280.0;
      x = 362 + 15;
      break;
    }
    y = 200;
    incY = initIncY;

    visible = true;
  }

  void Show(int period, boolean pause, int numMap)
  {
    if (!visible)
    {
      return;
    }

    if (pause)
    {
      imageMode(CENTER);
      image(imgOb[numMap], x, y);

      return;
    }

    //    rectMode(CENTER);
    //    fill(0);
    //   noStroke();
    //    rect(x, y, sz, sz);

    int passedTime = millis() - savedTime;
    if (passedTime > period * 0.3) 
    {
      savedTime = millis();

      x += rtXY * incY;
      y += incY;

      //     sz = ((y - 200) / 280.0) * 7 * 15 + initSZ;
      w = ((y - 200) / 280.0) * 4 * initW[numMap] + initW[numMap];
      h = ((y - 200) / 280.0) * 4 * initH[numMap] + initH[numMap];

      incY = incY * 1.02;

      imgOb[numMap] = imgInitOb[numMap].get();
      imgOb[numMap].resize(int(w), int(h));
    }

    if (y > height + 30)
    {
      visible = false;
    }

    imageMode(CENTER);
    image(imgOb[numMap], x, y);
  }
}
