float noise_value_x;
float noise_value_z;
float noise_value_y;

void setup()
{
  size(512, 512, P3D);
  frameRate(30);
  colorMode(HSB);
  noise_value_x = 0.5;
  noise_value_y = 1.0;
  noise_value_z = 1.5;
}

void draw()
{
  background(255);
  translate(width / 2, height / 2, 0);
  
  float angle = frameCount % 360;
  float camera_x = 800 * cos(radians(angle));
  float camera_z = 800 * sin(radians(angle));   
  camera(camera_x, 0, camera_z, 
         0, 0, 0, 
         0, 1, 0);

  branch(new PVector(200, 0, 0));
  branch(new PVector(-200, 0, 0));
  
  branch(new PVector(0, 200, 0));
  branch(new PVector(0, -200, 0));
  
  noise_value_x += 0.01;
  noise_value_y += 0.01;
  noise_value_z += 0.01;
  
  println(frameCount);
  saveFrame("screen-#####.png");
  if(frameCount > 1800)
  {
     exit();
  }
}

void branch(PVector l)
{
  stroke((frameCount + l.magSq()) % 255, 128, 128);
  strokeWeight(2.5);
  line(0, 0, 0, l.x, l.y, l.z);
  translate(l.x, l.y, l.z);
  
  l.mult(0.66);

  if(l.magSq() > 400)
  {
    float theta_y = radians(map(noise(noise_value_y), 0, 1, 0, 720));
    float theta_z = radians(map(noise(noise_value_z), 0, 1, 0, 720));
    
    pushMatrix();
    rotateY(theta_y);
    rotateZ(theta_z);
    branch(l.copy());
    popMatrix();
    
    pushMatrix();
    rotateY(-theta_y);
    rotateZ(theta_z);
    branch(l.copy());
    popMatrix();
    
    pushMatrix();
    rotateY(theta_y);
    rotateZ(-theta_z);
    branch(l.copy());
    popMatrix();
    
    pushMatrix();
    rotateY(-theta_y);
    rotateZ(-theta_z);
    branch(l.copy());
    popMatrix();
   
  }
  
  translate(-l.x, -l.y, -l.z);
}