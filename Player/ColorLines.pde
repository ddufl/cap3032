class ColorLines {
  private String author, title;
  private int clr;
  private int[] line = {255, 225, 200, 150, 100, 50};
  private int[] r = new int[6];
  private int[] g = new int[6];
  private int[] b = new int[6];
  private final int zero = 0;
  
  /* Constructor for metadata */
  ColorLines(String author, String title) {
     this.author = author;
     this.title = title; 
  }
  
  void setColor(int clr) {
    this.clr = clr;
  }
  
  void colorTheme() {
    switch(this.clr) {
      case 0 : for(int i = 0; i < line.length; i++) { // Green
               this.r[i] = zero;
               this.g[i] = line[i];
               this.b[i] = zero; 
              } break;
      case 1 : for(int i = 0; i < line.length; i++) { // Yellow
               this.r[i] = line[i];
               this.g[i] = line[i];
               this.b[i] = zero; 
              } break;
      case 2 : for(int i = 0; i < line.length; i++) {  // Red
               this.r[i] = line[i];
               this.g[i] = zero;
               this.b[i] = zero; 
              } break;
      case 3 : for(int i = 0; i < line.length; i++) {  // Violet
               this.r[i] = line[i];
               this.g[i] = zero;
               this.b[i] = line[i]; 
              } break;
      case 4 : for(int i = 0; i < line.length; i++) {  // Blue
               this.r[i] = zero;
               this.g[i] = zero;
               this.b[i] = line[i]; 
              } break;
      case 5 : for(int i = 0; i < line.length; i++) { // Cyan
               this.r[i] = zero;
               this.g[i] = line[i];
               this.b[i] = line[i]; 
              } break;
      default : for(int i = 0; i < line.length; i++) { // Green
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
      line( x1, ((height * 0.125) - 1) + track[count].right.get(i)*150, 
            x2, ((height * 0.125) + 1) + track[count].right.get(i+1)*150 ); stroke(r[1], g[1], b[1]);
      line( x1, ((height * 0.25) - 2) + track[count].right.get(i)*150,
            x2, ((height * 0.25) + 2) + track[count].right.get(i+1)*150 ); stroke(r[2], g[2], b[2]);
      line( x1, ((height * 0.375) - 3) + track[count].right.get(i)*150,
            x2, ((height * 0.375) + 3) + track[count].right.get(i+1)*150 ); stroke(r[3], g[3], b[3]);
      line( x1, ((height * 0.5) - 4)+ track[count].left.get(i)*150,
            x2, ((height * 0.5) + 4) + track[count].left.get(i+1)*150 ); stroke(r[4], g[4], b[4]);
      line( x1, ((height * 0.625) - 5) + track[count].left.get(i)*150,
            x2, ((height * 0.625) + 5) + track[count].left.get(i+1)*150 ); stroke(r[5], g[5], b[5]); 
      line( x1, ((height * 0.75) - 6)+ track[count].left.get(i)*150, 
            x2, ((height * 0.75) + 6) + track[count].left.get(i+1)*150 );
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
  
  void keyControls() {
     if(mouseX > width - (width * 0.20) && mouseY > height - (height * 0.025)) {
       fill(r[0], g[0], b[0]); 
       textFont(calibri_14);
       text("c_color" + "   |   " + "t_theme " + '\n' +
            "left_previous" + "   |   " + "right_next" + '\n' + 
            "space_pause" + "   |   " + "m_mute",
            width - (width * 0.20), height - (height * 0.125));
       
       fill(r[4], g[4], b[4]);
       textFont(calibri_14);
       text("move mouse here to display key controls", 
             width - (width * 0.20), height - (height * 0.02));
    } else {
       fill(r[3], g[3], b[3]);
       textFont(calibri_14);
       text("move mouse here to display key controls", 
             width - (width * 0.20), height - (height * 0.02));
    } 
  }
}
