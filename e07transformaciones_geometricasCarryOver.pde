/********************************************************
 *                                                       *
 *  19/04/2010                                           *
 *  TÉCNICAS GRAFICAS - Ejercicio :7                     *
 *          Transformaciones Geometricas: Carry Over     *
 *                                                       *
 *  Alejandro Riera Mainar                               *
 *  NºMat: 010381                                        *
 *  ariera@gmail.com                                     *
 *                                                       *
 ********************************************************/
float PI = 3.141592; //arcos(-1)
int SIZE = 500;
char DIRECCION = 'd';
PImage output, input;
int X,Y = 0;
float ALFA = 0;
int ZOOM = 1;
int TITLE_HEIGHT = 30;

void setup() {
  size(SIZE, SIZE+TITLE_HEIGHT + 100);
  colorMode(RGB);
  input  = loadImage("basketball_icon.gif");
  output = createImage(SIZE, SIZE, RGB);
  process(input, output);
  displayTitle();
  display_instructions(output.width, output.height);
}

void displayTitle(){
  textFont(createFont("Helvetica", 18));
  fill(color(0));
  text("Ejercicio 7: Transformaciones Geometricas, Carry-Over" , 10, 20);
}

void display_instructions(int base_width, int base_height){
  fill(color(0));
  textFont(createFont("Helvetica", 14));
  text("Controles:\n\t\t\t'+' y '-' escalan\n\t\t\t'z' y 'x' rotan\n\t\t\t'a', 's', 'd', 'w' transladan" , 10, base_height + TITLE_HEIGHT + 20);  
}


void draw() {

}

void process(PImage input, PImage output){

  input.loadPixels();
  output.loadPixels();

  mover(input, output);

  output.updatePixels();
  input.updatePixels();
  image(output,0,TITLE_HEIGHT);

}

void mover(PImage input, PImage output){
  int loc = 0;
  color c;
  int newx, newy = 0;

  for (int x = 0; x < output.width; x++) {
    for (int y = 0; y < output.height; y++ ) {
      loc = x + y*output.width;
      output.pixels[loc] = color(0);
    }
  }

  for (int x = 0; x < input.width; x++) {
    for (int y = 0; y < input.height; y++ ) {
      newx = (int)(ZOOM*cos(ALFA) * x - ZOOM*sin(ALFA) * y) +X;
      newy = (int)(ZOOM*sin(ALFA) * x + ZOOM*cos(ALFA) * y) +Y;
      loc = x + y*input.width;
      c = color(input.pixels[loc]);
      output.set(newx,newy,c);
    }
  }
}

void nuevaPosicion(char dir){
  switch(dir){ 
  case 'w':
    Y -= 10;
    break;
  case 's':
    Y += 10;
    break;
  case 'a':
    X -= 10;
    break;
  case 'd':
    X += 10;
    break;
  };
}


void keyPressed(){
  switch(key){ 
  case 'z':
    ALFA += PI/12;
    break;
  case 'x':
    ALFA -= PI/12;
    break;
  case '+':
    ZOOM += 1;
    break;
  case '-':
    ZOOM -= 1;
    break;    
  default:
    nuevaPosicion(key);
  };

  process(input, output);
}





