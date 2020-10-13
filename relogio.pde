// Ajuste Tempo
int sensibilidade = 30;

// Corpo do Relogio
int raioCorpo = 220;
int larguraCorpo = 10;
color corBordaInterior = color(5,100,5);

// Ponteiro Hora
float tamanhoHr = 50;
float larguraHr = 4.5;
float offsetHr = 0;
color corHr = color(0,0,0);

// Ponteiro Minuto
float tamanhoMin = 95;
float larguraMin = 3;
float offsetMin = 5;
color corMin = color(0,0,0);

// Ponteiro Segundo
float tamanhoSeg = 100;
float larguraSeg = 1.5;
float offsetSeg = 10;
color corSeg = color(255,0,0);

// ==================== //
// Var de funcionamento //
// ==================== //
boolean ajusteCoroa;

boolean mouseP;
PVector mouseStart;
PVector mouseEnd;

float seg;
float min;
float hr;
float segAnterior;
float minAnterior;
float hrAnterior;

int atrasoSeg;
int atrasoHr;
int atrasoMin;

float anguloHr;
float anguloMin;
float anguloSeg;
float radHr;
float radMin;
float radSeg;

void setup (){
  size(800, 800);
  
  ajusteCoroa = false;
  mouseP = false;
  mouseStart = new PVector(0, 0);
  mouseEnd = new PVector(0, 0);
  atrasoSeg = 0;
  atrasoHr = 0;
  atrasoMin = 0;
  radHr = -1;
  radMin = -1;
  radSeg = -1;
  anguloHr = 0;
  anguloMin = 0;
  anguloSeg = 0;
}

void draw() { 
  background(200);
  translate(400, 400);
  noFill();

  // ================ // 
  // Corpo do Relogio // 
  // ================ //
  // // Pino
  push();
  translate((raioCorpo+larguraCorpo)/2,0);
  stroke(0,0,0);
  strokeWeight(4);
  line(0,0,5,0);
  if (ajusteCoroa == false) {
    translate(6,5);
    strokeWeight(10);
    line(0,0,0,-10);
  } else {
    translate(10,5);
    strokeWeight(10);
    line(0,0,0,-10);
  }
  pop();
  // // Borda Exterior
  push();
  stroke(0,0,0);
  strokeWeight(1);
  circle(0,0,raioCorpo + larguraCorpo);
  // // Borda Interior
  stroke(0,0,0);
  strokeWeight(3);
  circle(0,0,raioCorpo - larguraCorpo);
  // // Preenchimento Borda
  stroke(corBordaInterior);
  strokeWeight(larguraCorpo);
  arc(0, 0, raioCorpo, raioCorpo, 0, 360);
  pop();

  // ==================== //
  // Marcações do Relogio //
  // ==================== //
  push();
  for (int i = 0, n = 12; i < n; i++) {
    strokeWeight(2.3);
    stroke(100, 100, 100);
    // Alterna Traço Grande e Médio
    line(0, (i % 2 == 0) ? 75 : 85 , 0, 100);
    // Traço Minutos
    for (int j = 0; j < 4; j++) {
      rotate(radians(6));
      line(0, 97, 0, 100);
    }
    rotate(radians(6));
  }
  pop();

  // ============= //
  // Ponteiro Hora //
  // ============= //
  anguloHr = map(hour() + norm(minute(), 0, 60), 0, 24, 0, 720) - 90;
  if (ajusteCoroa == false) { 
    radHr = radians(anguloHr);
  } else { // Ajuste Ativado
    // Conta Tempo Parado
    if(hr != hrAnterior) {
      atrasoHr++;
    }
  }
  hrAnterior = hr;
  updatePonteiro(radHr,tamanhoHr,larguraHr,offsetHr,corHr);
  
  // =============== //
  // Ponteiro Minuto //
  // =============== //
  anguloMin = map(minute() + norm(second(), 0, 60), 0, 60, 0, 360) - 90;
  if (ajusteCoroa == false) { 
    radMin = radians(anguloMin);
  } else { // Ajuste Ativado
    // Conta Tempo Parado
    if(min != minAnterior) {
      atrasoMin++;
    }
  }
  minAnterior = min;
  updatePonteiro(radMin,tamanhoMin,larguraMin,offsetMin,corMin);


  // ================ //
  // Ponteiro Segundo //
  // ================ //
  seg = second();
  anguloSeg = map(seg, 0, 60, 0, 360) - map(atrasoSeg, 0, 60, 0, 360) - 90;
  if (ajusteCoroa == false) { 
    radSeg = radians(anguloSeg);
  } else { // Ajuste Ativado
    // Conta Tempo Parado
    if(seg != segAnterior) {
      atrasoSeg++;
      println(atrasoSeg);
    }
  }
  segAnterior = seg;
  updatePonteiro(radSeg,tamanhoSeg,larguraSeg,offsetSeg,corSeg);
}

void updatePonteiro(float rad, float tam,float larg, float offset, color cor) {
  push();
  rotate(rad);
  strokeWeight(larg);
  stroke(cor);
  line(-offset, 0, tam, 0);
  pop();
}

void mouseClicked() {
  if (mouseButton == LEFT)
    ajusteCoroa = !ajusteCoroa;
  else
    setup();
}

void mousePressed() {
  mouseStart.set(mouseX, mouseY);
  mouseEnd.set(mouseX, mouseY);
  mouseP = true;
}

void mouseReleased() {
  mouseP = false;
}

void mouseDragged() {
  if (ajusteCoroa == true) {
    mouseEnd.set(mouseX, mouseY);
    if (mouseStart.y - mouseEnd.y > sensibilidade) {
      mouseStart.set(mouseX, mouseY);
      radSeg-= radians(map(1, 0, 60, 0, 360));
      atrasoSeg++;
      println("up");
    }
    if (mouseStart.y + sensibilidade < mouseEnd.y) {
      mouseStart.set(mouseX, mouseY);
      radSeg+= radians(map(1, 0, 60, 0, 360));
      atrasoSeg--;
      println("down");
    }
  }
}

