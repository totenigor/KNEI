import processing.serial.*;

Serial COM8;


ButtonColors BColors;
DataLog LOG;
DataLog REC;
RectButton AT;
RectButton ST;

void setup()
{ 
  //COM8 = new Serial(this, Serial.list()[3], 9600);
  size(1000,600);    //app window size
  BColors = new ButtonColors();
  LOG = new DataLog(10, 260, 500, 330);
  REC = new DataLog(520, 260, 470, 330);
  AT = new RectButton(10,100, 300, 150, "blue", "Send SOS", 50, "AT+SOS", BColors, LOG); 
  ST = new RectButton(690, 100, 300, 150, "yellow", "Send SIGMA", 40, "ST+SIGMA", BColors, LOG);

  background(25,25,25);
  fill(245, 238, 42);
  textSize(50);    //main text size
  text("USART GUI", width/2 - 100, height/4 - 100);
  AT.createButton();
  ST.createButton();
  LOG.createDataLog();
  REC.createDataLog();
}


void draw()
{
  LOG.frontendMainFunc();
  REC.frontendMainFunc();
  AT.frontendMainFunc();
  ST.frontendMainFunc();
}
