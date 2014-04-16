import ddf.minim.*;
import ddf.minim.analysis.*;
import processing.opengl.*;

int count = 0; // Global song counter
final int songs = 3; // Must be set right or nothing works
final int themes = 2;
String sfx;
PFont calibri_14, calibri_20;

Minim minim;
AudioPlayer[] track;
AudioMetaData[] meta;
AudioSample change;
KeyControls kc;
ColorLines[] theme1; 
int[] theme1_clr;
Cubes[] theme2;

void setup() {
 /* SFX folder - CHANGE AS NEEDED */
  sfx = "/Users/derek/Documents/Processing/project/Player/sfx/";
  
 /* Fonts */
  calibri_14 = createFont("Calibri", 14);
  calibri_20 = createFont("Calibri", 20);
 
 /* Minim */
  minim = new Minim(this);
  change = minim.loadSample(sfx + "change.wav");
  track = new AudioPlayer[songs];
  meta = new AudioMetaData[songs];
  
 /* Objects etc */
  kc = new KeyControls(0, 0, 1, 0); // initialize counters
  theme1 = new ColorLines[songs];
  theme1_clr = new int[6]; for(int i = 0; i < 6; i++) theme1_clr[i] = i;
  theme2 = new Cubes[songs];
  
 /* These are the dimensions it will run at, for any screen */
  int widthChop = (int) (displayWidth * 0.125);
  int playerWidth = displayWidth - widthChop; // Chop 1/8 off window width
  int heightChop = (int) (displayHeight * 0.25);
  int playerHeight = displayHeight - heightChop; // Chop 1/4 off window height
  size(playerWidth, playerHeight, OPENGL);
  frameRate(30);
  
  for(int i = 0; i < songs; i++) {
    track[i] = minim.loadFile(i + ".mp3", 2048);
    meta[i] = track[i].getMetaData();
    theme1[i] = new ColorLines(meta[i].author(), meta[i].title());
    theme2[i] = new Cubes(meta[i].author(), meta[i].title());
  } 
   
  track[0].play();
}

void draw() {
  int tcount = kc.getTcount();
  
  if(tcount == 1) {
    theme1[count].colorTheme();
    theme1[count].drawTheme();
    theme1[count].trackInfo();
    theme1[count].keyControls();
  }
  
  if(tcount == 2) {
    theme2[count].drawTheme();
    theme2[count].trackInfo();
    theme2[count].keyControls();
  }
  
  /* Skip testing purposes
    if(keyPressed == true)
      if(keyCode == UP)
        println((track[count].position() / 1000) + 
                  " / " + track[count].length()); */
}

/* Keyboard controls */
void keyPressed() {
  switch(keyCode) {
    case LEFT : change.trigger(); kc.previousSong(); break;
    case RIGHT : change.trigger(); kc.nextSong(); break;
    case 32 : kc.pauseSong(); break; // Lowercase P
    case 67 : kc.changeColor(); break; // Lowercase C
    case 77 : kc.mutePlayer(); break; // Lowercase M
    case 84 : kc.changeTheme(); break; // Lowercase T
    default : break;
  }
}
