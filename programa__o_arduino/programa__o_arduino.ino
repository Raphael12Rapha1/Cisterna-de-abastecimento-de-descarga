// variaveis valor sensor
float cm,duracao; 

// pino rele
byte pinoRele = 2;

// pinos sensor
byte pinoTransmissor= 4; 
byte pinoReceptor= 8; 

// valor lido no serial
String valor;

void setup()
{
  // pino rele
  pinMode(pinoRele,OUTPUT);

  // pino sensor
  pinMode(pinoTransmissor, OUTPUT); 
  pinMode(pinoReceptor, INPUT);

  // rele inicia desligado
  digitalWrite(pinoRele, HIGH);

  // Iniciando comunicação serial
  Serial.begin(9600);
}

void loop(){
  // distancia em centímetros
  cm =  distancia(); 

  /*
  no rele, para acionar, usamos o LOW
  ao invez do HIGH
  */

  // se valor >= 8, ele permace no mesmo estado
  if(cm >= 8){
    digitalWrite(pinoRele, HIGH);

  // se valor < 8, ele aciona o rele
  } else{
    digitalWrite(pinoRele, LOW);
  }

  /*
  printando o valor
  no serial para
  o processing
  */
  Serial.println(cm);

  /*
  Definindo delau para n sobrecarregar 
  o buffer no processing 
  */
  delay(100);
}

// coletando distancia
float distancia(){
  // configurações para sensor de distancia
  
  digitalWrite(pinoTransmissor, LOW);
  delayMicroseconds(5); 
  digitalWrite(pinoTransmissor, HIGH); 
  delayMicroseconds(10);
  digitalWrite(pinoTransmissor, LOW);
  
  duracao = pulseIn(pinoReceptor, HIGH);

  float calcDistancia= (duracao/2) * 0.0343; 
  if (calcDistancia>=331){ 
      calcDistancia=0;
  }

  // retorna o calculo de distancia em cm
  return calcDistancia;
}
