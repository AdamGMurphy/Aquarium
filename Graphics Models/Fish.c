#include <stdlib.h>
#include <GL/glut.h>
#include <math.h>
#include <stdio.h>

#define ROTATION_INC 2.0
#define CAMERA_INC 0.25

#define INNER_TO_OUTER_EYE_RATIO 0.5

#define TRUNK_MAX_WIDTH 0.15
#define TRUNK_HEIGHT 0.15
#define PECTORAL_BASE_X -0.5
#define JAW_SPEED_MODIFIER 0.05

GLfloat ww;
GLfloat wh;

float xRotation = 0.0;
float yRotation = 0.0;
float zRotation = 0.0;
float cameraDistance = -5.0;

int width = 500;
int height = 500;

float pectoralRotation = 299.0;
float pectoralRotationDirection = 1.0;

float jawRotation = 0.5;
float jawRotationDirection = 1.0;

float caudalRotation = 0.0;

GLfloat trunkctrlpts[4][4][3] = {
	{{0.5, -TRUNK_HEIGHT * 0.5, 0.0}, {0.17, TRUNK_HEIGHT * 2.0/3.0, 0.0}, 						{-0.17, TRUNK_HEIGHT * 4.0/3.0, 0.0}, 				{-0.5, TRUNK_HEIGHT, 0.0}},
	{{0.5, -TRUNK_HEIGHT * 0.5, 0.0}, {0.17, TRUNK_HEIGHT * 0, TRUNK_MAX_WIDTH * 0.5}, 			{-0.17, TRUNK_HEIGHT * 2.0/3.0, TRUNK_MAX_WIDTH}, 	{-0.5, TRUNK_HEIGHT / 3, TRUNK_MAX_WIDTH}},
	{{0.5, -TRUNK_HEIGHT * 0.5, 0.0}, {0.17, -TRUNK_HEIGHT * 2.0/3.0, TRUNK_MAX_WIDTH * 0.5},	{-0.17, -TRUNK_HEIGHT * 2.0/3.0, TRUNK_MAX_WIDTH},	{-0.5, -TRUNK_HEIGHT / 3, TRUNK_MAX_WIDTH}},
	{{0.5, -TRUNK_HEIGHT * 0.5, 0.0}, {0.17, -TRUNK_HEIGHT * 4.0/3.0, 0.0}, 					{-0.17, -TRUNK_HEIGHT * 4.0/3.0, 0.0}, 				{-0.5, -TRUNK_HEIGHT, 0.0}}
};

GLfloat headctrlpts[4][4][3] = {
	{{0.4, 0.4, 0.0},		{0.17, 0.5, 0.0},		{-0.17, 0.25, 0.0},		{-0.5, -0.15, 0.0}},
	{{0.5, 0.175, 0.6},	{0.17, 0.175, 0.6},	{-0.17, 0.058, 0.6},	{-0.5, -0.15, 0.0}},
	{{0.75, -0.175, 0.3},	{0.17, -0.175, 0.3},	{-0.17, -0.058, 0.6},	{-0.5, -0.15, 0.0}},
	{{0.5, -0.5, 0.25},		{0.17, -0.5, 0.3},	{-0.17, -0.35, 0.6},	{-0.5, -0.15, 0.0}}
};

GLfloat jawctrlpts[4][4][3] = {
	{{0.5, 0.2, 0.25}, 		{0.17, 0.3, 0.25}, 		{-0.17, 0.0, 0.25}, 	{-0.5, 0.2, 0.0}},
	{{0.75, 0.07, 0.25}, 	{0.17, 0.07, 0.25}, 	{-0.17, 0.0, 0.25}, 	{-0.5, 0.2, 0.0}},
	{{0.75, -0.07, 0.25},	{0.17, -0.07, 0.25},	{-0.17, -0.07, 0.25}, 	{-0.5, 0.2, 0.0}},
	{{0.75, -0.1, 0.0}, 	{0.17, -0.1, 0.0}, 		{-0.17, -0.1, 0.0}, 	{-0.5, 0.2, 0.0}}
};

