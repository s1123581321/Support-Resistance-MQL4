#property strict

/*
This code finds support/resistance levels using a method I devised based on a 4 period SMA
The code stores two levels at any point in time, the idea being to then build order decisions based off these levels

See the image "level_example.PNG" in the repository for an example of the levels the are found by this code

*/

//Variable to run code once a minute
int prev_min=Minute();

//Variables for the curretn high and low
double low=10;
double high=0;

//Moving average variable
double ma;

//Times that a value is written into a high/low
datetime h_time;
datetime l_time;

//Time until a high/low becomes a level (4 hours here)
datetime set=D'1970.01.01 04:00:00';

//Array of levels, two of them
double level[2]={0,0};

//Variable for the next entry index of the level array
int index=0;

void start(){
   
   //Runs at the start of each minute
   if(Minute()!=prev_min){
      prev_min=Minute();
      
      ma=iMA("EURUSD",1,4,0,0,6,0);

      //Setting new high/low if applicable and marking down their times
      if(ma>high){
         high=ma;
         h_time=TimeCurrent();
      }
      if(ma<low){
         low=ma;
         l_time=TimeCurrent();
      }
      
      //Setting support/resistance levels
      if(TimeCurrent()-h_time>set){
         level[index]=high;
         high=0;
         Print(level[0],level[1]);
         h_time=TimeCurrent();
         if(index==0){
            index=1;
         }else{
            index=0;
         }
      }
      if(TimeCurrent()-l_time>set){
         level[index]=low;
         low=10;
         l_time=TimeCurrent();
         Print(level[0],level[1]);
         if(index==0){
            index=1;
         }else{
            index=0;
         }
      }
   }
}
