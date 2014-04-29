class KeyControls {
  private int pause; // Pause counter
  private int mute;  // Mute counter
  private int random; // Random counter
  private int theme;  // Theme counter
  private int waves; // Waves color counter
  private int bwave; // BubbleWave color counter
  private int cubism; // Cubism color counter 
  private boolean pstate; // Pause state
  private boolean rstate; // Random state
     
  KeyControls() {
    pause = mute = random = theme = 0;
    waves = bwave = cubism = 0;
    pstate = rstate = false;
  }
  
  int getTheme() { 
    return theme;
  }
  
  boolean isPaused() {
    return pstate; 
  }
  
  boolean isRandom() {
    return rstate; 
  }
  
   void setTheme(int theme) {
    this.theme = theme; 
  }
  
  void setPause(boolean pstate) {
    this.pstate = pstate; 
  }
     
  void skipForward() {
    track[count].skip(10000);
  }
  
  void skipBackward() { 
    track[count].skip(-10000);
  } 
    
  void nextSong() {
    if(count < (track.length - 1)) {
      change.trigger();
      track[count].rewind();
      track[count].pause();
      if(rstate == true) rand.setTime(0);
      track[count+1].play();
      count++;
    } else {
      change.trigger();
      track[count].rewind();
      track[count].pause();
      count = 0;
      if(rstate == true) rand.setTime(0);
      track[count].play();
    }
  }
     
  void previousSong() {
    if(count != 0) {
      change.trigger();
      track[count].rewind();
      track[count].pause();
      if(rstate == true) rand.setTime(0);
      track[count-1].play();
      count--;
    } else {
      change.trigger();
      track[count].rewind();
      track[count].pause();
      if(rstate == true) rand.setTime(0);
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
  
    
  void Random() {
    if((random % 2) == 0) {
      rstate = true;
    } else { 
      rstate = false;   
    } random++;
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
