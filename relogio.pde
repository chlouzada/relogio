Ponteiro ponteiroSegundo,ponteiroMinuto,ponteiroHora;
Desenho desenho;

void setup (){
  size(800, 800);
  
  // Ponteiro: N Tamanho RGB Peso Offset
  ponteiroSegundo = new Ponteiro(60,100,0, 51, 102,3,10);
  ponteiroMinuto = new Ponteiro(60,100,0,0,0,5,5);
  ponteiroHora = new Ponteiro(12,50,0,0,0,6,0);

  desenho = new Desenho();
}

void draw() {
  background(200);
  translate(400, 400);
  
  
  desenho.update();
  
  ponteiroSegundo.update(second());
  ponteiroMinuto.update(minute());
  ponteiroHora.update(hour() % 12);


  // borda
  noFill();
  stroke(0,0,0);
  strokeWeight(3);
  circle(0,0,210);
  strokeWeight(1);
  circle(0,0,230);
  strokeWeight(10);
  stroke(200,100,5);
  arc(0, 0, 220, 220, 0, 360);
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

class Desenho {
  int n = 12;

  void update(){
    push();
    int t = 10;
    for (int i = 0; i < n; i++) {
      strokeWeight(2);
      stroke(100, 100, 100);

      // altera traço grande e médio
      line(0, (i % 2 == 0) ? 80 : 90 , 0, 100);

      // traço minutos
      for (int j = 0; j < 4; j++) {
        rotate(radians(6));
        line(0, 97, 0, 100);
      }
      rotate(radians(6));
    }
    pop();
  }
}