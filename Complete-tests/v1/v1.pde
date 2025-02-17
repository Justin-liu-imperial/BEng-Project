ArrayList<Puck> pucks = new ArrayList<Puck>();
ArrayList<Wire> wires = new ArrayList<Wire>();
ArrayList<Component> components = new ArrayList<Component>();
ArrayList<Zone> zones = new ArrayList<Zone>();
Runzone runzone;


boolean circuitRun = false;
boolean checked = false;
boolean updated = true;

//int puckSize = 100;
int puckSize;


void setup(){
  fullScreen();
  //size(900,600);
  //smooth();
  //pixelDensity(displayDensity());
  setuphough();
  puckSize = height/8;
  randomSeed(15);
  createComponents();
  createZones();
  addPucks(3);
  
  PFont font = loadFont("HelveticaNeue-20.vlw");
  textFont(font, 12);
  //textFont(font, 9);
}
void draw(){
  if (cam.available() == true){
    hough();
  }
  
  if(circuitRun){
    background(50);
  }else{
    background(255);
  }
  
  fill(0);
  textAlign(LEFT);
  text(frameRate,10,10);
  
  drawZones();
  
  //println(updated);
  for(Wire thiswire:wires){
    thiswire.display();
    thiswire.run();
  }
  
  
  if(updated){
    checkAuras(pucks);
  }
  
  for(Puck thispuck:pucks){
    thispuck.display();
    thispuck.run();
  }
  //for(Ring thisring:Rings){
  //  thisring.display(scalex, scaley , offx, offy, 50);
  //}
}

void addPucks(int num){
  for(int i = 1; i <= num; i++){
    pucks.add(new Puck(i, random(width),random(height),puckSize));
  }
}

void drawZones(){
  for(Zone thisz:zones){
    if(thisz.id == 2){
      runzone.display(color(128),true,color(255),true);
      runzone.run();
    }else{
      if(!circuitRun){
        thisz.display(color(128,100),true,color(255),true);
      }
    }
  }
  
}

void createComponents(){
  components.add(new Component(0, "Wire", "", 2, false, 1));
  components.add(new Component(1, "Resistor", "R", 2, 'Ω', 0, 4, -4, 1, 999, 1, true, 1));
  components.add(new Component(2, "Capacitor", "C", 2, 'F', 0, 4, -4, 1, 999, 1, true, 1));
  components.add(new Component(3, "Switch", "S", 2, false, 2));
  components.add(new Component(4, "Inductor", "L", 2, 'H', 0, 4, -4, 1, 999, 1, true, 1));
  components.add(new Component(5, "VoltageSource", "V", 2, 'V', 0, 4, -4, 1, 999, 1, true, 4));
  components.add(new Component(6, "Diode", "D", 2, false, 1));
}

void createZones(){
  zones.add(new Zone(0, "Component Selection", 0, width/4,height*0.9,width/2,height*0.2));
  zones.add(new Zone(1, "Component Value Change", 0, width*3/4,height*0.9,width/2,height*0.2));
  zones.add(new Runzone(2, "Start Simulation", 1, width - puckSize*0.7 , puckSize*0.7 ,puckSize*1.1,puckSize*1.1));
  runzone = (Runzone) zones.get(2);
}
