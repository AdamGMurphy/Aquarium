gcc -c -o Fish.o Fish.c -I"C:\Program Files\Common Files\MinGW\GLUT\include"
gcc -o Fish.exe Fish.o -L"C:\Program Files\Common Files\MinGW\GLUT\lib" -lglut32 -lopengl32 -lglu32