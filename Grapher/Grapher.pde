import processing.serial.*;

Serial arduinoPort;        // The serial port
int currentX = 0;         // horizontal position of the graph
float data = 0;

void setup () {
  
  size(1000, 300);
  arduinoPort = new Serial(this, Serial.list()[1], 9600); //"intercept" serial print messages

  arduinoPort.bufferUntil('\n');

  background(0);
}

float oldData =0;

void draw () {
  stroke(0, 255, 0);

  if (currentX++ >= width) //start at the left of the window with a blank screen when the screen has been filled
  {
    currentX=0;
    background(0);
  }
  
  if (Math.abs(data-oldData) < 30) //prevent the program from drawing noise spikes
  {
    line(currentX, height - oldData, currentX++, height - data);
  }
  else
  {
    stroke(0, 0, 0);
    line(currentX, height - oldData, currentX++, height - data);
  }
  oldData = data;
}

void serialEvent (Serial arduinoPort) {
  
  String serialInput = arduinoPort.readStringUntil('\n');

  if (serialInput != null) {
    serialInput = trim(serialInput);
    data = float(serialInput);
    
    println(data);
    
    data = map(data, 0, 1023, 0, height);
  }
}