GLfloat dorsalctrlpts[4][4][3] = {
	{{0.45, 0.2, 0.0}, 	{0.17, 0.3, 0.0}, 	{-0.17, 0.3, 0.0}, 	{-0.45, 0.2, 0.0}},
	{{0.5, 0.1, 0.0}, 	{0.17, 0.1, 0.0}, 	{-0.17, 0.1, 0.0}, 	{-0.5, 0.1, 0.0}},
	{{0.5, 0.0, 0.0}, 	{0.17, 0.0, 0.0}, 	{-0.17, 0.0, 0.0}, 	{-0.5, 0.0, 0.0}},
	{{0.5, -0.1, 0.0}, 	{0.17, -0.1, 0.0}, 	{-0.17, -0.1, 0.0},	{-0.5, -0.1, 0.0}}
};

GLfloat pectoralctrlpts[4][4][3] = {
	{{0.17, 0.5, 0.0}, {0.17, 0.5, 0.0}, {-0.17, 0.5, 0.0}, {PECTORAL_BASE_X, 0.5, 0.0}},
	{{0.4, 0.17, 0.0}, {0.17, 0.17, 0.0}, {-0.17, 0.17, 0.0}, {PECTORAL_BASE_X, 0.17, 0.0}},
	{{0.7, -0.17, 0.0}, {0.17, -0.17, 0.0}, {-0.17, -0.17, 0.0}, {PECTORAL_BASE_X, -0.17, 0.0}},
	{{0.9, -0.17, 0.0}, {0.17, -0.5, 0.0}, {-0.17, -0.5, 0.0}, {-0.1, -0.5, 0.0}}
};

GLfloat pelvicctrlpts[4][4][3] = {
	{{0.2, 0.3, 0.0}, {0.0, 0.3, 0.0}, {-0.2, 0.3, 0.0}, {-0.5, 0.3, 0.0}},
	{{0.3, 0.1, 0.0}, {0.1, 0.1, 0.0}, {-0.1, 0.1, 0.0}, {-0.4, 0.1, 0.0}},
	{{0.5, -0.1, 0.0}, {0.2, -0.1, 0.0}, {-0.1, -0.1, 0.0}, {-0.3, -0.1, 0.0}},
	{{0.7, -0.3, 0.0}, {0.35, -0.3, 0.0}, {0.15, -0.3, 0.0}, {-0.1, -0.3, 0.0}}
};

GLfloat analctrlpts[4][4][3] = {
	{{0.1, 0.3, 0.0}, 	{0.0, 0.3, 0.0}, 	{-0.2, 0.3, 0.0}, 	{-0.4, 0.3, 0.0}},
	{{0.2, 0.1, 0.0}, 	{0.1, 0.1, 0.0}, 	{-0.1, 0.1, 0.0}, 	{-0.3, 0.1, 0.0}},
	{{0.3, -0.1, 0.0}, 	{0.2, -0.1, 0.0}, 	{-0.1, -0.1, 0.0}, 	{-0.2, -0.1, 0.0}},
	{{0.5, -0.3, 0.0}, 	{0.35, -0.3, 0.0}, 	{0.15, -0.3, 0.0}, 	{0.0, -0.3, 0.0}}
};

GLfloat caudalctrlpts[4][4][3] = {
	{{1.2, 0.5, 0.0}, {1.2, 0.5, 0.0}, {1.2, 0.5, 0.0}, {1.2, 0.5, 0.0}},
	{{0.4, 0.17, 0.0}, {0.17, 0.17, 0.0}, {-0.17, 0.17, 0.0}, {-0.5, 0.17, 0.0}},
	{{0.4, -0.17, 0.0}, {0.17, -0.17, 0.0}, {-0.17, -0.17, 0.0}, {-0.5, -0.17, 0.0}},
	{{0.4, -0.5, 0.0}, {0.2, -0.5, 0.0}, {-0.1, -0.5, 0.0}, {-0.4, -0.5, 0.0}}
};

