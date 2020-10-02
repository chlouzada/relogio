Ponteiro ponteiroSegundo,ponteiroMinuto,ponteiroHora;

void setup (){
  size(400, 400);

  ponteiroSegundo = new Ponteiro(60, 100, 0,0,0);
  ponteiroMinuto = new Ponteiro(60,80,0,0,0);
  ponteiroHora = new Ponteiro(12,40,0,0,0);
}

void draw() {
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

  void update(int valor) {
    rad = radians(map(valor, 0, n, 0, 360));

    push();
    rotate(rad);
    stroke(red, green, blue);
    line(0, 0, tamanho, 0);
    pop();
  }

}