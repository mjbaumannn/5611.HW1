

static int numParticles = 10000;


float particleRadius = 50;
//Vec3 pos1[] = new Vec3[numParticles];
//Vec3 pos2[] = new Vec3[numParticles];
Vec3 pos3[] = new Vec3[numParticles];
//Vec3 pos4[] = new Vec3[numParticles];
//Vec3 pos5[] = new Vec3[numParticles];
//Vec3 pos6[] = new Vec3[numParticles];

//Vec3 vel1[] = new Vec3[numParticles];
//Vec3 vel2[] = new Vec3[numParticles];
Vec3 vel3[] = new Vec3[numParticles];
//Vec3 vel4[] = new Vec3[numParticles];
//Vec3 vel5[] = new Vec3[numParticles];
//Vec3 vel6[] = new Vec3[numParticles];

//Vec3 emitterPosition1 = new Vec3(500,0,0);
//Vec3 emitterPosition2 = new Vec3(-500,0,0);
Vec3 emitterPosition3 = new Vec3(0,500,0);
//Vec3 emitterPosition4 = new Vec3(0,-500,0);
//Vec3 emitterPosition5 = new Vec3(0,0,500);
//Vec3 emitterPosition6 = new Vec3(0,0,-500);

int currentParticles;

Camera camera;

float ct = 1/frameRate;
float genRate = 40;
Vec3 gravity = new Vec3(0,400,0);

void setup(){
    size(1000,1000,P3D);
    camera = new Camera();

   
}

void delete(int x){
    pos3[x] = pos3[currentParticles-1];
    vel3[x] = vel3[currentParticles-1];
    currentParticles-=1;
}

