import processing.serial.*;

// definindo porta serial
Serial port;

// variaveis para funcionamento
float valor;
String val;
float antigo;

// fonte do projeto
PFont textFont;

// funcionalidades iniciais do projeto
void setup() {
  size(500, 500);
  background(255);  

  // definindo porta do arduino
  port = new Serial(this, "COM4", 9600);
}

// função que se repete constantemente
void draw() { 
  background(15, 14, 19);  
  
  fill(17,47,55);
  square(25, 25, 450);
  
  fill(67,143,157);
  square(30, 30, 440);
  
  // le os valores printados no serial pelo arduino
  val = port.readStringUntil('\n');
    
  // filtra valores nulos
  if(val != null){
    
    // tenta converte-los para float se possivel
    try{
      valor = float(val);
    } catch(Exception e) {
      // definindo um valor padrão caso a conversão n seja possivel
      valor = 0;
    }
    
    // defindo valor para repetição caso o valor for nulo
    antigo = valor;
    
  } else {
    valor = antigo;
  }
  
  // fonte do projeto
  textFont = loadFont("Candara-Bold-48.vlw");
  textFont(textFont);
  
  fill(255);
  
  // se o valor for >= 10 a bomba liga
  if(valor <= 10){
    text("Bomba Ligada", width / 2 - textWidth("Bomba Ligada") / 2, 100);
   
  // se for > 10 a solenoide liga
  } else {
    text("Solenoide Ligada", width / 2 - textWidth("Solenoide Ligada") / 2, 100);
  }
  
  // definindo fonte para valor do sensor
  textFont = loadFont("Candara-Bold-20.vlw");
  textFont(textFont);
  
  // printando valor do sensor
  text("Valor do sensor", width / 2 - textWidth("Valor do sensor") / 2, 280);
  text(valor + " - cm", width / 2 - textWidth(nf(valor, 0, 1) + " - cm") / 2, 300);
}
