import ddf.minim.*;
import ddf.minim.analysis.*;
import processing.opengl.*;
import java.lang.Number;

int count = 0; // Global song counter
final int songs = 3; // Must be set right or nothing works
final int themes = 3;
String sfx;
PFont calibri_14, calibri_16, calibri_20;

Minim minim;
AudioPlayer[] track;
AudioMetaData[] meta;
AudioSample change;
KeyControls kc;
Waves[] theme0; 
BubbleWave[] theme1;
Cubism[] theme2;
int[] cycle_clr;

void setup() {
 /* SFX folder - CHANGE AS NEEDED */
  sfx = "/Users/derek/Documents/Processing/project/Driver/sfx/";
  
 /* Fonts */
  calibri_14 = createFont("Calibri", 14);
  calibri_16 = createFont("Calibri", 16);
  calibri_20 = createFont("Calibri", 20);
 
 /* Minim */
  minim = new Minim(this);
  change = minim.loadSample(sfx + "change.wav");
  track = new AudioPlayer[songs];
  meta = new AudioMetaData[songs];
  
 /* Objects etc */
  kc = new KeyControls();
  theme0 = new Waves[songs];
  theme1 = new BubbleWave[songs];
  theme2 = new Cubism[songs];
  cycle_clr = new int[6]; for(int i = 0; i < 6; i++) cycle_clr[i] = i;
  
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
    theme0[i] = new Waves(meta[i].author(), meta[i].title());
    theme1[i] = new BubbleWave(meta[i].author(), meta[i].title());
    theme2[i] = new Cubism(meta[i].author(), meta[i].title());
  } 
   
  track[0].play();
}

void draw() {
  int tcount = kc.getTcount();
  boolean pstate = kc.getPstate();
  
  if(tcount == 0) {
    theme0[count].colorTheme();
    theme0[count].drawTheme();
    theme0[count].trackInfo();
    theme0[count].displayTime(pstate);
  }
  
  if(tcount == 1) {
    theme1[count].colorTheme();
    theme1[count].drawTheme();
    theme1[count].trackInfo();
    theme1[count].displayTime(pstate);
  }
  
   if(tcount == 2) {
    theme2[count].drawTheme();
    theme2[count].trackInfo();
    theme2[count].displayTime(pstate);
  }
}

/* Keyboard controls */
void keyPressed() {
  int tcount = kc.getTcount();
  
  switch(keyCode) {
    case LEFT: 
      change.trigger(); kc.previousSong(); break;
      
    case RIGHT:
      change.trigger(); kc.nextSong(); break;
      
    case 32:  // Spacebar
      kc.pauseSong(); break;
      
    case 67:  // Lowercase C
      if (tcount == 0) kc.colorWaves();
      if (tcount == 1) kc.colorBubbleWaves(); break;
      
    case 70:  // Lowercase F
      kc.skipForward(); break;
      
    case 77:  // Lowercase M
      kc.mutePlayer(); break;
      
    case 82:  // Lowercase R
      kc.skipBack(); break;
      
    case 84:  // Lowercase T
      kc.changeTheme(); break;
      
    default: break;
  }
}
