#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif
#define LEVELS 3
uniform sampler2D textureSampler;
uniform vec2 texcoordOffset;
uniform float activatorRadii[LEVELS];
uniform float inhibitorRadii[LEVELS];
uniform float smallAmount[LEVELS];
uniform float iterations;

varying vec4 vertColor;
varying vec4 vertTexcoord;
float grid(vec4 v){ //maps the red value of the texture to between -1 and 1
    return v.r*2.0-1.0;
}
vec4 unGrid(float g){ //maps the new value (which is most of the time between -1.4 and 1.4) to between -1 and 1
    return vec4(vec3(g+1.4)/2.8,1.0);
}
vec4 tex(float x, float y){ //simply gets the color of the texture at (x,y).
    return texture2D(textureSampler,vec2(x,y));
}
int constrained(float x, float y){ //makes checks to make certain that it is only using pixels on the texture
    if(x>=0.0&&x<=1.0&&y>=0.0&&y<=1.0)
        return 1;
    return 0;
}
void main(void) {
  vec4 pixelColor = texture2D(textureSampler,vertTexcoord.xy);
  vec2 c=vertTexcoord.xy;
  vec2 d=texcoordOffset;
  float activator[LEVELS];
  float inhibitor[LEVELS];
  float variations[LEVELS];
  int bestVariation=0;
  for(int i=0;i<LEVELS;i++){
    activator[i]=0.0;
    inhibitor[i]=0.0;
    float count=0.0;
    //these lines make activator[i] equal to the average value of the pixels in a radius of activatorRadii[i]
    for(float x=c.x-activatorRadii[i]*d.x;x<c.x+activatorRadii[i]*d.x;x+=d.x){
 for(float y=c.y-activatorRadii[i]*d.y;y<c.y+activatorRadii[i]*d.y;y+=d.y){
     if(constrained(x,y)==0){
 activator[i]+=grid(tex(x,y));
 count+=1.0;
     }
 }
    }
    activator[i]/=count;
    count=0.0;
    //these lines make inhibito[i] equal to the average value of the pixels in a radius of inhibitorRadii[i]
    for(float x=c.x-inhibitorRadii[i]*d.x;x<c.x+inhibitorRadii[i]*d.x;x+=d.x){
 for(float y=c.y-inhibitorRadii[i]*d.y;y<c.y+inhibitorRadii[i]*d.y;y+=d.y){
     if(constrained(x,y)==0){
 inhibitor[i]+=grid(tex(x,y));
 count+=1.0;
     }
 }
    }
    inhibitor[i]/=count;
    //these lines seek out the level of the turing pattern with the smallest difference between the activator and inhibitor
    variations[i]=abs(activator[i]-inhibitor[i]);
    if(variations[i]<variations[bestVariation])
 bestVariation=i;
  }
  float g=grid(tex(c.x,c.y));
  if(activator[bestVariation]>inhibitor[bestVariation])
    g+=smallAmount[bestVariation]/iterations;//dividing by iterations ensures that as time goes on, there will be less impact. This is how I adjusted to the difficulty of mapping the grid between -1 and 1 each time.
  else
    g-=smallAmount[bestVariation]/iterations;

  gl_FragColor = unGrid(g);
}

