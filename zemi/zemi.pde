Board board;
team team;
void setup(){
  surface.setSize(1200,700);
  board = new Board();
  team = new team();
  background(255);
}

void draw(){
  team.teampage();
  board.updateSelectArea();
  board.updateCommentArea("Choose Your Hand");
  
}

void mouseReleased(){
  if(mouseX>=50 && mouseX<=150 && mouseY>=50 && mouseY<=130){
  }
}