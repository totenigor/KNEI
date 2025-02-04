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
  
  String[] Messages;
  String currentMessage;
  String previousMessage;
  
  
  DataLog(int areaX, int areaY, int areaWidth, int areaHeight)
  {
    this.areaX = areaX;
    this.areaY = areaY;
    this.areaWidth = areaWidth;
    this.areaHeight = areaHeight;
    
    Background = color(65);
    TextColor = color(3, 156, 3);
    
    currentMessage = "NO DATA SENT PREVIOUSLY";
    previousMessage = "";
    Messages = new String[2];
    Messages[0] = "---";
    Messages[1] = "NO DATA SENT PREVIOUSLY";
  };
  
  void createDataLog()
  {
    fill(Background);
    rect(areaX, areaY, areaWidth, areaHeight);
    fill(3, 156, 3);
    textSize(15);
    text("Waiting for an order since:", areaX + 10, areaY + 25);
    textSize(25);
    text(secAct, areaX + areaWidth/2, areaY + 30);
    textSize(25);
    text(minAct + " m ", areaX + areaWidth/2 - 45, areaY + 30);
    
    textSize(40);
    text(Messages[1], areaX + areaWidth/2 - textWidth(Messages[1])/2, areaY + areaHeight - 20);
    
    
    textSize(20);
    text(Messages[0], areaX + areaWidth/2 - textWidth(Messages[0])/2, areaY + areaHeight - 75);
    text("Message sent before:", areaX + 10, areaY + areaHeight - 75);

  };
  
  void SCM(String message)                          //SET CURRENT MESSAGE
  {
    currentMessage = message;
    Messages[1] = currentMessage;
    previousMessage = Messages[1];
  };
  
  void SPM()                                        //SET PREVIOUS MESSAGE
  {
    Messages[0] = previousMessage;
  };
  
  void timeIsTicking()
  {
    if(mouseY >= areaY && mouseY <= height &&
       mouseX >= 0 && mouseX <= width)
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
            //delay(500);
            //print("| Message0 " +Messages[0]+ " ");
            //delay(500);
            //print(" Message1 " + Messages[1] + " ");
            //print(" |");
            SPM();
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