void update(float dt){
  float toGen_float = genRate * dt;
  int toGen = int(toGen_float);
  float fractPart = toGen_float - toGen;
  if (random(1) < fractPart) toGen += 1;
  for (int i = 0; i < toGen; i++){
    if (currentParticles >= numParticles){ break;}
    /*
    pos1[currentParticles] = new Vec3(emitterPosition1.x + random(5), emitterPosition1.y + random(5), emitterPosition1.z + random(5));
    vel1[currentParticles] = new Vec3((0 - emitterPosition1.x) + random(10), (0-emitterPosition1.y) + random(10), (0-emitterPosition1.y) + random(10));
    
    /*
    pos2[currentParticles] = new Vec3(emitterPosition2.x + random(5), emitterPosition2.y + random(5), emitterPosition2.z + random(5));
    vel2[currentParticles] = new Vec3((0 - emitterPosition2.x) + random(10), (0-emitterPosition2.y) + random(10), (0-emitterPosition2.y) + random(10));
    */

    pos3[currentParticles] = new Vec3(0, 500, 0);
    vel3[currentParticles] = new Vec3( 1000, -600 + random(50), random(50));
    
    /*
    pos4[currentParticles] = new Vec3(emitterPosition4.x + random(5), emitterPosition4.y + random(5), emitterPosition4.z + random(5));
    vel4[currentParticles] = new Vec3((0 - emitterPosition4.x)/5 + random(10), (0-emitterPosition4.y)/5 + random(10), (0-emitterPosition4.y)/5 + random(10));
    

    pos5[currentParticles] = new Vec3(emitterPosition5.x + random(5), emitterPosition5.y + random(5), emitterPosition5.z + random(5));
    vel5[currentParticles] = new Vec3((0 - emitterPosition5.x)/5 + random(10), (0-emitterPosition5.y)/5 + random(10), (0-emitterPosition5.y)/5 + random(10));


    pos6[currentParticles] = new Vec3(emitterPosition6.x + random(5), emitterPosition6.y + random(5), emitterPosition6.z + random(5));
    vel6[currentParticles] = new Vec3((0 - emitterPosition6.x)/5 + random(10), (0-emitterPosition6.y)/5 + random(10), (0-emitterPosition6.y)/5 + random(10));
    */
    
    currentParticles += 1;

    }

    for (int i = currentParticles-1 ; i >=0; i--){
    
    //Vec2 acc = gravity; //Gravity
    
    //pos1[i].add(vel1[i].times(dt)); //Update position based on velocity
    //pos2[i].add(vel2[i].times(dt));
    if(pos3[i].t > 100 * ct) delete(i);

    pos3[i].add(vel3[i].times(dt));
    vel3[i].add(gravity.times(dt));
    pos3[i].t += dt;
    /*pos4[i].add(vel4[i].times(dt));
    pos5[i].add(vel5[i].times(dt));
    pos6[i].add(vel6[i].times(dt));
    /* //vel[i].add(gravity.times(dt)); // Update velocity due to gravity (Step 7)

    
    /*if (pos[i].y > height - r){
      pos[i].y = height - r;
      vel[i].y *= -1;
    }
    if (pos[i].y < r){
      pos[i].y = r;
      vel[i].y *= -1;
    }
    if (pos[i].x > width - r){
      pos[i].x = width - r;
      vel[i].x *= -1;
    }
    if (pos[i].x < r){
      pos[i].x = r;
      vel[i].x *= -1;
    }
    */
    camera.theta += camera.turnSpeed * ( camera.negativeTurn.x + camera.positiveTurn.x)*dt;
    
    // cap the rotation about the X axis to be less than 90 degrees to avoid gimble lock
    float maxAngleInRadians = 85 * PI / 180;
    camera.phi = min( maxAngleInRadians, max( -maxAngleInRadians, camera.phi + camera.turnSpeed * ( camera.negativeTurn.y + camera.positiveTurn.y ) * dt ) );
    
    // re-orienting the angles to match the wikipedia formulas: https://en.wikipedia.org/wiki/Spherical_coordinate_system
    // except that their theta and phi are named opposite
    float t = camera.theta + PI / 2;
    float p = camera.phi + PI / 2;
    PVector forwardDir = new PVector( sin( p ) * cos( t ),   cos( p ),   -sin( p ) * sin ( t ) );
    PVector upDir      = new PVector( sin( camera.phi ) * cos( t ), cos( camera.phi ), -sin( t ) * sin( camera.phi ) );
    PVector rightDir   = new PVector( cos( camera.theta ), 0, -sin( camera.theta ) );
    PVector velocity   = new PVector( camera.negativeMovement.x + camera.positiveMovement.x, camera.negativeMovement.y + camera.positiveMovement.y, camera.negativeMovement.z + camera.positiveMovement.z );
    camera.position.add( PVector.mult( forwardDir, camera.moveSpeed * velocity.z * dt ) );
    camera.position.add( PVector.mult( upDir,      camera.moveSpeed * velocity.y * dt ) );
    camera.position.add( PVector.mult( rightDir,   camera.moveSpeed * velocity.x * dt ) );
    
    camera.aspectRatio = width / (float) height;
    perspective( camera.fovy, camera.aspectRatio, camera.nearPlane, camera.farPlane );
    camera( camera.position.x, camera.position.y, camera.position.z,
            camera.position.x + forwardDir.x, camera.position.y + forwardDir.y, camera.position.z + forwardDir.z,
            upDir.x, upDir.y, upDir.z );
    } 
}

void keyPressed()
{
  camera.HandleKeyPressed();
}

void keyReleased()
{
  camera.HandleKeyReleased();
}

void draw(){
  update(ct);
  
  background(0); //White background
  stroke(0,0,0);
  fill( 0, 255, 0 );
  pushMatrix();
  translate( 0, 520, 0 );
  box( 160 );
  popMatrix();
  fill(0,0,255);
  for (int i = 0; i < currentParticles; i++){
    /*pushMatrix();
    translate(pos1[i].x,pos1[i].y,pos1[i].z);
    sphere(particleRadius);
    popMatrix();
    /*
    pushMatrix();
    translate(pos2[i].x,pos2[i].y,pos2[i].z);
    sphere(particleRadius);
    popMatrix();
    */
    pushMatrix();
    translate(pos3[i].x,pos3[i].y,pos3[i].z);
    sphere(particleRadius);
    popMatrix();
  }/*
  for (int i = 0; i < currentParticles; i++){
    pushMatrix();
    translate(pos4[i].x,pos4[i].y,pos4[i].z);
    sphere(particleRadius);
    popMatrix();
  }
  for (int i = 0; i < currentParticles; i++){
    pushMatrix();
    translate(pos5[i].x,pos5[i].y,pos5[i].z);
    sphere(particleRadius);
    popMatrix();
  }
  for (int i = 0; i < currentParticles; i++){
    pushMatrix();
    translate(pos6[i].x,pos6[i].y,pos6[i].z);
    sphere(particleRadius);
    popMatrix();
  }
  */
}

