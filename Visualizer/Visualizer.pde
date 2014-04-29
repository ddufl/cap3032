import ddf.minim.*;
import ddf.minim.analysis.*;
import processing.opengl.*;
import java.lang.Number;

Minim minim;
AudioPlayer[] track;
AudioMetaData[] meta;
AudioSample change;
KeyControls kc;
Waves[] theme0; 
BubbleWave[] theme1;
Cubism[] theme2;
int[] cycle_clr;
String sfx;
PFont calibri_14, calibri_16, calibri_20;

int count = 0; // Global song counter
final int songs = 4; // Must be set right or nothing works
final int themes = 3;

void setup() {
 /* SFX folder - CHANGE AS NEEDED */
  sfx = "/Users/derek/Documents/Processing/project/Visualizer/sfx/";
  
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
  cycle_clr = new int[6]; 
  for(int i = 0; i < 6; i++) cycle_clr[i] = i;
  
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
  int theme = kc.getTheme();
  boolean pstate = kc.isPaused();
  
  if(theme == 0) {
    theme0[count].colorTheme();
    theme0[count].drawTheme();
    theme0[count].displayInfo();
    theme0[count].displayTime(pstate);
  }
  
  if(theme == 1) {
    theme1[count].colorTheme();
    theme1[count].drawTheme();
    theme1[count].displayInfo();
    theme1[count].displayTime(pstate);
  }
  
   if(theme == 2) {
    theme2[count].colorTheme();
    theme2[count].drawTheme();
    theme2[count].displayInfo();
    theme2[count].displayTime(pstate);
  }
}

/* Keyboard controls */
void keyPressed() {
  int theme = kc.getTheme();
  
  switch(keyCode) {
    case LEFT: 
      change.trigger(); 
      kc.previousSong(); break;
    case RIGHT:
      change.trigger(); 
      kc.nextSong(); break;
    case 32:  // Spacebar
      kc.pauseSong(); break;
    case 49: // Number 1
      kc.setTheme(0); break;
    case 50: // Number 2
      kc.setTheme(1); break;
    case 51: // Number 3
      kc.setTheme(2); break;
    case 67:  // Lowercase C
      if (theme == 0) kc.colorWaves();
      if (theme == 1) kc.colorBubbleWave();
      if (theme == 2) kc.colorCubism(); break;
    case 70:  // Lowercase F
      kc.skipForward(); break;
    case 77:  // Lowercase M
      kc.mutePlayer(); break;
    case 82:  // Lowercase R
      kc.skipBack(); break;
    case 84:  // Lowercase T
      kc.cycleTheme(); break;
    default: break;
  }
}
