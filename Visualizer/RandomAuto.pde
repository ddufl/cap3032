class RandomAuto {
  private int theme, clr, time;
  
  RandomAuto() {
    theme = int(random(3));
    clr = int(random(6));
    time = 0;
  }
  
  void setTheme(int theme) {
    this.theme = theme;
  }
  
  void setColor(int clr) {
    this.clr = clr;  
  }
  
  void setTime(int time) {
    this.time = time;
  }
  
  void randomTheme() {
    if(track[count].position() > (time + 10000)) { 
      theme = int(random(3));
      clr = int(random(6));
      time = track[count].position();
    }
  }
  
  void drawTheme() {
    if(theme == 0) {
      switch(clr) {
        case 0: rtheme0[count].setColor(cycle_clr[clr]); break;
        case 1: rtheme0[count].setColor(cycle_clr[clr]); break;
        case 2: rtheme0[count].setColor(cycle_clr[clr]); break;
        case 3: rtheme0[count].setColor(cycle_clr[clr]); break;
        case 4: rtheme0[count].setColor(cycle_clr[clr]); break;
        case 5: rtheme0[count].setColor(cycle_clr[clr]); break;
        default: break;
      } rtheme0[count].colorTheme();
        rtheme0[count].drawTheme();
        rtheme0[count].displayInfo();
        rtheme0[count].displayTime();
    }
    
    if(theme == 1) {
       switch(clr) {
        case 0: rtheme1[count].setColor(cycle_clr[clr]); break;
        case 1: rtheme1[count].setColor(cycle_clr[clr]); break;
        case 2: rtheme1[count].setColor(cycle_clr[clr]); break;
        case 3: rtheme1[count].setColor(cycle_clr[clr]); break;
        case 4: rtheme1[count].setColor(cycle_clr[clr]); break;
        case 5: rtheme1[count].setColor(cycle_clr[clr]); break;
        default: break;
      } rtheme1[count].colorTheme();
        rtheme1[count].drawTheme();
        rtheme1[count].displayInfo();
        rtheme1[count].displayTime();
    }
    
    if(theme == 2) {
       switch(clr) {
        case 0: rtheme2[count].setColor(cycle_clr[clr]); break;
        case 1: rtheme2[count].setColor(cycle_clr[clr]); break;
        case 2: rtheme2[count].setColor(cycle_clr[clr]); break;
        case 3: rtheme2[count].setColor(cycle_clr[clr]); break;
        case 4: rtheme2[count].setColor(cycle_clr[clr]); break;
        case 5: rtheme2[count].setColor(cycle_clr[clr]); break;
        default: break;
      } rtheme2[count].colorTheme();
        rtheme2[count].drawTheme();
        rtheme2[count].displayInfo();
        rtheme2[count].displayTime();
    }
  } 
}
