import processing.serial.*;
PImage img;
PImage img2;
PImage img3;
PImage img4;
static int sc1=0;
static int sc2=0;
static int final1;
//static float gravity=0.3;
PFont ff;
static int pl=0;
String ldrdata;

import processing.sound.*;
static SoundFile file;

static int gamescreen=0;

static Serial myPort;
static Serial myPort2;
static Serial myPort3;
String distance;
String distance2;
static float x1=960;
static float y1=750;
static float x2=-20;

final static byte BUBBLE_X = 0, BUBBLE_Y = 1, BUBBLE_SPD = 2;
final static byte BUBBLE_SIZE = 3, BUBBLE_COLOR = 4;
 
final static byte  MIN_SPD =9, MAX_SPD = 11; 
final static short MIN_SIZE = 0200, MAX_SIZE = 0200;
final static float FPS = 40, BOLD = 2;
 
final static byte  MAX_NUM = 0165, FREQ = 020;
final static int[][] bubbles = new int[MAX_NUM][BUBBLE_COLOR + 1];
final static boolean[] bubblesState = new boolean[MAX_NUM];
 
final static String GFX = JAVA2D; // Use JAVA2D or P2D
 
static int bubblesCounter, score;
void setup()
{
  fullScreen(P2D);
  //size(800,600);
  smooth();
  String portName="COM5";
  String portName2="COM6";
  String portName3="COM4";
  myPort=new Serial(this,portName,9600);
  myPort2=new Serial(this,portName2,9600);
  myPort3=new Serial(this,portName3,9600);
  img=loadImage("finalnet.png");
  img2=loadImage("huh.jpg");
  img3=loadImage("bubbles.jpg");
  img4=loadImage("finalnet2.png");
  ff=createFont("myfont.ttf",50.0);
  file = new SoundFile(this, "ding.mp3");    
}


 void startscreen()
{
  image(img3,0,0);
//  image(img3,1024,0);
textFont(ff,60);
  textAlign(CENTER);
  fill(255);
  noStroke();
  rect(500,220,1050,100,15);
  textSize(60);
  fill(45);
  text("WELCOME TO PLUNGE", 1000, 300);
  fill(0);
  rect(400,600,300,75,15);
  fill(255);
  textSize(30);
  text("SINGLE PLAYER",height/2,width/3);
  fill(0);
  rect(1400,600,300,75,15);
  fill(255);
  textSize(30);
  text("MULTI PLAYER",1530,650);
  
}
void mousePressed()
{
  if(gamescreen==0)
  { 
    if((mouseX>=400) && (mouseX<=700) && (mouseY>=600) && (mouseY<=675))
  {
  gamescreen=1;
  pl=1;
  }
 if((mouseX>=1400) && (mouseX<=1700) && (mouseY>=600) && (mouseY<=675))
  {
  gamescreen=2;
  pl=2;
  }
}

if(gamescreen==4)
{
  if((mouseX>=400) && (mouseX<=700) && (mouseY>=600) && (mouseY<=675) && pl==1)
  {
gamescreen=1;
  }
  else if((mouseX>=400) && (mouseX<=700) && (mouseY>=600) && (mouseY<=675) && pl==2)
  {
  gamescreen=2;
  }
 if((mouseX>=1400) && (mouseX<=1700) && (mouseY>=600) && (mouseY<=675))
  {
  background(0);
  fill(0);
  rect(800,450,500,80,15);
  fill(255);
  textSize(30);
  text("PRESS ESC TO QUIT",1050,490);  
  noLoop();
  }
}
}

void draw()
{ 
  if(gamescreen==0)
    startscreen();
  else if(gamescreen==2)
    game2();
  else if(gamescreen==1)
    game1();
  else if(gamescreen==3)
    gameover();
  else if(gamescreen==4)
    pausescreen();
    
  if(bubblesCounter>MAX_NUM)
    gamescreen=3;
}

void pausescreen()
{
           fill(255);
  textSize(30);
  fill(0);
    rect(400,600,300,75,15);
    fill(255);
  text("RESUME",height/2,width/3);
  fill(0);
  rect(1400,600,300,75,15);
  fill(255);
  textSize(30);
  text("QUIT",1530,650);
}

void game1()
{
  background(255);
  frameRate(FPS);
  image(img2,0,0);
  
   textSize(30);
  fill(255);
  final1=sc1+sc2;
  text("SCORE: "+final1,900,50);
  fill(0);
   if (frameCount % FREQ == 0)  
     createBubbles();
   updateBubbles();
  drawBubbles();
  image(img,x1,y1,img.width/2,img.height/2);
  image(img4,x2,y1,img.width/2,img.height/2);
  
  distance=myPort.readStringUntil('\n');
  ldrdata=myPort3.readStringUntil('\n');
  distance2=myPort2.readStringUntil('\n');
  String s="0";
   if(distance!=null && distance!=" ")
   {   
     try 
     {
       s=trim(distance);
      float x=0;
       x=Float.parseFloat(s);
      x1=800+x*73.85;
     }
    catch (NumberFormatException e) {
      println("\"" + s + "\"");
      println("can't be converted to a number!");
    }
   }
      String s2="0";
   if(distance2!=null && distance2!=" ")
   {   
     try 
     {
       s2=trim(distance2);
       float pr=0;
       pr=Float.parseFloat(s2);
       x2=150-pr*73.85;
       } 
 
    catch (NumberFormatException e) {
      println("\"" + s2 + "\"");
      println("can't be converted to a number!");
    }
    
   }
   
if(ldrdata!=null && ldrdata!=" ")
   {   
     try 
     {
       ldrdata=trim(ldrdata);
      int l=0;
       l=Integer.parseInt(ldrdata);
      if(l==1)
       {
         gamescreen=4;
         l=0;
       }
     }
    catch (NumberFormatException e) {
      println("\"" + ldrdata + "\"");
      println("can't be converted to a number!");
    }
   }
}


