Ponteiro ponteiroSegundo,ponteiroMinuto,ponteiroHora;

Marca marca;

void setup (){
  size(400, 400);
  
  // Ponteiro: N Tamanho RGB Peso Offset
  ponteiroSegundo = new Ponteiro(60,100,0,0,0,3,10);
  ponteiroMinuto = new Ponteiro(60,100,0,0,0,5,5);
  ponteiroHora = new Ponteiro(12,50,0,0,0,6,0);

  marca = new Marca();
}

void draw() {
  background(255);
  translate(200, 200);
  

  strokeWeight(8);
  stroke(255, 100, 150);
  noFill();
  
  ponteiroSegundo.update(second());
  ponteiroMinuto.update(minute());
  ponteiroHora.update(hour());

  marca.update();
}

class Ponteiro {
  int n;
  int tamanho;
  int red, green, blue;
  int offset;
  int weigth;

  float rad;

  Ponteiro(int x,int t, int r, int g, int b, int w, int os) { 
    n = x;
    tamanho = t;
    red = r;
    green = g;
    blue = b;
    weigth = w;
    offset = - os;
  }

  void update(int valor) {
    rad = radians(map(valor, 0, n, 0, 360));

    push();
    rotate(radians(-90));
    rotate(rad);
    strokeWeight(weigth);
    stroke(red, green, blue);
    line(offset, 0, tamanho, 0);
    pop();
  }
}

class Marca {
  int n = 12;

  void update(){
    push();
    int t = 10;
    boolean b;
    for (int i = 0; i < n; i++) {
      strokeWeight(2);
      stroke(100, 100, 100);

      if (i % 2 == 0) t = 80; else t = 90;
      line(0, t, 0, 100);
      rotate(radians(30));
    }
    pop();
  }
}