class Cubes {
  private FFT fft;
  private float[] angle, x, y;
  private String author, title;
  
  Cubes(String author, String title) {
    this.fft = new FFT(track[count].bufferSize(), track[count].sampleRate());
    this.angle = new float[fft.specSize()]; 
    this.x = new float[fft.specSize()];
    this.y = new float[fft.specSize()];
    this.author = author;
    this.title = title; 
  }
  
 void drawTheme() {
   background(0);
   noStroke();
   fft.forward(track[count].mix);
  
   /* CYAN */
  pushMatrix();
  translate(width/2, height/2); // Cyan starts in middle
  for (int i = 0; i < fft.specSize() ; i++) {
    y[i] += fft.getBand(i)/50;
    x[i] += fft.getFreq(i)/50;
    angle[i] += fft.getFreq(i)/1000;
    rotateX(cos(angle[i]/4));
    rotateY(sin(angle[i]/4));
    fill(0, (fft.getBand(i)*10), (fft.getBand(i)*10), 240);
    pushMatrix();
    translate((x[i]+25) % (width/3), (y[i]+25) % (height/3));
    box(fft.getBand(i)/3);
    popMatrix();
  } popMatrix();
  
  /* RED */
  pushMatrix();
  translate(width/4, height/4); // Red starts in upper left
  for (int i = 0; i < fft.specSize() ; i++) {
    y[i] += fft.getBand(i)/100;
    x[i] += fft.getFreq(i)/100;
    angle[i] += fft.getFreq(i)/1000;
    rotateX(cos(angle[i]/4));
    rotateY(sin(angle[i]/4));
    fill((fft.getBand(i)*4), 0, 0, 200);
    pushMatrix();
    translate((x[i]+25) % width, (y[i]+25) % height);
    box(fft.getBand(i)/5);
    popMatrix();
  } popMatrix();
  
  /* BLUE */
   pushMatrix();
   translate((3*width/4), (3*height/4)); // Blue starts in lower right
   for (int i = 0; i < fft.specSize() ; i++) {
    y[i] += fft.getBand(i)/100;
    x[i] += fft.getFreq(i)/100;
    angle[i] += fft.getFreq(i)/1000;
    rotateX(cos(angle[i]/4));
    rotateY(sin(angle[i]/4));
    fill(0,0,255,75);
    pushMatrix();
    translate((x[i]+25) % (width/3), (y[i]+25) % (height/3));
    box(fft.getBand(i)/5);
    popMatrix();
  } popMatrix();
 }
 
 void trackInfo() {
    fill(0,255,255);
    textFont(calibri_20);
    text(author + " - " + title, 
         width - (width * 0.99), height - (height * 0.04)); 
    
    fill(0,255,255);
    textFont(calibri_14);
    text("Current song: " + (count+1) + " of " + songs, 
         width - (width * 0.99), height - (height * 0.02));
  }
  
  void keyControls() {
     if(mouseX > width - (width * 0.20) && mouseY > height - (height * 0.025)) {
       fill(0,255,255); 
       textFont(calibri_14);
       text("                t_theme" + '\n' + 
            "left_previous" + "   |   " + "right_next" + '\n' + 
            "space_pause" + "   |   " + "m_mute",
            width - (width * 0.20), height - (height * 0.125));
       
       fill(0,100,100);
       textFont(calibri_14);
       text("move mouse here to display key controls", 
             width - (width * 0.20), height - (height * 0.02));
    } else {
       fill(0,150,150);
       textFont(calibri_14);
       text("move mouse here to display key controls", 
             width - (width * 0.20), height - (height * 0.02));
    } 
  }
}
