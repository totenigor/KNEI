class RectButton
{
  int buttonX;
  int buttonY;
  int buttonWidth;
  int buttonHeight;
  
  String baseColor;
  
  String label;
  int TSize;
  int TWidth;
  int THeight;
  
  color TbuttonColor;
  color buttonBasic;
  color buttonHighlight;
  color buttonBase;
  
  float TPixelWidth;
  float MPixelWidth;
  
  String message;
  
  ButtonColors buttonColors;
  
  DataLog dataLog;
  
  RectButton(int buttonX, int buttonY, int buttonWidth, int buttonHeight, 
             String baseColor, String label, int TSize, int TWidth, int THeight, 
             String message, ButtonColors buttonColors, DataLog dataLog)
  {
    this.buttonX = buttonX;
    this.buttonY = buttonY;
    this.buttonWidth = buttonWidth;
    this.buttonHeight = buttonHeight;

    this.baseColor = baseColor;

    this.label = label;
    this.TSize = TSize;   
    this.TWidth = TWidth;
    this.THeight = THeight;
    
    this.message = message;
    
    this.buttonColors = buttonColors;
    this.dataLog = dataLog;
    
    TbuttonColor = color(255,255,255);
    
    if(baseColor == "red" || baseColor == "Red")
    {
      buttonBasic = color(buttonColors.red);
      buttonHighlight = color(buttonColors.redH);
    }else if(baseColor == "yellow" || baseColor == "Yellow")
    {
      buttonBasic = color(buttonColors.yellow);
      buttonHighlight = color(buttonColors.yellowH);
    }else if(baseColor == "blue" || baseColor == "Blue")
    {
      buttonBasic = color(buttonColors.blue);
      buttonHighlight = color(buttonColors.blueH);
    };
    
    buttonBase = buttonBasic;
    
    TPixelWidth = textWidth(label);
    MPixelWidth = textWidth(message);
  };
 
  void createButton()
  {
    fill(buttonBase);
    rect(buttonX, buttonY, buttonWidth, buttonHeight);
    fill(TbuttonColor);
    textSize(TSize);
    text(label, buttonX + TPixelWidth/2, buttonY+25);
    
  };
  
  void hvrClk()
  {
     if(mouseX >=  buttonX && mouseX <= buttonX + buttonWidth &&
         mouseY >= buttonY && mouseY <= buttonY + buttonHeight)
     {
       buttonBase = buttonHighlight;
       if(mousePressed && (mouseButton == LEFT))
       {
         delay(200);
         SMTM(message);
         print(message);
         fill(3, 156, 3);
        textSize(60);
        text(message, dataLog.areaWidth/2 - MPixelWidth*2, dataLog.areaY + dataLog.areaHeight- MPixelWidth);
       };
     }else
     {
       buttonBase = buttonBasic;
     };
  }
  
  void frontendMainFunc()
  {
    hvrClk();
    createButton();
  };
  
  void SMTM(String msg)              //Send Message To Microcontroller
  {
    char[] DM = msg.toCharArray();  //DM - DismemberedMessage
    char controlSum = DM[0];
    for(int i = 1; i < msg.length(); i++)
    {
      controlSum ^= DM[i];
    }
    
    //COM8.write(msg);
    //COM8.write(controlSum);
  };
};
