//
//  Position.m
//  Aquarium Simulator
//
//  Created by Adam G Murphy on 2013-03-28.
//  Copyright (c) 2013 Adam G Murphy. All rights reserved.
//

/*
 This class holds the x position, y position, and angle (facing) of a fish.
 */


#import "Position.h"

@implementation Position {
    double xPos;
    double yPos;
    double angle;
}

- (id) initWithxPos: (double) setXPos yPos: (double) setYPos angle: (double) setAngle{
    self = [super init];
    
    xPos = setXPos;
    yPos = setYPos;
    angle = setAngle;
    
    return self;
}

- (id) initWithxPos: (double) setXPos yPos: (double) setYPos {
    self = [super init];
    
    xPos = setXPos;
    yPos = setYPos;
    angle = 0.0;
    
    return self;
}

- (void) setXPos: (double) setXPos {
    xPos = setXPos;
}

- (void) setYPos: (double) setYPos {
    yPos = setYPos;
}

- (void) setAngle: (double) setAngle {
    angle = setAngle;
}

- (double) xPos {
    return xPos;
}

- (double) yPos {
    return yPos;
}

- (double) angle {
    return angle;
}


@end
