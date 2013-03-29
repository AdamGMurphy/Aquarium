gcc -c -o FoodPellet.o FoodPellet.c -I"C:\Program Files\Common Files\MinGW\GLUT\include"
gcc -o FoodPellet.exe FoodPellet.o -L"C:\Program Files\Common Files\MinGW\GLUT\lib" -lglut32 -lopengl32 -lglu32