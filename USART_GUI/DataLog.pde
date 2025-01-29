class DataLog
{
  int areaX;
  int areaY;
  int areaWidth;
  int areaHeight;
  
  color Background;
  color TextColor;
  
  float sec;
  float secAct;
  int min;
  int minAct;
  
  String currentMessage;
  
  DataLog(int areaX, int areaY, int areaWidth, int areaHeight)
  {
    this.areaX = areaX;
    this.areaY = areaY;
    this.areaWidth = areaWidth;
    this.areaHeight = areaHeight;
    
    Background = color(65);
    TextColor = color(3, 156, 3);
    
    currentMessage = "NO DATA SENT PREVIOUSLY";
  };
  
  void createDataLog()
  {
    fill(Background);
    rect(areaX, areaY, areaWidth, areaHeight);
    fill(3, 156, 3);
    textSize(15);
    text("Waiting for an order since:", areaX + 10, areaY + 25);
    textSize(25);
    text(secAct, areaWidth/2, areaY + 30);
    textSize(25);
    text(minAct + " m ", areaWidth/2 - 45, areaY + 30);
    
    textSize(40);
    text(currentMessage, areaWidth/2 - textWidth(currentMessage)/2, areaY + areaHeight - 20);

  };
  
  void SCM(String message)                          //SET CURRENT MESSAGE
  {
    currentMessage = message;
  };
  
  void timeIsTicking()
  {
    if(mouseX >= areaX && mouseX <= areaX + areaWidth &&
       mouseY >= areaY && mouseY <= areaY + areaHeight)
       {
          sec = 0;
          min = 0;
          sec++;
          secAct += sec/60;
          
          if(secAct >= 60)
          {
            min++;
            secAct = 0;
            minAct += min;
          };
       }else
       {
          if(mousePressed && (mouseButton == LEFT))
          {
            secAct = 0;
            minAct = 0;
          }else
          {
            sec = 0;
            min = 0;
            sec++;
            secAct += sec/60;
          
            if(secAct >= 60)
            {
              min++;
              secAct = 0;
              minAct += min;
            };
          };
       };

  };
  
  void frontendMainFunc()
  {
    timeIsTicking();
    createDataLog();
  };
};        //ZROBIC DATALOG CONSOLE DLA RECEIVERA I TRANSMITTERA
