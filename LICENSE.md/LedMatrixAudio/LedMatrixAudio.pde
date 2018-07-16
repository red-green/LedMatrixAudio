import ddf.minim.analysis.*;
import ddf.minim.*;
import ddf.minim.ugens.*;

Minim       minim;
AudioInput  input;
FFT         fft;
MoogFilter  filter;

PFont       f;
OPC         opc;

// settings
int fftsize = 0; // set after fft is initialized
int step = 4;
int rainstep = 4;


// global variables
float fftscale = 20;
float maxsnd = 0;

int mode = 3;

int scale = 20;

float a1 = 0, a2 = HALF_PI, a3 = PI, a4 = HALF_PI + PI, a5 = TWO_PI;

float x = 0;

void setup() {
  size(800,160); // change this to use `scale` * 8
  
  minim = new Minim(this);
  input = minim.getLineIn();
  fft = new FFT(input.bufferSize(),input.sampleRate());
  
  //fftsize = fft.specSize()
  fftsize = 40;
  step = (int)((input.bufferSize())/40);
  
  //logo = loadShape("jacksonaudio.svg");
  
  frameRate(180);
  opc = new OPC(this, "127.0.0.1", 7890);
  
  opc.ledGrid8x8(0*64,4*scale,4*scale,scale,radians(90),false);
  opc.ledGrid8x8(2*64,12*scale,4*scale,scale,radians(90),false);
  opc.ledGrid8x8(1*64,20*scale,4*scale,scale,radians(90),false);
  opc.ledGrid8x8(4*64,28*scale,4*scale,scale,radians(90),false);
  opc.ledGrid8x8(3*64,36*scale,4*scale,scale,radians(90),false);

  background(0);
}

float last_trig = 100;

int rainbow = 0;

