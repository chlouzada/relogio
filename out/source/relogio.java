import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class relogio extends PApplet {

Ponteiro ponteiroSegundo,ponteiroMinuto,ponteiroHora;

public void setup (){
  

  ponteiroSegundo = new Ponteiro(60, 100, 0,0,0);
  ponteiroMinuto = new Ponteiro(60,80,0,0,0);
  ponteiroHora = new Ponteiro(12,40,0,0,0);
}

public void draw() {
  background(255);
  translate(200, 200);
  rotate(radians(-90));

  strokeWeight(8);
  stroke(255, 100, 150);
  noFill();
  
  ponteiroSegundo.update(second());
  ponteiroMinuto.update(minute());
  ponteiroHora.update(hour());

  // stroke(255);
  // point(0, 0);

}

class Ponteiro {
  int n;
  int tamanho;
  int red, green, blue;

  float rad;

  Ponteiro(int x,int t, int r, int g, int b) { 
    n = x;
    tamanho = t;
    red = r;
    green = g;
    blue = b;
  }

  public void update(int valor) {
    rad = radians(map(valor, 0, n, 0, 360));

    push();
    rotate(rad);
    stroke(red, green, blue);
    line(0, 0, tamanho, 0);
    pop();
  }

}
  public void settings() {  size(400, 400); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "relogio" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
