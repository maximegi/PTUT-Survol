package test;

import processing.core.PApplet;


public class Test extends PApplet {
	
    // method for setting the size of the window
    public void settings(){
        size(500, 500);
    }

    // identical use to setup in Processing IDE except for size()
    public void setup(){
    	background(0);
    }

    // identical use to draw in Processing IDE
    public void draw(){
    	int d = 90;
		int p1 = d;
		int p2 = p1+d;
		int p3 = p2+d;
		
    	stroke(153);
    	line(p3, p3, p2, p3);
    	line(p2, p3, p2, p2);
    	line(p2, p2, p3, p2);
    	line(p3, p2, p3, p3);
    }
    
    // The argument passed to main must match the class name
	public static void main(String _args[]) {
		PApplet.main(new String[] { test.Test.class.getName() });
	}
	
}
