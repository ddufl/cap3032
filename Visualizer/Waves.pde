class Waves {
  private String author, title;
  private int clr;
  private int[] level = {255, 225, 200, 150, 100, 50};
  private int[] r = new int[6];
  private int[] g = new int[6];
  private int[] b = new int[6];
  private final int zero = 0;
  
  Waves(String author, String title) {
     this.author = author;
     this.title = title; 
  }
  
  void setColor(int clr) {
    this.clr = clr; 
  }
  
  /* Base color */
  void colorTheme() {
    switch(clr) {
      case 0: 
        for(int i = 0; i < level.length; i++) { // Green
          r[i] = zero;
          g[i] = level[i];
          b[i] = zero; 
        } break;
      case 1: 
        for(int i = 0; i < level.length; i++) { // Yellow
          r[i] = level[i];
          g[i] = level[i];
          b[i] = zero; 
        } break;
      case 2: 
        for(int i = 0; i < level.length; i++) {  // Red
          r[i] = level[i];
          g[i] = zero;
          b[i] = zero; 
        } break;
      case 3: 
        for(int i = 0; i < level.length; i++) {  // Violet
          r[i] = level[i];
          g[i] = zero;
          b[i] = level[i]; 
        } break;
      case 4: 
        for(int i = 0; i < level.length; i++) {  // Blue
          r[i] = zero;
          g[i] = zero;
          b[i] = level[i]; 
        } break;
      case 5: 
        for(int i = 0; i < level.length; i++) { // Cyan
          r[i] = zero;
          g[i] = level[i];
          b[i] = level[i]; 
        } break;
      default: 
        for(int i = 0; i < level.length; i++) { // Green
          r[i] = zero;
          g[i] = level[i];
          b[i] = zero; 
        } break;
    }
  }

  void drawTheme() {
    background(0);
    
    for(int i = 0; i < track[count].bufferSize() - 1; i++) {
      float x1 = map( i, 0, track[count].bufferSize(), 0, width );
      float x2 = map( i+1, 0, track[count].bufferSize(), 0, width ); 
      if(kc.isPaused() == false) stroke(r[0], g[0], b[0]); else stroke(0);
      line( x1, ((height * 0.1875) - 1) + track[count].left.get(i)*150, 
            x2, ((height * 0.1875) + 1) + track[count].left.get(i+1)*150 );
      if(kc.isPaused() == false) stroke(r[1], g[1], b[1]); else stroke(0);     
      line( x1, ((height * 0.375) - 2) + track[count].left.get(i)*150,
            x2, ((height * 0.375) + 2) + track[count].left.get(i+1)*150 );
      if(kc.isPaused() == false) stroke(r[3], g[3], b[3]); else stroke(0);
      line( x1, ((height * 0.5625) - 4)+ track[count].right.get(i)*150,
            x2, ((height * 0.5625) + 4) + track[count].right.get(i+1)*150 );
      if(kc.isPaused() == false) stroke(r[5], g[5], b[5]); else stroke(0);
      line( x1, ((height * 0.75) - 6)+ track[count].right.get(i)*150, 
            x2, ((height * 0.75) + 6) + track[count].right.get(i+1)*150 );
    } 
  }
  
  void displayInfo() {
    fill(175);
    textFont(calibri_20);
    text(author + " - " + title, 
         width - (width * 0.99), height - (height * 0.04)); 
    
    fill(125);
    textFont(calibri_14);
    text("Current song: " + (count+1) + " of " + songs, 
         width - (width * 0.99), height - (height * 0.02));
  }
  
  void displayTime() {
    int m, s;
    String min, sec;
    fill(150);
    textFont(calibri_16);
    
    m = (int) (track[count].position() / 60000);
    min = Integer.toString(m);
    s = (int) ((track[count].position() % 60000) / 1000);
      
    if((track[count].position() % 60000) < 10000) {
      sec = "0" + Integer.toString(s);
    } else {
      sec = Integer.toString(s);
    }
      
    if(kc.isPaused() == false) {
      text(min + ":" + sec, width - (width * 0.03), height - (height * .02));
    } else { 
      text("paused", width - (width * 0.045), height - (height * .02));
    }
  }
}
