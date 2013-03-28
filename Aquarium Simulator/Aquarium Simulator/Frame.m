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


#import "Frame.h"

@implementation Frame {
    double xPos;
    double yPos;
    double width;
    double height;
}

- (id) initWithxPos: (double) setXPos yPos: (double) setYPos setWidth: (double) setWidth setHeight: (double) setHeight {
    self = [super init];
    
    xPos = setXPos;
    yPos = setYPos;
    width = setWidth;
    height = setHeight;

    return self;
}

- (void) setXPos: (double) setXPos {
    xPos = setXPos;
}

- (void) setYPos: (double) setYPos {
    yPos = setYPos;
}

- (void) setWidth: (double) setWidth {
    width = setWidth;
}

- (void) setHeight: (double) setHeight {
    height = setHeight;
}

- (double) xPos {
    return xPos;
}

- (double) yPos {
    return yPos;
}

- (double) width {
    return width;
}

- (double) height {
    return height;
}

- (Boolean) collidesWith: (Frame *) otherFrame {
    if (yPos + height > [otherFrame yPos] && yPos + height < [otherFrame yPos] + [otherFrame height] || yPos > [otherFrame yPos] && yPos < [otherFrame yPos] + [otherFrame height]){
        if (xPos + width > [otherFrame xPos] && xPos < [otherFrame xPos]){
			return true;
		}
		if (xPos > [otherFrame xPos] && xPos < [otherFrame xPos] + [otherFrame width]) {
            return true;
        }
    }
	if (xPos + width > [otherFrame xPos] && xPos + width < [otherFrame xPos] + [otherFrame width] || xPos > [otherFrame xPos] && xPos < [otherFrame xPos] + [otherFrame width]) {
		if (yPos + height > [otherFrame yPos] && yPos < [otherFrame yPos]){
			return true;
		}
		if (yPos > [otherFrame yPos] && yPos < [otherFrame yPos] + [otherFrame height]) {
            return true;
        }
	}
	return false;
}

- (Boolean) containedWithin: (Frame *) otherFrame {
	if (![self collidesWith: otherFrame]) {
		if ([otherFrame xPos] < xPos && [otherFrame yPos] < yPos){
			if ([otherFrame xPos] + [otherFrame width] > xPos + width && [otherFrame yPos] + [otherFrame height] > yPos + height){
				return true;
			}
		}
	}
	return false;
}


@end
