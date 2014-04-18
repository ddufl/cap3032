class Cubes {
  private FFT fft;
  private float[] theta, x, y;
  private String author, title;
  
  Cubes(String author, String title) {
    this.fft = new FFT(track[count].bufferSize(), track[count].sampleRate());
    this.theta = new float[fft.specSize()]; 
    this.x = new float[fft.specSize()];
    this.y = new float[fft.specSize()];
    this.author = author;
    this.title = title; 
  }
  
 void drawTheme() {
   background(0);
   noStroke();
   fft.forward(track[count].mix);
  
   /* GOLD */
  pushMatrix();
  translate(width/4, height/2); // Gold on left
  for(int i = 0; i < fft.specSize(); i++) {
     y[i] += fft.getBand(i)/100;
     x[i] += fft.getFreq(i)/100;
     theta[i] += fft.getFreq(i)/1000;
     rotateZ(cos(theta[i]/500));
     fill(random(200,255), random(175,215), 0, 125);
     pushMatrix();
     translate(x[i] % (width/3), y[i] % (height/3));
     box(fft.getBand(i)/5);
     popMatrix();
   } popMatrix();
  
   /* PURPLE */
  pushMatrix();
  translate(width/2, height/2); // Purple in middle
  for(int i = 0; i < fft.specSize(); i++) {
    y[i] += fft.getBand(i)/50;
    x[i] += fft.getFreq(i)/50;
    theta[i] += fft.getFreq(i)/1000;
    rotateX(cos(theta[i]/50));
    rotateY(sin(theta[i]/50));
    fill(random(125,175), random(75,100), random(200,255), 150);
    if((track[count].position() % 2000) == 0) { 
      pushMatrix();
      translate(-width/8, -height/8);
      box(fft.getBand(i)/3);
      popMatrix();
    } else { 
      pushMatrix();
      translate(width/8, height/8);
      box(fft.getBand(i)/3);
      popMatrix();
    }
  } popMatrix();
  
  /* CYAN */
  pushMatrix();
  translate((3*width/4), height/2); // Cyan on right
  for(int i = 0; i < fft.specSize(); i++) {
    y[i] += fft.getBand(i)/100;
    x[i] += fft.getFreq(i)/100;
    theta[i] += fft.getFreq(i)/1000;
    rotateZ(-cos(theta[i]/500));
    fill(0, random(175,225), random(150,200), 175);
    pushMatrix();
    translate(x[i] % (width/3), y[i] % (height/3));
    box(fft.getBand(i)/4);
    popMatrix();
  } popMatrix();
 }   
  
  void trackInfo() {
    fill(175, 100, 255);
    textFont(calibri_20);
    text(author + " - " + title, 
         width - (width * 0.99), height - (height * 0.04)); 
    
    fill(175, 100, 255, 225);
    textFont(calibri_14);
    text("Current song: " + (count+1) + " of " + songs, 
         width - (width * 0.99), height - (height * 0.02));
  }
  
  void keyControls() {
     if(mouseX > width - (width * 0.20) && mouseY > height - (height * 0.025)) {
       fill(175, 100, 255); 
       textFont(calibri_14);
       text("                t_theme" + '\n' + 
            "left_previous" + "   |   " + "right_next" + '\n' + 
            "space_pause" + "   |   " + "m_mute",
            width - (width * 0.20), height - (height * 0.125));
       
       fill(60, 0, 135);
       textFont(calibri_14);
       text("move mouse here to display key controls", 
             width - (width * 0.20), height - (height * 0.02));
    } else {
       fill(115, 0, 185);
       textFont(calibri_14);
       text("move mouse here to display key controls", 
             width - (width * 0.20), height - (height * 0.02));
    } 
  }
}
