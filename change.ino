// defines pins numbers
const int trigPin = 9;
const int echoPin = 10;

char val;

int maxrange=200;

// defines variables
long duration;
float distance;

void setup() {
pinMode(trigPin, OUTPUT); // Sets the trigPin as an Output
pinMode(echoPin, INPUT); // Sets the echoPin as an Input

Serial.begin(9600); // Starts the serial communication
//pinMode(ledPin,OUTPUT);
}


void loop() 
{

digitalWrite(trigPin, LOW);
delayMicroseconds(5);
// Sets the trigPin on HIGH state for 10 micro seconds
digitalWrite(trigPin, HIGH);
delayMicroseconds(10);
digitalWrite(trigPin, LOW);
// Reads the echoPin, returns the sound wave travel time in microseconds
duration = pulseIn(echoPin, HIGH);


// Calculating the distance
distance= duration/58.2;
distance;

if(distance<=maxrange)
{
Serial.println(distance);  
}
delay(25);
}