typedef struct Color
{
	float red;
	float green;
	float blue;
	float alpha;	
} Color;

Color eyeColor = {1.0, 0.0, 0.0, 1.0};
Color white = {1.0, 1.0, 1.0, 1.0};

void changeColor(Color color) {
	glColor4f(color.red, color.green, color.blue, color.alpha);
}

/*

	@param side 1 if left eye, -1 if right eye.
*/
void eye(int side) {
	changeColor(eyeColor);
	glPushMatrix();
	glTranslatef(-0.6, 0.05, side * 0.1);
	glScalef(0.03, 0.03, 0.03);
	
	glFrontFace(GL_CCW);
	glutSolidSphere(1.0, 20, 20);
	glFrontFace(GL_CW);
	glPopMatrix();
}

void trunk() {
	glMap2f(GL_MAP2_VERTEX_3, 0, 1, 3, 4, 0, 1, 12, 4, &trunkctrlpts[0][0][0]);
	changeColor(white);
	glPushMatrix();
	glEvalMesh2(GL_FILL, 0, 20, 0, 20);
	glPopMatrix();

	
	glPushMatrix();
	glMap2f(GL_MAP2_VERTEX_3, 0, 1, 3, 4, 0, 1, 12, 4, &trunkctrlpts[0][0][0]);
	glScalef(1, 1, -1);
	glFrontFace(GL_CCW);
	glEvalMesh2(GL_FILL, 0, 20, 0, 20);
	glFrontFace(GL_CW);
	glPopMatrix();

}

void head() {
	glPushMatrix();
	glTranslatef(-0.6, 0.01, 0.0);
	glScalef(0.35, 0.35, 0.35);

	glMap2f(GL_MAP2_VERTEX_3, 0, 1, 3, 4, 0, 1, 12, 4, &headctrlpts[0][0][0]);
	changeColor(white);
	glEvalMesh2(GL_FILL, 0, 20, 0, 20);
	
	glPushMatrix();
	glScalef(1, 1, -1);
	glFrontFace(GL_CCW);
	glEvalMesh2(GL_FILL, 0, 20, 0, 20);
	glFrontFace(GL_CW);
	glPopMatrix();
	
	glPopMatrix();
}

void jaw(double speed) {	
	if (jawRotation >= 4.0 || jawRotation <= 0.0)
		jawRotationDirection *= -1.0;
	jawRotation += speed * jawRotationDirection * JAW_SPEED_MODIFIER;

	glPushMatrix();
	glTranslatef(-0.65, -0.15, 0.0);
	glScalef(0.2, 0.4, 0.4);

	glTranslatef(0.75, 0.0, 0.0);
	glRotatef(jawRotation, 0.0, 0.0, 1.0);
	glTranslatef(-0.75, 0.0, 0.0);
	
	glMap2f(GL_MAP2_VERTEX_3, 0, 1, 3, 4, 0, 1, 12, 4, &jawctrlpts[0][0][0]);
	changeColor(white);
	glEvalMesh2(GL_FILL, 0, 20, 0, 20);
	
	glPushMatrix();
	glScalef(1, 1, -1);
	glFrontFace(GL_CCW);
	glEvalMesh2(GL_FILL, 0, 20, 0, 20);
	glFrontFace(GL_CW);
	glPopMatrix();
	
	glPopMatrix();
}

void dorsal() {
	glMap2f(GL_MAP2_VERTEX_3, 0, 1, 3, 4, 0, 1, 12, 4, &dorsalctrlpts[0][0][0]);
	changeColor(white);
	
	glPushMatrix();
	glTranslatef(-0.1, 0.1, 0.0);
	glScalef(0.45, 0.45, 0.45);
	glRotatef(-10.0, 0.0, 0.0, 1.0);
	glEvalMesh2(GL_FILL, 0, 20, 0, 20);
	glPopMatrix();
}

