import processing.serial.*;

Serial COM8;


ButtonColors BColors;
DataLog LOG;
RectButton AT;
RectButton ST;

void setup()
{ 
  //COM8 = new Serial(this, Serial.list()[3], 9600);
  size(600,400);    //app window size
  BColors = new ButtonColors();
  LOG = new DataLog(10, 160, 580, 230);
  AT = new RectButton(10,70, 150, 75, "blue", "Send SOS", 25, 2, 4, "AT+SOS", BColors, LOG); 
  ST = new RectButton(440, 70, 150, 75, "yellow", "Send SIGMA", 20, 2, 4, "ST+SIGMA", BColors, LOG);

  background(25,25,25);
  fill(245, 238, 42);
  textSize(50);    //main text size
  text("USART GUI", width/2 - 100, height/4 - 50);
  AT.createButton();
  ST.createButton();
  LOG.createDataLog();
}


void draw()
{
  LOG.frontendMainFunc();
  AT.frontendMainFunc();
  ST.frontendMainFunc();
}
