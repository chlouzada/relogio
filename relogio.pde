// Ajuste Tempo
int sensibilidade = 20;

// Corpo do Relogio
int raioCorpo = 220;
int larguraCorpo = 15;
color corBorda = color(5,100,5);
color corCentro = color(255,255,255);

// Ponteiro Hora
float tamanhoHr = 50;
float larguraHr = 5;
float offsetHr = 0;
color corHr = color(0,0,0);

// Ponteiro Minuto
float tamanhoMin = 90;
float larguraMin = 4;
float offsetMin = 5;
color corMin = color(0,0,0);

// Ponteiro Segundo
float tamanhoSeg = 95;
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

float atrasoSeg;
float atrasoHr;
float atrasoMin;

float anguloHr;
float anguloMin;
float anguloSeg;
float radHr;
float radMin;
float radSeg;

// ???
float minAjuste;
float radHrAux;

// int xAux = 0;
// int yAux = 0;

// if (keyPressed && key=='1'){  
//     xAux = mouseX - width/2;
//     yAux = mouseY - height/2;
// }
// translate(-200,-200);
// text(xAux, 0,0);
// translate(0,50);
// text(yAux, 0,0);


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

  minAjuste = 0;
  radHrAux = 0; 
}

void draw() { 
  background(150);
  translate(400, 400);
  noFill();

  // ================ // 
  // Corpo do Relogio // 
  // ================ //
  // // Coroa
  push();
  translate((raioCorpo+larguraCorpo)/2,0);
  stroke(0,0,0);
  strokeWeight(4);
  line(0,0,7,0);
  if (ajusteCoroa == false) {
    translate(6,5);
    strokeWeight(10);
    line(0,0,0,-10);
  } else {
    translate(12,5);
    strokeWeight(10);
    line(0,0,0,-10);
  }
  pop();

  // // Estrutura Coroa
  push();
  translate((raioCorpo+larguraCorpo)/2,0);
  fill(corBorda);
  triangle(-12, -50, -10, -12, 10, -12);
  triangle(-12, 50, 10, 12, -10, 12);
  pop();

  // // Estrutura Pulseira
  push();
  translate(0,(raioCorpo+larguraCorpo)/2);
  fill(corBorda);
  beginShape();
    vertex(40, -40);
    vertex(55, -20);
    vertex(50, 20);
    vertex(33, 22);
  endShape(CLOSE);
  beginShape();
    vertex(-55, -20);
    vertex(-40, -40);
    vertex(-33, 22);
    vertex(-50, 20);
  endShape(CLOSE);
  pop();

  push();
  translate(0,-(raioCorpo+larguraCorpo)/2);
  fill(corBorda);
  beginShape();
    vertex(33, -22);
    vertex(50, -20);
    vertex(55, 20);
    vertex(40,40);
  endShape(CLOSE);
  beginShape();
    vertex(-50, -20);
    vertex(-33, -22);
    vertex(-40,40);
    vertex(-55, 20);
  endShape(CLOSE);
  
  
  pop();
  
  

  



  // Centro
  // Preenchimento
  push();
  noStroke();
  fill(corBorda);
  circle(0,0,raioCorpo+larguraCorpo);
  fill(corCentro);
  circle(0,0,raioCorpo-larguraCorpo);
  pop();
  // Borda Exterior
  push();
  stroke(0,0,0);
  strokeWeight(1);
  circle(0,0,raioCorpo + larguraCorpo);
  pop();
  // // Borda Interior
  push();
  stroke(0,0,0);
  strokeWeight(3);
  circle(0,0,raioCorpo - larguraCorpo);
  pop();

  // // Pulseira
  // push();
  // translate(-100,-120);
  // fill(0,0,0);
  // beginShape();
  // vertex(80, 60);
  // quadraticVertex(80, 60, 80, 30);
  // bezierVertex(60, 30, 40, 50, 20, 60);
  // endShape(CLOSE);
  // pop();

  



  // ==================== //
  // Marcações do Relogio //
  // ==================== //
  push();
  for (int i = 0, n = 12; i < n; i++) {
    int limite = (raioCorpo - larguraCorpo) / 2;

    int endLine = limite - 6 ; 
    int tamG = 20;
    int tamM = 12;
    int tamP = 5;


    strokeWeight(2.3);
    stroke(100, 100, 100);
    // Alterna Traço Grande e Médio
    line(0, (i % 2 == 0) ? endLine - tamM : endLine - tamG , 0, endLine);
    // Traço Minutos
    for (int j = 0; j < 4; j++) {
      rotate(radians(6));
      line(0, endLine - tamP, 0, endLine);
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
  anguloMin = map(minute() + norm(second(), 0, 60), 0, 60, 0, 360) - map(atrasoMin, 0, 60, 0, 360) - 90;
  if (ajusteCoroa == false) { 
    radMin = radians(anguloMin);
  } else { // Ajuste Ativado
    // Conta Tempo Parado
    if(min != minAnterior) {
      println("aaa");
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
      // println(atrasoSeg);
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
      atrasoSeg++;
      radSeg-= radians(map(1, 0, 60, 0, 360));
      
      // // Atualiza Minuto
      // atrasoMin += 1/60;
      // radMin -= radians(map(norm(atrasoSeg, 0, 60), 0, 60, 0, 6));
      // minAjuste -= map(norm(atrasoSeg, 0, 60), 0, 60, 0, 6);
      // if (anguloSeg % 360 ==  - 84 || anguloSeg % 360 == 264){
      //   radMin-= radians(map(1, 0, 60, 0, 360));
      //   atrasoMin++;
      // }
        
    }
    if (mouseStart.y + sensibilidade < mouseEnd.y) {
      mouseStart.set(mouseX, mouseY);
      atrasoSeg--;
      radSeg += radians(map(1, 0, 60, 0, 360));
      
      // Atualiza Minuto
      // atrasoMin -= 1/60;
      // radMin += radians(map(norm(atrasoSeg, 0, 60), 0, 60, 0, 6));
      // minAjuste += map(norm(atrasoSeg, 0, 60), 0, 60, 0, 6);
      // if (anguloSeg % 360 ==  - 84 || anguloSeg % 360 == 264){
      //   radMin+= radians(map(1, 0, 60, 0, 360));
      //   atrasoMin--;
      // }
    }
  }
}
