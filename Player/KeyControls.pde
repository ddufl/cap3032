class KeyControls {
  private int pcount; // Pause
  private int mcount;  // Mute
  private int tcount;  // Theme
  private int toc_count; // ColorLines 
     
     KeyControls(int pcount, int mcount,
                 int tcount, int toc_count) {
       this.pcount = pcount;
       this.mcount = mcount;
       this.tcount = tcount;
       this.toc_count = toc_count;
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
       if((pcount % 2) == 0)
           track[count].pause(); 
       else
           track[count].play();
           
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
       if(tcount < themes) {
          tcount++;
          redraw();
       } else {
          tcount = 1;
          redraw();
       }
     }
     
     int getTcount() {
       return tcount; 
     }
     
     void changeColor() {
       if(toc_count < (theme1_clr.length - 1)) {
         toc_count++;
         for(int i = 0; i < songs; i++) {
           theme1[i].setColor(theme1_clr[toc_count]);
           redraw();
         }
       } else {
         toc_count = 0;
         for(int i = 0; i < songs; i++) {
           theme1[i].setColor(theme1_clr[toc_count]);
           redraw();
         }
       }
     }
}
