void countShots(){
  for(int i=maxShots-1; i>=0; i--){
    if(Bullet[i]!=null){
      currentShots=i;
      i=-1;
    }
  }
}



