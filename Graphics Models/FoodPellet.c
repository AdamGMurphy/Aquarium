#include <stdlib.h>
#include <GL/glut.h>
#include <math.h>
#include <stdio.h>

#define ROTATION_INC 2.0
#define CAMERA_INC 0.25

GLfloat ww;
GLfloat wh;

int width = 500;
int height = 500;

float xRotation = 0.0;
float yRotation = 0.0;
float zRotation = 0.0;
float cameraDistance = -5.0;

float pelletRotation = 0.0;

typedef struct Color
{
	float red;
	float green;
	float blue;
	float alpha;	
} Color;

Color brown = {0.855, 0.647, 0.125, 1.0};

void changeColor(Color color) {
	glColor4f(color.red, color.green, color.blue, color.alpha);
}

void pellet(double speed) {
	if (pelletRotation > 360.0)
		pelletRotation = 0;
	pelletRotation += speed;

	changeColor(brown);

	glPushMatrix();
	glRotatef(pelletRotation, 0.0, 1.0, 0.0);
	glRotatef(60.0, 1.0, 0.0, 0.0);
	glScalef(0.5, 0.5, 2.0);
	glTranslatef(0.0, 0.0, -0.5);

	GLUquadric *quadObj = gluNewQuadric();
	gluCylinder(quadObj, 1.0, 1.0, 1.0, 20, 20);
	gluDisk(quadObj, 0.0, 1.0, 20, 20);
	glPushMatrix();
	glTranslatef(0.0, 0.0, 1.0);
	gluDisk(quadObj, 0.0, 1.0, 20, 20);
	glPopMatrix();
	
	glPopMatrix();
}

void drawPellet(double size, double xPos, double yPos, double speed) {
	glPushMatrix();
	glTranslatef(xPos, yPos, 0.0);
	glScalef(size, size, size);
	pellet(speed);
	glPushMatrix();
}






void keyboard_callback(unsigned char key, int x, int y) {
	if (key == 'W' | key == 'w') {
		xRotation += ROTATION_INC;
		if (xRotation > 360.0)
			xRotation -= 360.0;
	}
	if (key == 'S' | key == 's') {
		xRotation -= ROTATION_INC;
		if (xRotation > 360)
			xRotation += 360;
	}
	if (key == 'A' | key == 'a') {
		yRotation += ROTATION_INC;
		if (yRotation > 360.0)
			yRotation -= 360.0;
	}
	if (key == 'D' | key == 'd') {
		yRotation -= ROTATION_INC;
		if (yRotation > 360)
			yRotation += 360;
	}
	if (key == 'Q' | key == 'q') {
		zRotation += ROTATION_INC;
		if (zRotation > 360.0)
			zRotation -= 360.0;	
	}
	if (key == 'E' | key == 'e') {
		zRotation -= ROTATION_INC;
		if (zRotation > 360)
			zRotation += 360;
	}
	if (key == 'Z' | key == 'z') {
		cameraDistance += CAMERA_INC;
	}
	if (key == 'X' | key == 'x') {
		cameraDistance -= CAMERA_INC;
	}
}

void display(void) {
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	gluPerspective(60.0, (GLfloat) ww/(GLfloat) wh, 0.01, 20.0);
	
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
	
	glPushMatrix();
	glTranslatef(0.0, 0.0, cameraDistance);
	glRotatef(xRotation, 1.0, 0.0, 0.0);
	glRotatef(yRotation, 0.0, 1.0, 0.0);
	glRotatef(zRotation, 0.0, 0.0, 1.0);
	
	drawPellet(0.1, 1.0, 0.5, 0.3);
	
	glPopMatrix();

	glFlush();
	glutSwapBuffers();
	glutPostRedisplay();
}

void myReshape(int w, int h) {
	ww = w;
	wh = h;
	glViewport(0, 0, w, h);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
}

void initLights() {
	GLfloat ambient[] = {0.2, 0.2, 0.2, 1.0};
	GLfloat position[] = {0.0, 2.0, 1.0, 0.0};

	glLightModeli(GL_LIGHT_MODEL_TWO_SIDE, GL_TRUE);
	glShadeModel(GL_SMOOTH);
	glEnable(GL_LIGHTING);
	glEnable(GL_LIGHT0);
	glEnable(GL_LIGHT1);
	
	glLightfv(GL_LIGHT1, GL_AMBIENT, ambient);
	glLightfv(GL_LIGHT0, GL_POSITION, position);	
}

void init(void) {
	glClearColor (0.0, 0.0, 0.0, 0.0);	
	
	glEnable(GL_DEPTH_TEST);
	glEnable(GL_MAP2_VERTEX_3);
	glEnable(GL_COLOR_MATERIAL);
	glEnable(GL_AUTO_NORMAL);
	glEnable(GL_NORMALIZE);
	glEnable(GL_BLEND);
//	glEnable(GL_CULL_FACE);
	
//	glCullFace(GL_BACK);
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
	glColorMaterial(GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE);
	
	glMapGrid2f(20, 0.0, 1.0, 20, 0.0, 1.0);
	
	initLights();
}

int main(int argc, char **argv) {
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);
	glutInitWindowSize(width, height);
	glutCreateWindow("Model Viewer");
	init();
	glutKeyboardFunc(keyboard_callback);
	glutReshapeFunc(myReshape);
	glutDisplayFunc(display);
	glutMainLoop();
	return 0;
}