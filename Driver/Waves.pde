class Waves {
  private String author, title;
  private int clr;
  private int[] line = {255, 225, 200, 150, 100, 50};
  private int[] r = new int[6];
  private int[] g = new int[6];
  private int[] b = new int[6];
  private final int zero = 0;
  
  /* Constructor for metadata */
  Waves(String author, String title) {
     this.author = author;
     this.title = title; 
  }
  
  void setColor(int clr) { this.clr = clr; }
  
  void colorTheme() {
    switch(this.clr) {
      case 0: 
        for(int i = 0; i < line.length; i++) { // Green
          this.r[i] = zero;
          this.g[i] = line[i];
          this.b[i] = zero; 
        } break;
         
      case 1: 
        for(int i = 0; i < line.length; i++) { // Yellow
          this.r[i] = line[i];
          this.g[i] = line[i];
          this.b[i] = zero; 
        } break;
        
      case 2: 
        for(int i = 0; i < line.length; i++) {  // Red
          this.r[i] = line[i];
          this.g[i] = zero;
          this.b[i] = zero; 
        } break;
        
      case 3: 
        for(int i = 0; i < line.length; i++) {  // Violet
          this.r[i] = line[i];
          this.g[i] = zero;
          this.b[i] = line[i]; 
        } break;
        
      case 4: 
        for(int i = 0; i < line.length; i++) {  // Blue
          this.r[i] = zero;
          this.g[i] = zero;
          this.b[i] = line[i]; 
        } break;
        
      case 5: 
        for(int i = 0; i < line.length; i++) { // Cyan
          this.r[i] = zero;
          this.g[i] = line[i];
          this.b[i] = line[i]; 
        } break;
        
      default: 
        for(int i = 0; i < line.length; i++) { // Green
          this.r[i] = zero;
          this.g[i] = line[i];
          this.b[i] = zero; 
        } break;
     }
  }

  void drawTheme() {
    background(0);
    
    for(int i = 0; i < track[count].bufferSize() - 1; i++) {
      float x1 = map( i, 0, track[count].bufferSize(), 0, width );
      float x2 = map( i+1, 0, track[count].bufferSize(), 0, width ); stroke(r[0], g[0], b[0]);
      line( x1, ((height * 0.1875) - 1) + track[count].left.get(i)*150, 
            x2, ((height * 0.1875) + 1) + track[count].left.get(i+1)*150 ); stroke(r[1], g[1], b[1]);
      line( x1, ((height * 0.375) - 2) + track[count].left.get(i)*150,
            x2, ((height * 0.375) + 2) + track[count].left.get(i+1)*150 ); stroke(r[3], g[3], b[3]);
      line( x1, ((height * 0.5625) - 4)+ track[count].right.get(i)*150,
            x2, ((height * 0.5625) + 4) + track[count].right.get(i+1)*150 ); stroke(r[5], g[5], b[5]);
      line( x1, ((height * 0.75) - 6)+ track[count].right.get(i)*150, 
            x2, ((height * 0.75) + 6) + track[count].right.get(i+1)*150 );
    } 
  }
  
  void trackInfo() {
    fill(r[0], g[0], b[0]);
    textFont(calibri_20);
    text(author + " - " + title, 
         width - (width * 0.99), height - (height * 0.04)); 
    
    fill(r[1], g[1], b[1]);
    textFont(calibri_14);
    text("Current song: " + (count+1) + " of " + songs, 
         width - (width * 0.99), height - (height * 0.02));
  }
  
  void displayTime(boolean pstate) {
    int m, s;
    String min, sec;
  
    if(track[count].position() < 60000) {
      min = "0";
      
      if(track[count].position() < 10000) {
        s = (int) (track[count].position() / 1000);
        sec = "0" + Integer.toString(s);
      } else {
        s = (int) (track[count].position() / 1000);
        sec = Integer.toString(s);
      }
    } else {
      m = (int) (track[count].position() / 60000);
      min = Integer.toString(m);
    
      if((track[count].position() % 60000) < 10000) {
        s = (int) ((track[count].position() % 60000) / 1000);
        sec = "0" + Integer.toString(s);
      } else {
        s = (int) ((track[count].position() % 60000) / 1000);
        sec = Integer.toString(s); 
      }
    }

    textFont(calibri_16);
    
    if(pstate == false)
      text(min + ":" + sec, width - (width * 0.03), height - (height * .02));
    else
      text("paused", width - (width * 0.045), height - (height * .02));
  }
}