/*
	@param side 1 if left side, -1 if right side.
*/
void pectoral(int side, int speed) {

	glMap2f(GL_MAP2_VERTEX_3, 0, 1, 3, 4, 0, 1, 12, 4, &pectoralctrlpts[0][0][0]);
	changeColor(white);

	if (side == -1) {
		if (pectoralRotation >= 300.0 || pectoralRotation <= 250.0)
			pectoralRotationDirection *= -1.0;
		pectoralRotation += speed * pectoralRotationDirection;
	}
	
	glPushMatrix();
	glTranslatef(-0.275, -0.1, side * 0.075);
	glScalef(0.1, 0.1, side * 0.1);
	glRotatef(pectoralRotation, 1.0, 0.0, 0.0);
	glTranslatef(1.0, -0.5, 0.0);

	if (side == -1)
		glFrontFace(GL_CCW);
	glEvalMesh2(GL_FILL, 0, 20, 0, 20);
	if (side == -1)
		glFrontFace(GL_CW);

	glPopMatrix();
}

void pelvic() {
	glMap2f(GL_MAP2_VERTEX_3, 0, 1, 3, 4, 0, 1, 12, 4, &pelvicctrlpts[0][0][0]);
	changeColor(white);
	glPushMatrix();
	glTranslatef(-0.2, -0.2, 0.0);
	glScalef(0.25, 0.2, 0.2);
	glEvalMesh2(GL_FILL, 0, 20, 0, 20);
	glPopMatrix();
}

void anal() {
	glMap2f(GL_MAP2_VERTEX_3, 0, 1, 3, 4, 0, 1, 12, 4, &analctrlpts[0][0][0]);
	changeColor(white);
	glPushMatrix();
	glTranslatef(0.05, -0.2, 0.0);
	glScalef(0.2, 0.2, 0.2);
	glEvalMesh2(GL_FILL, 0, 20, 0, 20);
	glPopMatrix();
}

void caudal(int speed) {

	
	if (caudalRotation > 360.0)
		caudalRotation = 0;
	caudalRotation += speed;
	
	glPushMatrix();
	glTranslatef(0.4, -0.05, 0.0);
	glScalef(0.5, 0.5, 0.5);
	
	glRotatef(caudalRotation, 1.0, 0.0, 0.0);


	glMap2f(GL_MAP2_VERTEX_3, 0, 1, 3, 4, 0, 1, 12, 4, &caudalctrlpts[0][0][0]);
	changeColor(white);
	glPushMatrix();
	glTranslatef(0.0, caudalctrlpts[0][3][1], 0);
	glEvalMesh2(GL_FILL, 0, 20, 0, 20);
	glPopMatrix();
	
	glPushMatrix();
	glTranslatef(0.0, -1 * caudalctrlpts[0][3][1], 0);
	glScalef(1, -1, 1);
	glFrontFace(GL_CCW);
	glEvalMesh2(GL_FILL, 0, 20, 0, 20);
	glFrontFace(GL_CW);
	glPopMatrix();
	
	glPopMatrix();

}

void drawFish(double size, double xPos, double yPos, double angle, double speed)
{
	glPushMatrix();
	glTranslatef(xPos, yPos, 0.0);
	glRotatef(angle, 0.0, 1.0, 0.0);
	glScalef(size, size, size);
	
	trunk();
	head();
	eye(1);
	eye(-1);
	jaw(speed);
	dorsal();	
	pectoral(1, speed);
	pectoral(-1, speed);
	pelvic();;
	anal();
	caudal(speed);

	glPopMatrix();
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
	
	drawFish(1.0, 0.0, 0.0, 0.0, 1.0);
	
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