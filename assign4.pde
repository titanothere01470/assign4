final int GAME_START= 0 , GAME_RUN = 1 , GAME_LOSE = 2;
final int count = 5;
int x = 0;
int enemyX = 0;
int enemyY = floor(random(0,250));
int treasureX = floor(random(0,600)); 
int treasureY = floor(random(0,450));
int energyZ = 40;
int num = 4;
int spacingX = 2*width/count;
int spacingY = 2*height/count;
int shipX = 580;
int shipY = 240;
int bulletX = shipX;
int speed = 3;
PImage background1;
PImage background2;
PImage hp;
PImage treasure;
PImage start1;
PImage start2;
PImage end1;
PImage end2;
PImage []enemies = new PImage[count];
PImage []ship = new PImage[1];
PImage []bullets = new PImage[count];
boolean upPressed = false; 
boolean downPressed = false; 
boolean rightPressed = false; 
boolean leftPressed = false; 
boolean space = false;
int gameState;


void setup () {
	size(640, 480) ;
  background1 = loadImage("img/bg1.png");
  background2 = loadImage("img/bg2.png");
  hp = loadImage("img/hp.png");
  treasure = loadImage("img/treasure.png");
  start1= loadImage("img/start2.png");
  start2= loadImage("img/start1.png");
  end1= loadImage("img/end1.png");
  end2= loadImage("img/end2.png");
  gameState =  GAME_START;
  ship[0] = loadImage("img/fighter.png");
  for(int i=0;i<count;i ++){
    enemies[i] = loadImage("img/enemy.png");
   }
  for(int i=0;i<count;i ++){
    bullets[i] = loadImage("img/shoot.png");
   }
   
}

void draw()
{
  switch(gameState){
    case GAME_START:
      image (start1,0,0);
      if( mouseX>200 && mouseX<460 && mouseY>358 && mouseY<415  ){
        image (start2,0,0);
        if(mousePressed){
          gameState = GAME_RUN;
        }
      }
      break;
    case GAME_RUN:
      //background
      image (background1,x,0);
      image (background2,x-640,0);
      image (background1,x-1280,0);
      x ++;
      x%=1280;
 
      // blood           
      stroke(255,0,0);
      fill(255,0,0);
      rect(10,13,energyZ,25);
      image (hp,5,10); 
  
  //ship
  image(ship[0],shipX,shipY);
  if(upPressed){
        shipY += -speed;            
      }
      if(downPressed){
        shipY += speed;        
      }
      if(rightPressed){
        shipX += speed;
      }
      if(leftPressed){
        shipX += -speed;
      }
     
     // boundry detection
     if(shipY  < 5){              // ship Y boundry detection
          shipY  = 5;
      }  
      if(shipY > height-55){       // ship Y boundry detection
          shipY = height-55;
      }
      if(shipX > width-50){        // ship X boundry detection
          shipX = width-50;
      }  
      if(shipX < 5){              // ship X boundry detection
          shipX = 5;
      }     
  //treasure
      image (treasure,treasureX,treasureY);
    if(shipX < treasureX+55 && shipX > treasureX-40 && shipY < treasureY+40 && shipY > treasureY-35 ){
        energyZ += 20;
        treasureX = floor(random(0,600));   
        treasureY =floor(random(0,450));
        if(energyZ>200){
          energyZ = 200;
        }
    }
  //shoot
   if(key == ' '){
   for(int i=0;i<count;i ++){
      image(bullets[i],bulletX-(i+1)*spacingX,shipY+10);
      bulletX -= 2;
   }
  
  
  }
  //enemy
  // 1st
  for(int i=0;i<count;i ++){
    image(enemies[i],enemyX+i*spacingX,enemyY);
    
    if( shipX < enemyX+i*spacingX+55 && shipX > enemyX+i*spacingX-40 && shipY < enemyY+40 && shipY > enemyY-35 ){
     /*enemies[i] = loadImage();*/
      energyZ -= 40;
     
    } 
  }    
    
  //2nd
  for(int i=0;i<count;i ++){
    image(enemies[i],enemyX-i*spacingX-650,enemyY+i*spacingY);
    if( shipX < enemyX-i*spacingX+55 && shipX > enemyX-i*spacingX-40 && shipY < enemyY+i*spacingY+40 && shipY >enemyY+i*spacingY-35 ){
     /*enemies[i] = loadImage();*/
      energyZ -= 40;
     
    } 
  }
  
  //3rd
  for(int i = 0;i<count;i++){
    if(i>2){
      image (enemies[i],enemyX+i*spacingX-1650,enemyY+(4-i)*spacingY);
    }else{
      image (enemies[i],enemyX+i*spacingX-1650,enemyY+i*spacingY); 
    }
    if( (shipX < enemyX+i*spacingX+55 && shipX > enemyX+i*spacingX-40 && shipY < enemyY+(4-i)*spacingY+40 && shipY > enemyY+(4-i)*spacingY-35) || (shipX < enemyX+i*spacingX+55 && shipX > enemyX+i*spacingX-40 && shipY < enemyY+i*spacingY+40 && shipY > enemyY+i*spacingY-35) ){
     /*enemies[i] = loadImage();*/
      energyZ -= 40;
     
    }    
  }

  for(int i = 0;i<count;i++){
    if(i>2){
      image (enemies[i],enemyX+i*spacingX-1650,enemyY-(4-i)*spacingY);
    }else{
      image (enemies[i],enemyX+i*spacingX-1650,enemyY-i*spacingY); 
    }
     if( (shipX < enemyX+i*spacingX+55 && shipX > enemyX+i*spacingX-40 && shipY < enemyY-(4-i)*spacingY+40 && shipY > enemyY-(4-i)*spacingY-35) || (shipX < enemyX+i*spacingX+55 && shipX > enemyX+i*spacingX-40 && shipY < enemyY-i*spacingY+40 && shipY > enemyY-i*spacingY-35) ){
     /*enemies[i] = loadImage();*/
      energyZ -= 40;
     
    } 
  }

  enemyX += 3;
  enemyX %=2300;
  }
  
   
}


void keyPressed(){
  if(key == CODED){ 
    switch(keyCode){
      case UP:
        upPressed = true;        
        break;
      case DOWN:
        downPressed = true;        
        break;
      case RIGHT:
        rightPressed = true;        
        break;
      case LEFT:
        leftPressed = true;        
        break;      
      case ' ':
        space = true;
        break;
    } 
  }

    
}

void keyReleased(){
  if(key == CODED){
    switch(keyCode){
      case UP:
        upPressed = false;
        break;
      case DOWN:
        downPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case ' ':
        space = false;
        break;
    } 
  }
}    
