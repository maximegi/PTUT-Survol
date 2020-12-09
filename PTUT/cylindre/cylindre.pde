void setup()
{
    size(600, 600, P3D);
    lights();
    fill(100, 200, 0);
}

void draw()
{
    background(255);

    pushMatrix();
    translate(width/2,height/2);
    rotateY(PI/3);
    drawCylinder( 30, 100, 300 );
    popMatrix();

}

void drawCylinder( int sides, float r, float h)
{
    PVector[][] tab = new PVector[sides+1][sides+1];
    float angle = 360 / sides;

    // draw sides
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < sides + 1; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float y = sin( radians( i * angle ) ) * r;
        vertex( x, y, h/2);
        vertex( x, y, -h/2);
    }
    endShape(CLOSE);
    // for (int i = 0; i < sides + 1; i++) {
    //   for(int j = 0; j < sides + 1; j++)
    //   {
    //     float x = cos( radians( i * angle ) ) * r;
    //     float y = sin( radians( i * angle ) ) * r;
    //     tab[i][j] = new PVector(x,y,0);
    //   }
    // }
    //
    // for (int i = 0; i < sides + 1; i++) {
    //   beginShape(TRIANGLE_STRIP);
    //   for(int j = 0; j < sides; j++)
    //   {
    //     PVector v1 = tab[i][j];
    //     PVector v2  =tab[i][j+1];
    //     vertex(v1.x, v1.y, -h/2 + (j*h)/sides);
    //     vertex(v2.x, v2.y, -h/2 + ((j+1)*h)/sides);
    //   }
      endShape();
    //}


}
