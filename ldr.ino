int sensorPin = A0; // select the input pin for LDR
int sensorPin2 = A1; // select the input pin for LDR

int sensorValue = 0; 

int sensorValue2 = 0; // variable to store the value coming from the sensor
void setup() {
Serial.begin(9600);
}
void loop()
{
  
  sensorValue = analogRead(sensorPin); // read the value from the sensor
 if(sensorValue<=2)
  {
    sensorValue=1;
  }
else
{
  sensorValue=0;
  }
 
Serial.println(sensorValue); 

sensorValue2 = analogRead(sensorPin2); // read the value from the sensor
 if(sensorValue2<=2)
  {
    sensorValue2=1;
  }
else
{
  sensorValue2=0;
  }
  
Serial.println(sensorValue2); 

//prints the values coming from the sensor on the screen
delay(500);
}
