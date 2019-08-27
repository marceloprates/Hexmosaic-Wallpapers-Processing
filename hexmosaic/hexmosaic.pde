
// Hexagons per column
int N;
// Horizontal and vertical noise scales
float nsi;
float nsj;
// Distance between two centers
float a;
// Hexagon radius
float r;

void setup()
{
    size(1920,1080);

    // Hexagons per column
    N = 20;
    // Horizontal and vertical noise scales
    nsi = 0.8;
    nsj = 0.8;
    // Distance between two centers
    a = width/N;
    // Hexagon radius
    r = width/(sqrt(3)*N);

    // Generate 10 red wallpapers
    for(int i = 0; i < 10; i++)
    {
        noiseSeed(i);
        draw_and_save(String.format("red-%d.png",i), color(255,0,0));
    }

    // Generate 10 blue wallpapers
    for(int i = 0; i < 10; i++)
    {
        noiseSeed(i);
        draw_and_save(String.format("blue-%d.png",i), color(50,50,255));
    }
}

void draw_and_save(String path, color background_color)
{
    background(background_color);
    fill(30);

    // Draw background (large hexagons)
    for(float i = 0; i < 3*N; i++)
    {
        for(float j = 0; j < 2*N; j++)
        {
            float n = 0.5 + 1*noise(nsi*i, nsi*j);
            
            if(n > 0.9)
            {
                stroke(255);noStroke();
                hexagon(0.5*a*(i%2) + j*a, sqrt(3)*a*i/2, n*r);
                draw_radii(0.5*a*(i%2) + j*a, sqrt(3)*a*i/2, n*r, int(random(2)));
            }            
        }
    }

    // Draw foreground (small hexagons)
    for(float i = 0; i < 3*N; i++)
    {
        for(float j = 0; j < 2*N; j++)
        {
            float n = 0.5 + 1*noise(nsi*i, nsj*j);
            fill(30);
            if(n < 1)
            {
                stroke(255);
                hexagon(0.5*a*(i%2) + j*a, sqrt(3)*a*i/2, n*r);
                draw_radii(0.5*a*(i%2) + j*a, sqrt(3)*a*i/2, n*r, int(random(2)));
            }
            
        }
    }

    saveFrame(path);
}

void hexagon(float x, float y, float r)
{
    beginShape(POLYGON);
        for(int i = 0; i <= 6; i++)
        {
            vertex(x+r*cos((i+1.0/2)*PI/3),y+r*sin((i+1.0/2)*PI/3));
        }
    endShape();
}

void draw_radii(float x, float y, float r, int o)
{
    for(int i = 0; i <= 6; i+=2)
    {
        line(x,y,x+r*cos((o+i+1.0/2)*PI/3),y+r*sin((o+i+1.0/2)*PI/3));
    }
}