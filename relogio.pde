Ponteiro ponteiroSegundo,ponteiroMinuto,ponteiroHora;
Desenho desenho;
Corpo corpo;

int timer;

void setup (){
  size(800, 800);
  
  corpo = new Corpo();
  desenho = new Desenho();

  // Ponteiro: Tipo Tamanho, Largura, Offset, Cor  
  ponteiroHora = new Ponteiro('h',50,6,0,color(0,0,0));
  ponteiroMinuto = new Ponteiro('m',100,5,5,color(0,0,0));
  ponteiroSegundo = new Ponteiro('s',100,1.5,10,color(255,0,0));
}

void draw() { 
  background(200);
  translate(400, 400);
  noFill();

  desenho.update();

  corpo.update();
  
  ponteiroHora.update();
  ponteiroMinuto.update();
  ponteiroSegundo.update();
}

class Ponteiro {
  char tipo;
  float tamanho;
  float largura;
  float offset;
  color cor;

  float timer;
  float timerAnterior;
  float anguloAnterior = 0;
  float atraso = 0;
  float atraso2 = 0;
  float rad, radAnterior;

  Ponteiro(char s,float t, float l, float os, color c) { 
    tipo = s;
    tamanho = t;
    largura = l;
    offset = - os;
    cor = c;
  }

  void update() {
    float angulo = getAngulo();

    if (corpo.coroa == false) { 
      push();
      rad = radians(angulo);
      rotate(rad);
      strokeWeight(largura);
      stroke(cor);
      line(offset, 0, tamanho, 0);
      pop();
    } else { // ajuste tempo ativado
      // conta segundos parados
      if(timer != timerAnterior) {
        atraso++;
      }
      push();
      rotate(rad);
      strokeWeight(largura);
      stroke(cor);
      line(offset, 0, tamanho, 0);
      pop();
    }
    timerAnterior = timer;
  }

  float getAngulo(){
    float angulo;
    if (tipo == 's') {
      timer = second();
      angulo = map(timer, 0, 60, 0, 360) - 90 - map(atraso, 0, 60, 0, 360);
    } else if (tipo == 'm') {
      timer = minute();
      angulo = map(timer + norm(second(), 0, 60), 0, 60, 0, 360) - 90;
    } else {
      timer = hour();
      angulo = map(timer + norm(minute(), 0, 60), 0, 24, 0, 720) - 90;
    }
    return angulo;
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

  boolean coroa = false;

  void coroaToggle(){
    coroa = !coroa;
  }

  void update(){
    // pino
    push();
    translate((raio+largura)/2,0);
    stroke(0,0,0);
    strokeWeight(4);
    line(0,0,5,0);
    if (coroa == false) {
      translate(6,5);
      strokeWeight(10);
      line(0,0,0,-10);
    } else {
      translate(10,5);
      strokeWeight(10);
      line(0,0,0,-10);
    }
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

void mouseClicked() {
  int x = mouseX;
  int y = mouseY;

  int coroaX , coroaY;
  int coroaLargura = 1, coroaAltura;

  corpo.coroaToggle();
}