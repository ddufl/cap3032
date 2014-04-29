import ddf.minim.*;
import ddf.minim.analysis.*;
import processing.opengl.*;
import java.lang.Number;

Minim minim;
AudioPlayer[] track;
AudioMetaData[] meta;
AudioSample change;
KeyControls kc;
Waves[] theme0, rtheme0;
BubbleWave[] theme1, rtheme1;
Cubism[] theme2, rtheme2;
RandomAuto rand;
int[] cycle_clr;
String sfx;
PFont calibri_14, calibri_16, calibri_20;

int count = 0; // Global song counter
final int songs = 4; // Must be set right or nothing works
final int themes = 4;


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
  rtheme0 = new Waves[songs];
  theme1 = new BubbleWave[songs];
  rtheme1 = new BubbleWave[songs];
  theme2 = new Cubism[songs];
  rtheme2 = new Cubism[songs];
  rand = new RandomAuto();
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
    rtheme0[i] = new Waves(meta[i].author(), meta[i].title());
    theme1[i] = new BubbleWave(meta[i].author(), meta[i].title());
    rtheme1[i] = new BubbleWave(meta[i].author(), meta[i].title());
    theme2[i] = new Cubism(meta[i].author(), meta[i].title());
    rtheme2[i] = new Cubism(meta[i].author(), meta[i].title());
  } track[0].play();
}

void draw() {
  if(kc.isRandom() == true) {
    rand.randomTheme();
    rand.drawTheme();
    fill(175);
    textFont(calibri_16);
    text("auto", width - (width * 0.997), height - (height * .98));
  } else if(kc.getTheme() == 0) {
    theme0[count].colorTheme();
    theme0[count].drawTheme();
    theme0[count].displayInfo();
    theme0[count].displayTime();
  } else if(kc.getTheme() == 1) {
    theme1[count].colorTheme();
    theme1[count].drawTheme();
    theme1[count].displayInfo();
    theme1[count].displayTime();
  } else if(kc.getTheme() == 2) {
    theme2[count].colorTheme();
    theme2[count].drawTheme();
    theme2[count].displayInfo();
    theme2[count].displayTime();
  }
}

/* Keyboard controls */
void keyPressed() {
 switch(keyCode) {
    case LEFT: 
      change.trigger();
      if(kc.isPaused() == true) 
        kc.setPause(false); 
      kc.previousSong(); break;
    case RIGHT:
      change.trigger(); 
      if(kc.isPaused() == true) 
        kc.setPause(false);     
      kc.nextSong(); break;
    case 32:  // Spacebar
      kc.pauseSong(); break;
    case 49: // Number 1
      kc.setTheme(0); break;
    case 50: // Number 2
      kc.setTheme(1); break;
    case 51: // Number 3
      kc.setTheme(2); break;
    case 65: // Letter A
      kc.Random(); break;
    case 67:  // Letter C
      if (kc.getTheme() == 0) kc.colorWaves();
      if (kc.getTheme() == 1) kc.colorBubbleWave();
      if (kc.getTheme() == 2) kc.colorCubism(); break;
    case 70:  // Letter F
      kc.skipForward(); break;
    case 77:  // Letter M
      kc.mutePlayer(); break;
    case 82:  // Letter R
      kc.skipBackward(); break;
    case 84:  // Letter T
      kc.cycleTheme(); break;
    default: break;
  }
}
