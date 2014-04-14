import ddf.minim.*;
import ddf.minim.analysis.*;
import processing.opengl.*;


Minim minim;
AudioPlayer track;
AudioMetaData meta;
FFT fft;
PFont calibri_14, calibri_20;
float[] angle, x, y;
int pcount; // Pause

void setup() {
 /* These are the dimensions it will run at, for any screen */
  int widthChop = (int) (displayWidth * 0.125);
  int playerWidth = displayWidth - widthChop; // Chop 1/8 off window width
  int heightChop = (int) (displayHeight * 0.25);
  int playerHeight = displayHeight - heightChop; // Chop 1/4 off window height
  size(playerWidth, playerHeight, OPENGL);
  frameRate(30);
  minim = new Minim(this);
  track = minim.loadFile("test.mp3", 2048);
  meta = track.getMetaData();
  fft = new FFT(track.bufferSize(), track.sampleRate());
  calibri_14 = createFont("Calibri", 14);
  calibri_20 = createFont("Calibri", 20);
  y = new float[fft.specSize()];
  x = new float[fft.specSize()];
  angle = new float[fft.specSize()];
  track.loop();
}
 
void draw() {
  background(0,0,0);
  trackInfo();
  fft.forward(track.mix);
  drawTheme();
}
 
void drawTheme() {
  noStroke();
  
  /* PURPLE ~ PINK */
  translate(width/2, height/2); // Pink starts in middle
  pushMatrix();
  for (int i = 0; i < fft.specSize() ; i++) {
    y[i] += fft.getBand(i)/50;
    x[i] += fft.getFreq(i)/50;
    angle[i] += fft.getFreq(i)/1000;
    rotateX(cos(angle[i]/4));
    rotateY(sin(angle[i]/4));
    fill((fft.getBand(i)*10), 0, (fft.getBand(i)*10), 240);
    pushMatrix();
    translate((x[i]+50) % (width/3), (y[i]+50) % (height/3));
    box(fft.getBand(i)/10+fft.getBand(i)/5);
    popMatrix();
  } popMatrix();
  
  /* RED */
  translate(-width/4, -height/4); // Red starts in upper left
  pushMatrix();
  for (int i = 0; i < fft.specSize() ; i++) {
    y[i] += fft.getBand(i)/100;
    x[i] += fft.getFreq(i)/100;
    angle[i] += fft.getFreq(i)/1000;
    rotateX(cos(angle[i]/4));
    rotateY(sin(angle[i]/4));
    fill((fft.getBand(i)*4), 0, 0, 200);
    pushMatrix();
    translate((x[i]+100) % width, (y[i]+100) % height);
    box(fft.getBand(i)/10+fft.getBand(i)/10);
    popMatrix();
  } popMatrix();
  
  /* BLUE */
  translate(width/2, height/2); // Blue starts in lower right
   pushMatrix();
   for (int i = 0; i < fft.specSize() ; i++) {
    y[i] += fft.getBand(i)/100;
    x[i] += fft.getFreq(i)/100;
    angle[i] += fft.getFreq(i)/1000;
    rotateX(cos(angle[i]/4));
    rotateY(sin(angle[i]/4));
    fill(0,0,255,75);
    pushMatrix();
    translate((x[i]+75) % (width/3), (y[i]+75) % (height/3));
    box(fft.getBand(i)/15+fft.getBand(i)/10);
    popMatrix();
  } popMatrix();
}

void trackInfo() {
    fill(255, 100, 175);
    textFont(calibri_20);
    text(meta.author() + " - " + meta.title(), 
         width - (width * 0.99), height - (height * 0.04)); 
    fill(225, 70, 150, 200);
    textFont(calibri_14);
    text("Current song: 1 of 1", width - (width * 0.99), 
              height - (height * 0.02));
}
  
void keyPressed() { // Spacebar
    if(keyCode == 32) {
         if((pcount % 2) == 0)
             track.pause(); 
         else
             track.play();
           
         pcount++;
     }
}
