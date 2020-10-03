Ponteiro ponteiroSegundo,ponteiroMinuto,ponteiroHora;
Desenho desenho;
Corpo corpo;

void setup (){
  size(800, 800);
  
  // Ponteiro: Tamanho, Largura, Offset, Cor  
  ponteiroSegundo = new Ponteiro(100,1.5,10,color(255,0,0));
  ponteiroMinuto = new Ponteiro(100,5,5,color(0,0,0));
  ponteiroHora = new Ponteiro(50,6,0,color(0,0,0));
  corpo = new Corpo();

  desenho = new Desenho();
}

void draw() { 
  background(200);
  translate(400, 400);
  noFill();

  desenho.update();

  corpo.update();
  
  float a1,a2,a3;
  a1 = map(second(), 0, 60, 0, 360) - 90;
  a2 = map(minute() + norm(second(), 0, 60), 0, 60, 0, 360) - 90;
  a3 = map(hour() + norm(minute(), 0, 60), 0, 24, 0, 720) - 90;
  ponteiroSegundo.update(a1);
  ponteiroMinuto.update(a2);
  ponteiroHora.update(a3);

  // borda
  
}

class Ponteiro {
  float tamanho;
  float largura;
  float offset;
  color cor;

  Ponteiro(float t, float l, float os, color c) { 
    tamanho = t;
    largura = l;
    offset = - os;
    cor = c;
  }

  void update(float angulo) {
    push();
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
    for (int i = 0; i < n; i++) {
      strokeWeight(2.3);
      stroke(100, 100, 100);

      // alterna traço grande e médio
      line(0, (i % 2 == 0) ? 75 : 85 , 0, 100);

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

class Corpo {
  int raio = 220;
  int largura = 10;

  void update(){
    // pino
    push();
    translate((raio+largura)/2,0);
    stroke(0,0,0);
    strokeWeight(4);
    line(0,0,1,0);
    translate(7,5);
    strokeWeight(10);
    line(0,0,0,-10);
    pop();

    // borda exterior
    stroke(0,0,0);
    strokeWeight(1);
    circle(0,0,raio + largura);
    // borda interior
    stroke(0,0,0);
    strokeWeight(3);
    circle(0,0,raio - largura);
    // preenchimento
    stroke(200,100,5);
    strokeWeight(10);
    arc(0, 0, raio, raio, 0, 360);
  }


}