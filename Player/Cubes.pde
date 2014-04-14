class Cubes {
  private float[] angle, x, y;
  
  Cubes(int i) {
    this.angle = new float[fft[i].specSize()]; 
    this.x = new float[fft[i].specSize()];
    this.y = new float[fft[i].specSize()];
  }
  
 void drawTheme() {
  noStroke();
  
    /* PURPLE ~ PINK */
    translate(width/2, height/2); // Pink starts in middle
    pushMatrix();
    for (int i = 0; i < fft[count].specSize() ; i++) {
      y[i] += fft[count].getBand(i)/50;
      x[i] += fft[count].getFreq(i)/50;
      angle[i] += fft[count].getFreq(i)/1000;
      rotateX(cos(angle[i]/4));
      rotateY(sin(angle[i]/4));
      fill((fft[count].getBand(i)*10), 0, (fft[count].getBand(i)*10), 240);
      pushMatrix();
      translate((x[i]+50) % (width/3), (y[i]+50) % (height/3));
      box(fft[count].getBand(i)/10+fft[count].getBand(i)/5);
      popMatrix();
    } popMatrix();
  
  /* RED */
    translate(-width/4, -height/4); // Red starts in upper left
    pushMatrix();
    for (int i = 0; i < fft[count].specSize() ; i++) {
      y[i] += fft[count].getBand(i)/100;
      x[i] += fft[count].getFreq(i)/100;
      angle[i] += fft[count].getFreq(i)/10000;
      rotateX(cos(angle[i]/6));
      rotateY(sin(angle[i]/6));
      fill((fft[count].getBand(i)*4), 0, 0, 200);
      pushMatrix();
      translate((x[i]+100) % width, (y[i]+100) % height);
      box(fft[count].getBand(i)/10+fft[count].getBand(i)/10);
      popMatrix();
    } popMatrix();
  
  /* BLUE */
    translate(width/2, height/2); // Blue starts in lower right
    pushMatrix();
    for (int i = 0; i < fft[count].specSize() ; i++) {
      y[i] += fft[count].getBand(i)/100;
      x[i] += fft[count].getFreq(i)/100;
      angle[i] += fft[count].getFreq(i)/1000;
      rotateX(cos(angle[i]/8));
      rotateY(sin(angle[i]/8));
      fill(0,0,255,75);
      pushMatrix();
      translate((x[i]+75) % (width/3), (y[i]+75) % (height/3));
      box(fft[count].getBand(i)/15+fft[count].getBand(i)/10);
      popMatrix();
    } popMatrix();
  }
}
