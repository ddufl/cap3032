import ddf.minim.*;
import processing.opengl.*;

int count = 0;
final int songs = 3; // Must be set or nothing works
final int themes = 2;  // "Two" for now
String user, folder, sfx;
PFont calibri_14, calibri_20;

Minim minim;
AudioPlayer[] track;
AudioMetaData[] meta;
AudioSample change;
KeyControls kc;
ColorLines[] theme1; 
int[] theme1_clr;
GSLines[] theme2;


void setup() {
 /* SFX folder - change as needed */
  user = "derek"; 
  folder = "project";
  sfx = "/Users/" + user + "/Documents/Processing/" + folder + "/Player/sfx/";
  
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
  theme2 = new GSLines[songs];
  
 /* These are the dimensions it will run at, for any screen */
  int widthChop = (int) (displayWidth * 0.125);
  int playerWidth = displayWidth - widthChop; // Chop 1/8 off window width
  int heightChop = (int) (displayHeight * 0.25);
  int playerHeight = displayHeight - heightChop; // Chop 1/4 off window height
  size(playerWidth, playerHeight, OPENGL);
  
  /* The only way I've gotten tracks to load is by naming the files [0 - (n-1)].mp3
     Surely there's a better way of doing this. */
  for(int i = 0; i < songs; i++) {
    track[i] = minim.loadFile(i + ".mp3", 2048);
    meta[i] = track[i].getMetaData();
    theme1[i] = new ColorLines(meta[i].author(), meta[i].title());
    theme2[i] = new GSLines(meta[i].author(), meta[i].title());
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