void draw() {
  fft.forward(input.mix);
  rainbow += rainstep;
  rainbow %= 255;
  
  background(0);
  
  // do the calc for fft scale
  float maxfft = -1;
  for (int b = 0; b < fftsize; b++) {
    if (fft.getBand(b) > maxfft) maxfft = fft.getBand(b);
  }
  if (maxfft > fftscale) fftscale = maxfft;
  if (fftscale > 40) fftscale *= 0.97;
  
  
  if (mode == 3) {
    colorMode(HSB);
  } else {
    colorMode(RGB);
  }
  if (mode == 0) {
    
  } else if (mode == 1) {
    for (int i = 0; i < 40; i++) {
      stroke(getcolor(fft.getBand(i)));
      line(i*scale+10,height,i*scale+10,height-map(fft.getBand(i),0,maxfft,0,height));
    }
  } else if (mode == 2) {
    float a = 0;
    noStroke();
    fill(255,0,0);
    a = map(fft.getBand(1),0,maxfft,0,7*scale);
    arc(4*scale,4*scale,a,a,a1,a2,PIE);
    fill(0,255,0);
    a = map(fft.getBand(2),0,maxfft,0,7*scale);
    arc(4*scale,4*scale,a,a,a2,a3,PIE);
    fill(0,0,255);
    a = map(fft.getBand(3),0,maxfft,0,7*scale);
    arc(4*scale,4*scale,a,a,a3,a4,PIE);
    fill(255,255,0);
    a = map(fft.getBand(4),0,maxfft,0,7*scale);
    arc(4*scale,4*scale,a,a,a4,a5,PIE);
    
    fill(255,0,0);
    a = map(fft.getBand(5),0,maxfft,0,7*scale);
    arc(12*scale,4*scale,a,a,a1,a2,PIE);
    fill(0,255,0);
    a = map(fft.getBand(6),0,maxfft,0,7*scale);
    arc(12*scale,4*scale,a,a,a2,a3,PIE);
    fill(0,0,255);
    a = map(fft.getBand(7),0,maxfft,0,7*scale);
    arc(12*scale,4*scale,a,a,a3,a4,PIE);
    fill(255,255,0);
    a = map(fft.getBand(8),0,maxfft,0,7*scale);
    arc(12*scale,4*scale,a,a,a4,a5,PIE);
    
    fill(255,0,0);
    a = map(fft.getBand(9),0,maxfft,0,7*scale);
    arc(20*scale,4*scale,a,a,a1,a2,PIE);
    fill(0,255,0);
    a = map(fft.getBand(10),0,maxfft,0,7*scale);
    arc(20*scale,4*scale,a,a,a2,a3,PIE);
    fill(0,0,255);
    a = map(fft.getBand(11),0,maxfft,0,7*scale);
    arc(20*scale,4*scale,a,a,a3,a4,PIE);
    fill(255,255,0);
    a = map(fft.getBand(12),0,maxfft,0,7*scale);
    arc(20*scale,4*scale,a,a,a4,a5,PIE);
    
    fill(255,0,0);
    a = map(fft.getBand(13),0,maxfft,0,7*scale);
    arc(28*scale,4*scale,a,a,a1,a2,PIE);
    fill(0,255,0);
    a = map(fft.getBand(14),0,maxfft,0,7*scale);
    arc(28*scale,4*scale,a,a,a2,a3,PIE);
    fill(0,0,255);
    a = map(fft.getBand(15),0,maxfft,0,7*scale);
    arc(28*scale,4*scale,a,a,a3,a4,PIE);
    fill(255,255,0);
    a = map(fft.getBand(16),0,maxfft,0,7*scale);
    arc(28*scale,4*scale,a,a,a4,a5,PIE);
    
    fill(255,0,0);
    a = map(fft.getBand(17),0,maxfft,0,7*scale);
    arc(36*scale,4*scale,a,a,a1,a2,PIE);
    fill(0,255,0);
    a = map(fft.getBand(18),0,maxfft,0,7*scale);
    arc(36*scale,4*scale,a,a,a2,a3,PIE);
    fill(0,0,255);
    a = map(fft.getBand(19),0,maxfft,0,7*scale);
    arc(36*scale,4*scale,a,a,a3,a4,PIE);
    fill(255,255,0);
    a = map(fft.getBand(20),0,maxfft,0,7*scale);
    arc(36*scale,4*scale,a,a,a4,a5,PIE);
  } else if (mode == 4) { 
    float a = 0;
    noStroke();
    fill(255,0,0);
    a = map(fft.getBand(1),0,maxfft,0,7*scale);
    ellipse(4*scale,4*scale,a,a);
    fill(0,255,0);
    a = map(fft.getBand(2),0,maxfft,0,7*scale);
    ellipse(4*scale,4*scale,a,a);
    fill(0,0,255);
    a = map(fft.getBand(3),0,maxfft,0,7*scale);
    ellipse(4*scale,4*scale,a,a);
    fill(255,255,0);
    a = map(fft.getBand(4),0,maxfft,0,7*scale);
    ellipse(4*scale,4*scale,a,a);
    
    fill(255,0,0);
    a = map(fft.getBand(5),0,maxfft,0,7*scale);
    ellipse(12*scale,4*scale,a,a);
    fill(0,255,0);
    a = map(fft.getBand(6),0,maxfft,0,7*scale);
    ellipse(12*scale,4*scale,a,a);
    fill(0,0,255);
    a = map(fft.getBand(7),0,maxfft,0,7*scale);
    ellipse(12*scale,4*scale,a,a);
    fill(255,255,0);
    a = map(fft.getBand(8),0,maxfft,0,7*scale);
    ellipse(12*scale,4*scale,a,a);
    
    fill(255,0,0);
    a = map(fft.getBand(9),0,maxfft,0,7*scale);
    ellipse(20*scale,4*scale,a,a);
    fill(0,255,0);
    a = map(fft.getBand(10),0,maxfft,0,7*scale);
    ellipse(20*scale,4*scale,a,a);
    fill(0,0,255);
    a = map(fft.getBand(11),0,maxfft,0,7*scale);
    ellipse(20*scale,4*scale,a,a);
    fill(255,255,0);
    a = map(fft.getBand(12),0,maxfft,0,7*scale);
    ellipse(20*scale,4*scale,a,a);
    
    fill(255,0,0);
    a = map(fft.getBand(13),0,maxfft,0,7*scale);
    ellipse(28*scale,4*scale,a,a);
    fill(0,255,0);
    a = map(fft.getBand(14),0,maxfft,0,7*scale);
    ellipse(28*scale,4*scale,a,a);
    fill(0,0,255);
    a = map(fft.getBand(15),0,maxfft,0,7*scale);
    ellipse(28*scale,4*scale,a,a);
    fill(255,255,0);
    a = map(fft.getBand(16),0,maxfft,0,7*scale);
    ellipse(28*scale,4*scale,a,a);
    
    fill(255,0,0);
    a = map(fft.getBand(17),0,maxfft,0,7*scale);
    ellipse(36*scale,4*scale,a,a);
    fill(0,255,0);
    a = map(fft.getBand(18),0,maxfft,0,7*scale);
    ellipse(36*scale,4*scale,a,a);
    fill(0,0,255);
    a = map(fft.getBand(19),0,maxfft,0,7*scale);
    ellipse(36*scale,4*scale,a,a);
    fill(255,255,0);
    a = map(fft.getBand(20),0,maxfft,0,7*scale);
    ellipse(36*scale,4*scale,a,a);
  } else if (mode == 3) {
    for (int xv = 0; xv < 40; xv++) {
      for (int yv = 0; yv < 8; yv++) {
        int rv = rainbow + (xv-yv)*8;
        stroke((rv%255),255,255);
        point(xv*scale+10,yv*scale+10);
      }
    }
  } else if (mode == 5) {
    maxsnd = 0.1;
    float b = 0;
    for(int  i = 0; i < step*40; i+=step) {
      b = abs(input.mix.get(i));
      if (b > maxsnd) maxsnd = b;
    }
    int start = 0;
    float closest = 1000;
    
    for(int  i = 0; i < input.bufferSize(); i++) {
      if (abs(last_trig - input.mix.get(i)) < closest) {
        closest = abs(last_trig - input.mix.get(i));
        start = i;
      }
    }
    //last_trig = closest;
    
    stroke(0,255,0);
    for(int  i = 0; i < step*40; i+=step) {
      float a = (int)map(input.mix.get((i+start)%input.bufferSize()),-maxsnd,maxsnd,0,height);
      stroke(getcolor(map(abs(input.mix.get((i+start)%input.bufferSize())),0,maxsnd,0,fftscale*0.7)));
      line((i/step)*scale+10,a-10,(i/step)*scale+10,a+10);
    }
  } else if (mode == 6) {
    maxsnd = 0.1;
    float b = 0;
    for(int  i = 0; i < step*40; i+=step) {
      b = abs(input.mix.get(i));
      if (b > maxsnd) maxsnd = b;
    }
    int start = 0;
    float closest = 1000;
    
    for(int  i = 0; i < input.bufferSize(); i++) {
      if (abs(last_trig - input.mix.get(i)) < closest) {
        closest = abs(last_trig - input.mix.get(i));
        start = i;
      }
    }
    //last_trig = closest;
    
    stroke(0,255,0);
    for(int  i = 0; i < step*40; i+=step) {
      float a = (int)map(input.mix.get((i+start)%input.bufferSize()),-maxsnd,maxsnd,0,height);
      stroke(getcolor(map(abs(input.mix.get((i+start)%input.bufferSize())),0,maxsnd,0,fftscale*0.7)));
      line((i/step)*scale+10,height/2,(i/step)*scale+10,a+10);
    }
  } else if (mode == 7) {
    x++;
    if (x > mouseX/10) x = 0;
    if (x > mouseX/10-1) background(255);
  }
  
  
}

