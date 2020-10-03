Ponteiro ponteiroSegundo,ponteiroMinuto,ponteiroHora;
Desenho desenho;

void setup (){
  size(800, 800);
  
  // Ponteiro: Tamanho, Largura, Offset, Cor
  ponteiroSegundo = new Ponteiro(100,3,10,color(255,100,100));
  ponteiroMinuto = new Ponteiro(100,5,5,color(0,0,0));
  ponteiroHora = new Ponteiro(50,6,0,color(0,0,0));

  desenho = new Desenho();
}

void draw() { 
  background(200);
  translate(400, 400);
  
  desenho.update();
  
  float a1,a2,a3;
  a1 = map(second(), 0, 60, 0, 360);
  a2 = map(minute() + norm(second(), 0, 60), 0, 60, 0, 360);
  a3 = map(hour() + norm(minute(), 0, 60), 0, 24, 0, 720);
  ponteiroSegundo.update(a1);
  ponteiroMinuto.update(a2);
  ponteiroHora.update(a3);

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
  int tamanho;
  int largura;
  int offset;
  color cor;

  Ponteiro(int t, int l, int os, color c) { 
    tamanho = t;
    largura = l;
    offset = - os;
    cor = c;
  }

  void update(float angulo) {
    push();
    rotate(radians(-90));
    rotate(radians(angulo));
    strokeWeight(largura);
    stroke(cor);
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