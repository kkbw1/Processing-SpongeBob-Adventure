class Bullet
{
  PImage imgInitBul;
  PImage imgInitBoom;

  PImage imgBul; 
  PImage imgBoom;

  boolean visible;
  int savedTime;

  int initW;
  int initH;
  float initRatioY;

  float ratio;
  float ratioY;

  float x;
  float y;

  float w;
  float h;

  int flagHit;

  Bullet()
  {
    imgInitBul = loadImage("image/ham.png");
    imgInitBoom = loadImage("image/explo.png");

    imgBul = loadImage("image/ham.png");
    imgBoom = loadImage("image/explo.png");

    visible = false;

    initW = 20;
    initH = 20;
    initRatioY = 6.2;

    x = 0;
    y = 0;
  }

  void Add(int chX)
  {
    x = chX;
    y = 430;

    ratioY = 6.2;
    ratio = (chX - (250 + (chX + 100) * 0.1666)) / 230.0;

    flagHit = 0;

    visible = true;
  }

  void Show(int period, boolean pause)
  {
    if (!visible)
    {
      if (flagHit != 0 && flagHit < 20)
      {
        w = ((y - 200) / 280.0) * 4 * 50 + 50;
        h = ((y - 200) / 280.0) * 4 * 40 + 40;

        imgBoom = imgInitBoom.get();
        imgBoom.resize(int(w), int(h));

        imageMode(CENTER);
        image(imgBoom, x, y);

        flagHit++;
      }

      return;
    }

    if (pause)
    {
      imageMode(CENTER);
      image(imgBul, x, y);

      return;
    }

    int passedTime2 = millis() - savedTime;
    if (passedTime2 > period * 0.3) 
    {
      savedTime = millis();

      x -= ratio * ratioY;
      y -= ratioY;

      ratioY = ratioY * 0.98;

      w = ((y - 200) / 280.0) * 4 * initW + initW;
      h = ((y - 200) / 280.0) * 4 * initH + initH;

      imgBul = imgInitBul.get();
      imgBul.resize(int(w), int(h));
    }

    if (y < 250)
    {
      visible = false;
    }

    imageMode(CENTER);
    image(imgBul, x, y);
  }
}