color getcolor(float start) {
  //return color(map(start,0,fftscale,red(mincolor),red(maxcolor)),map(start,0,fftscale,green(mincolor),green(maxcolor)),map(start,0,fftscale,blue(mincolor),blue(maxcolor)));

  float c = map(start,0,fftscale,0,1024);
  float t = min(c / 100.0,1);
 
  if (c < 256) return color(0,c*t,(255-c)*t);
  c-=256;
  if (c < 256) return color(c*t,255*t,0);
  c-=256;
  if (c < 256) return color(c*t,(255-c)*t,0);
  c-=256;
  return color(255*t,255*t,c*t);
}

color wheel(int WheelPos) {
  WheelPos = 255 - WheelPos;
  if(WheelPos < 85) {
   return color(255 - WheelPos * 3, 0, WheelPos * 3);
  } else if(WheelPos < 170) {
    WheelPos -= 85;
   return color(0, WheelPos * 3, 255 - WheelPos * 3);
  } else {
   WheelPos -= 170;
   return color(WheelPos * 3, 255 - WheelPos * 3, 0);
  }
}

void keyPressed() {
  if (key == 'z') mode = 1;
  if (key == 'x') mode = 2;
  if (key == 'c') mode = 3;
  if (key == 'v') mode = 4;
  if (key == 'b') mode = 5;
  if (key == 'n') mode = 6;
  if (key == 'm') mode = 7;
  if (key == ' ') mode = 0;
}
  