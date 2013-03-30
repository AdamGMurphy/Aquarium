attribute vec4 Position;
atribute vec4 SourceColor;

varying vec4 DestinationColor;

void main(void) {
    DestinationColor = SourceColor;
    gl_Position = Position;
}