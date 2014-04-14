/* To demonstrate basic theme changing (switch between classes) 
   Color --> Greyscale with "t" key
   I don't have any actual different themes yet.. */

class GSLines {
  private String author, title;
  
  GSLines(String author, String title) {
     this.author = author;
     this.title = title; 
  }
  
  void drawTheme() {
     background(0);
  
     for(int i = 0; i < track[count].bufferSize() - 1; i++) {
      float x1 = map( i, 0, track[count].bufferSize(), 0, width );
      float x2 = map( i+1, 0, track[count].bufferSize(), 0, width ); stroke(255);
      line( x1, ((height * 0.125) - 1) + track[count].right.get(i)*150, 
            x2, ((height * 0.125) + 1) + track[count].right.get(i+1)*150 ); stroke(225);
      line( x1, ((height * 0.25) - 2) + track[count].right.get(i)*150,
            x2, ((height * 0.25) + 2) + track[count].right.get(i+1)*150 ); stroke(200);
      line( x1, ((height * 0.375) - 3) + track[count].right.get(i)*150,
            x2, ((height * 0.375) + 3) + track[count].right.get(i+1)*150 ); stroke(150);
      line( x1, ((height * 0.5) - 4)+ track[count].left.get(i)*150,
            x2, ((height * 0.5) + 4) + track[count].left.get(i+1)*150 ); stroke(100);
      line( x1, ((height * 0.625) - 5) + track[count].left.get(i)*150,
            x2, ((height * 0.625) + 5) + track[count].left.get(i+1)*150 ); stroke(50); 
      line( x1, ((height * 0.75) - 6)+ track[count].left.get(i)*150, 
            x2, ((height * 0.75) + 6) + track[count].left.get(i+1)*150 );
    } 
  }
  
  void trackInfo() {
    fill(255);
    textFont(calibri_20);
    text(author + " - " + title, 
         width - (width * 0.99), height - (height * 0.04)); 
    
    fill(225);
    textFont(calibri_14);
    text("Current song: " + (count+1) + " of " + songs, 
         width - (width * 0.99), height - (height * 0.02));
  }
  
  void keyControls() {
     if(mouseX > width - (width * 0.20) && mouseY > height - (height * 0.025)) {
       fill(255); 
       textFont(calibri_14);
       text("left_previous" + "   |   " + "right_next" + '\n' + 
             "space_pause" + "   |   " + "m_mute" + '\n' +
             "c_color" + "   |   " + "t_theme ",
             width - (width * 0.20), height - (height * 0.125));
       
       fill(125);
       textFont(calibri_14);
       text("move mouse here to display key controls", 
             width - (width * 0.20), height - (height * 0.02));
    } else {
       fill(175);
       textFont(calibri_14);
       text("move mouse here to display key controls", 
             width - (width * 0.20), height - (height * 0.02));
    } 
  }
}
