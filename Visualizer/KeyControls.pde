class KeyControls {
  private int pause; // Pause counter
  private int mute;  // Mute counter
  private int theme;  // Theme counter
  private int waves; // Waves counter
  private int bwave; // BubbleWave counter
  private int cubism; // Cubism counter 
  private boolean pstate; // Pause state
     
  KeyControls() {
    pause = mute = theme = 0;
    waves = bwave = cubism = 0;
    pstate = false;
  }
  
  int getTheme() { 
    return theme;
  }
  
  boolean isPaused() {
    return pstate; 
  }
  
   void setTheme(int theme) {
    this.theme = theme; 
  }
     
  void skipForward() {
    track[count].skip(10000);
  }
  
  void skipBack() { 
    track[count].skip(-10000);
  } 
    
  void nextSong() {
    if(count < (track.length - 1)) {
      change.trigger();
      track[count].rewind();
      track[count].pause();
      track[count+1].play();
      count++;
    } else {
      change.trigger();
      track[count].rewind();
      track[count].pause();
      count = 0;
      track[count].play();
    }
  }
     
  void previousSong() {
    if(count != 0) {
      change.trigger();
      track[count].rewind();
      track[count].pause();
      track[count-1].play();
      count--;
    } else {
      change.trigger();
      track[count].rewind();
      track[count].pause();
      track[songs-1].play();
      count = track.length - 1; 
    }
  }
     
  void pauseSong() {
    if((pause % 2) == 0) {
      track[count].pause();
      pstate = true;
    } else { 
      track[count].play();
      pstate = false;   
    } pause++;
  }
     
  void mutePlayer() {
    if((mute % 2) == 0) {
       for(int i = 0; i < songs; i++)
         track[i].mute(); 
       } else {
         for(int i = 0; i < songs; i++)
         track[i].unmute();
       } mute++;
    }
     
  void cycleTheme() {
    theme++;
    theme %= themes;
    redraw();
  }
     
  void colorWaves() {
     waves++; 
     waves %= cycle_clr.length;
        
     for(int i = 0; i < songs; i++) {
       theme0[i].setColor(cycle_clr[waves]);
       redraw();
     }
  }
     
  void colorBubbleWave() {
    bwave++; 
    bwave %= cycle_clr.length;
        
    for(int i = 0; i < songs; i++) {
      theme1[i].setColor(cycle_clr[bwave]);
      redraw();
    }
  }
  
  void colorCubism() {
    cubism++; 
    cubism %= cycle_clr.length;
        
    for(int i = 0; i < songs; i++) {
      theme2[i].setColor(cycle_clr[cubism]);
      redraw();
    }
  }  
}
