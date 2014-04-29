class Cubism {
  private FFT fft;
  private float[] theta, x, y;
  private String author, title;
  private int clr;
  private int[] level = {255, 225, 200, 150, 100, 50};
  private int[] r = new int[6];
  private int[] g = new int[6];
  private int[] b = new int[6];
  private final int zero = 0;
  
  Cubism(String author, String title) {
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
  
  /* Base color - other colors are cycled in relation to this */
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
   noStroke();
   fft.forward(track[count].mix);
  
   /* LEFT */
  pushMatrix();
  translate(width/4, height/2);
  for(int i = 0; i < fft.specSize(); i++) {
     y[i] += fft.getBand(i)/100;
     x[i] += fft.getFreq(i)/100;
     theta[i] += fft.getFreq(i)/1000;
     rotateZ(cos(theta[i]/500));
     fill(r[2], g[2], b[2], 125);
     pushMatrix();
     translate(x[i] % (width/8), y[i] % (height/8));
     box(fft.getBand(i)/10);
     popMatrix();
   } popMatrix();
  
   /* CENTER */
  pushMatrix();
  translate(width/2, height/2);
  for(int i = 0; i < fft.specSize(); i++) {
    y[i] += fft.getBand(i)/50;
    x[i] += fft.getFreq(i)/50;
    theta[i] += fft.getFreq(i)/1000;
    rotateZ(cos(theta[i]/500));
    switch(clr) { 
        case 0: fill(0, g[0], g[1]); break;
        case 1: fill(0, g[1] - 15, g[5] - 25); break;
        case 2: fill(r[0], r[1], 0); break;
        case 3: fill(r[0], 0, r[5] - 25); break;
        case 4: fill(b[0] - 15, 0, b[0]); break;
        case 5: fill(0, b[5] - 25, b[0]); break;
        default: break;
    } pushMatrix();
    translate(x[i] % (width/4), y[i] % (height/4));
    box(fft.getBand(i)/4);
    popMatrix();
  } popMatrix();
  
  /* RIGHT */
  pushMatrix();
  translate((3*width/4), height/2);
  for(int i = 0; i < fft.specSize(); i++) {
    y[i] += fft.getBand(i)/100;
    x[i] += fft.getFreq(i)/100;
    theta[i] += fft.getFreq(i)/1000;
    rotateZ(-cos(theta[i]/500));
    switch(clr) { 
        case 0: fill(0, g[5] - 25, g[0]); break;
        case 1: fill(0, g[0], g[1]); break;
        case 2: fill(0, r[1] - 15, r[5] - 25); break;
        case 3: fill(r[0], r[1], 0); break;
        case 4: fill(b[0], 0, b[5] - 25); break;
        case 5: fill(b[0] - 15, 0, b[0]); break;
        default: break; 
    } pushMatrix();
    translate(x[i] % (width/8), y[i] % (height/8));
    box(fft.getBand(i)/10);
    popMatrix();
  } popMatrix();
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