void game2()
{
  background(255);
  frameRate(FPS);
  image(img2,0,0);
  
   textSize(30);
  fill(255);
    text("SCORE 1: "+sc1,800,50);
  text("SCORE 2: "+sc2,1200,50);
  fill(0);
   if (frameCount % FREQ == 0)  
     createBubbles();
   updateBubbles();
  drawBubbles();
  image(img,x1,y1,img.width/2,img.height/2);
  image(img4,x2,y1,img.width/2,img.height/2);
  ldrdata=myPort3.readStringUntil('\n');
  distance=myPort.readStringUntil('\n');
   distance2=myPort2.readStringUntil('\n');
  String s="0";
   if(distance!=null && distance!=" ")
   {   
     try 
     {
       s=trim(distance);
       float x=0;
       x=Float.parseFloat(s);
      x1=800+x*73.85;
      
     }
 
    catch (NumberFormatException e) {
      println("\"" + s + "\"");
      println("can't be converted to a number!");
    }
   }
      String s2="0";
   if(distance2!=null && distance2!=" ")
   {   
     try 
     {
       s2=trim(distance2);
       float pr=0;
       pr=Float.parseFloat(s2);
       x2=150-pr*73.85;

     }
   
    catch (NumberFormatException e) {
      println("\"" + s2 + "\"");
      println("can't be converted to a number!");
    }

 }
 if(ldrdata!=null && ldrdata!=" ")
   {   
     try 
     {
       ldrdata=trim(ldrdata);
      int l=0;
       l=Integer.parseInt(ldrdata);
      if(l==1)
       {
         gamescreen=4;
         l=0;
       }
     }
    catch (NumberFormatException e) 
    {
      println("\"" + ldrdata + "\"");
      println("can't be converted to a number!");
    }
   }
  }
void gameover()
{
background(0);
image(img2,0,0);
fill(0);
rect(760,300,400,100,15);
  fill(255);
 textSize(30);
text("GAME OVER!",960,350);
if(pl==1)
{
  fill(0);
rect(760,450,400,100,15);
  fill(255);
 textSize(30);
text("YOUR SCORE: "+final1,960,500);

  fill(0);
rect(760,600,400,100,15);
  fill(255);
 textSize(30);
text("PRESS ESC TO QUIT",960,650);
}

else if(pl==2)
{
  fill(0);
rect(760,450,400,100,15);
  fill(255);
 textSize(30);
 if(sc1>sc2)
   text("PLAYER 1 WINS!",960,500);
 else if(sc2>sc1)
    text("PLAYER 2 WINS!",960,500);
 else if(sc1==sc2)
   text("IT'S A TIE!",960,500);
  fill(0);
rect(760,600,400,100,15);
//
  fill(255);
 textSize(30);
text("PRESS ESC TO QUIT",960,650);
}
}

static final void updateBubbles() 
{
  for (int i=0; i!=MAX_NUM; i++)   
  if (bubblesState[i])
  {
    final int[] b = bubbles[i];
    //b[BUBBLE_SPD]+=gravity;
    b[BUBBLE_Y] += b[BUBBLE_SPD];
    
    if (bubblesState[i])
    if((b[BUBBLE_X]>=x1)&&(b[BUBBLE_X]<=(x1+300))&&(b[BUBBLE_Y]>=y1)&&(b[BUBBLE_Y]<=y1+20))
      {
        bubblesState[i] = false;
         sc2++;
          file.play();
         
      }
        if((b[BUBBLE_X]>=x2+700)&&(b[BUBBLE_X]<=(x2+1000))&&(b[BUBBLE_Y]>=y1)&&(b[BUBBLE_Y]<=y1+20))
      {
        bubblesState[i] = false;
         sc1++;
          file.play();
         
      }
     

    if (b[BUBBLE_Y] < -b[BUBBLE_SIZE]) 
    {
      bubblesState[i] = false;
      --bubblesCounter;
    }
  }
}
 
void drawBubbles() {
  for (int i=0; i!=MAX_NUM; i++) 
  if (bubblesState[i]) 
  {
    final int[] b = bubbles[i];
    fill(b[BUBBLE_COLOR]);
    stroke(255);
    ellipse(b[BUBBLE_X], b[BUBBLE_Y], b[BUBBLE_SIZE], b[BUBBLE_SIZE]);
  }
}
 
void createBubbles() {
  for (int i=0; i!=MAX_NUM; i++)  
  if (!bubblesState[i]) 
  {
    final int[] b = bubbles[i];
 
    b[BUBBLE_X] = (int) random(width);
    b[BUBBLE_Y] = 0;
    b[BUBBLE_SPD]   = (int) random(MIN_SPD, MAX_SPD + 1);
    b[BUBBLE_SIZE]  = (int) random(MIN_SIZE, MAX_SIZE + 1);
    b[BUBBLE_COLOR] = (color) random(#000000);
 
    bubblesState[i] = true;
    ++bubblesCounter;
    return;
  }
}
