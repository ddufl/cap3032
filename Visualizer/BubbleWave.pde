class BubbleWave {
  private FFT fft;
  private float[] theta, x, y;
  private String author, title;
  private int clr;
  private int[] line = {255, 225, 200, 150, 100, 50};
  private int[] r = new int[6];
  private int[] g = new int[6];
  private int[] b = new int[6];
  private final int zero = 0;
  
  BubbleWave(String author, String title) {
    fft = new FFT(track[count].bufferSize(), track[count].sampleRate());
    theta = new float[fft.specSize()]; 
    x = new float[fft.specSize()];
    y = new float[fft.specSize()];
    this.author = author;
    this.title = title; 
  }
  
  void setColor(int clr) {
    this.clr = clr; 
  }
  
  void colorTheme() {
    switch(clr) {
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
    noStroke();
    fft.forward(track[count].mix);
   
    pushMatrix();
    translate(width/4, height/2);
    for(int i = 0; i < fft.specSize(); i++) {
      y[i] += fft.getBand(i)/100;
      x[i] += fft.getFreq(i)/100;
      theta[i] += fft.getFreq(i)/1000;
      rotateZ(cos(theta[i]/500));
      fill(r[2], g[2], b[2], 125);
      pushMatrix();
      translate(x[i] % (width/4), y[i] % (height/4));
      sphereDetail(5);
      sphere(fft.getBand(i)/4);
      popMatrix();
    } popMatrix();
   
    pushMatrix();
    translate(3*width/4, height/2);
    for(int i = 0; i < fft.specSize(); i++) {
      y[i] += fft.getBand(i)/100;
      x[i] += fft.getFreq(i)/100;
      theta[i] += fft.getFreq(i)/1000;
      rotateZ(cos(theta[i]/500));
      fill(r[2], g[2], b[2], 125);
      pushMatrix();
      translate(x[i] % (width/4), y[i] % (height/4));
      sphereDetail(5);
      sphere(fft.getBand(i)/4);
      popMatrix();
    } popMatrix();
  
    for(int i = 0; i < track[count].bufferSize() - 1; i++) {
      float x1 = map( i, 0, track[count].bufferSize(), 0, width );
      float x2 = map( i+1, 0, track[count].bufferSize(), 0, width ); 
      switch(clr) { 
        case 0: stroke(0, g[0], g[1]); break; // Green
        case 1: stroke(0, g[1] - 15, g[5] - 25); break; // Yellow
        case 2: stroke(r[0], r[1], 0); break; // Red
        case 3: stroke(r[0], 0, r[5] - 25); break; // Violet
        case 4: stroke(b[0] - 15, 0, b[0]); break; // Blue
        case 5: stroke(0, b[5] - 25, b[0]); break; // Cyan
        default: break;
      } line( x1, ((height * 0.5) - 1) + track[count].mix.get(i)*150, 
            x2, ((height * 0.5) + 1) + track[count].mix.get(i+1)*150 );
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
  
  void displayTime(boolean pstate) {
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
      
    if(pstate == false) {
      text(min + ":" + sec, width - (width * 0.03), height - (height * .02));
    } else { 
      text("paused", width - (width * 0.045), height - (height * .02));
    }
  }
}