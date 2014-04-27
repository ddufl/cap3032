class KeyControls {
  private int pcount; // Pause
  private int mcount;  // Mute
  private int tcount;  // Theme
  private int waves_count; // Waves color
  private int bwave_count; // BubbleWave color
  private boolean pstate;
     
     KeyControls() {
       pcount = mcount = tcount = 0;
       waves_count = bwave_count = 0;
       pstate = false; // Defaults to false
       //this.mstate = false; // Defaults to false
     }
     
     int getTcount() { return tcount; }
     boolean getPstate () { return pstate; }
    
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
       if((pcount % 2) == 0) {
           track[count].pause();
           pstate = true;
       } else { 
           track[count].play();
           pstate = false;   
       }
           
       pcount++;
     }
     
     void mutePlayer() {
       if((mcount % 2) == 0) {
          for(int i = 0; i < songs; i++)
           track[i].mute(); 
       } else {
          for(int i = 0; i < songs; i++)
           track[i].unmute();
       }
           
       mcount++;
     }
     
     void changeTheme() {
         tcount++;
         tcount %= themes;
         redraw();
     }
     
     void colorWaves() {
       waves_count++; 
       waves_count %= cycle_clr.length;
        
        for(int i = 0; i < songs; i++) {
             theme0[i].setColor(cycle_clr[waves_count]);
             redraw();
         }
     }
     
     void colorBubbleWaves() {
       bwave_count++; 
       bwave_count %= cycle_clr.length;
        
        for(int i = 0; i < songs; i++) {
             theme1[i].setColor(cycle_clr[bwave_count]);
             redraw();
         }
     }
     
     void skipForward() { track[count].skip(10000); }
     void skipBack() { track[count].skip(-10000); }
    
}
