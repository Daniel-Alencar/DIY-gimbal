/*
    Arduino and MPU6050 IMU - 3D Visualization Example 
    by Dejan, https://howtomechatronics.com
*/
import processing.serial.*;
import java.awt.event.KeyEvent;
import java.io.IOException;
Serial myPort;
String data="";
float roll, pitch, yaw;

void setup() {
  size(800, 600, P3D);
  
  // starts the serial communication
  myPort = new Serial(this, Serial.list()[0], 115200);
  myPort.bufferUntil('\n');
}
void draw() {
  translate(width/2, height/2, 0);
  background(0);
  
  textSize(22);
  text("Roll: " + int(roll) + "     " + "Pitch: " + int(pitch) + "     " + "Yaw: " + int(yaw), -100, 265);
  
  if(!Float.isNaN(pitch) && !Float.isNaN(roll) && !Float.isNaN(yaw)) {
    // Rotate the object
    rotateX(radians(-pitch));
    rotateY(radians(-roll));
    rotateZ(radians(yaw));
  }
  
  // 3D 0bject
  textSize(30);  
  fill(0, 76, 153);
  
  // Draw box
  box (386, 40, 200);
  textSize(25);
  fill(255, 255, 255);
  text("Referencia", -183, 10, 101);
}
// Read data from the Serial Port
void serialEvent (Serial myPort) { 
  // reads the data from the Serial Port up to the character '.' and puts it into the String variable "data".
  data = myPort.readStringUntil('\n');
  // if you got any bytes other than the linefeed:
  if (data != null) {
    data = trim(data);
    println(data);
    
    // split the string at "/"
    String items[] = split(data, '/');
    if (items.length > 1) {
      //--- Roll,Pitch in degrees
      roll = float(items[0]);
      pitch = float(items[1]);
      yaw = float(items[2]);
    }
  }
}
