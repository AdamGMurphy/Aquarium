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

- (id) initWithxPos: (double) setXPos yPos: (double) setYPos width: (double) setWidth height: (double) setHeight {
    self = [super init];
    
    xPos = setXPos;
    yPos = setYPos;
    width = setWidth;
    height = setHeight;

    return self;
}

- (void) setXPos: (double) setXPos {
    xPos = setXPos;
	NSLog([NSString stringWithFormat:@"%f", xPos]);
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

/*
 Checks to see if this frame overlaps another frame.
 @param otherFrame - the frame to compare this frame with.
 Return - true if the given frame overlaps this frame, false otherwise.
 */
- (Boolean) collidesWith: (Frame *) otherFrame {
/*
	NSLog(@"START");
	NSLog([NSString stringWithFormat:@"%f", xPos]);
	NSLog([NSString stringWithFormat:@"%f", width]);
	NSLog([NSString stringWithFormat:@"%f", yPos]);
	NSLog([NSString stringWithFormat:@"%f", height]);
	NSLog(@"---");
	NSLog([NSString stringWithFormat:@"%f", [otherFrame xPos]]);
	NSLog([NSString stringWithFormat:@"%f", [otherFrame width]]);
	NSLog([NSString stringWithFormat:@"%f", [otherFrame yPos]]);
	NSLog([NSString stringWithFormat:@"%f", [otherFrame height]]);
*/	
    if ((yPos - height < [otherFrame yPos] && yPos - height > [otherFrame yPos] - [otherFrame height]) || (yPos < [otherFrame yPos] && yPos < [otherFrame yPos] - [otherFrame height])){
        if (xPos - width < [otherFrame xPos] && xPos > [otherFrame xPos]){
			return true;
		}
		if (xPos > [otherFrame xPos] - [otherFrame width] && xPos - width < [otherFrame xPos] - [otherFrame width]) {
            return true;
        }
    }
	if ((xPos - width < [otherFrame xPos] && xPos - width > [otherFrame xPos] - [otherFrame width]) || (xPos < [otherFrame xPos] && xPos > [otherFrame xPos] - [otherFrame width])) {
		if (yPos - height < [otherFrame yPos] && yPos > [otherFrame yPos]){
			return true;
		}
		if (yPos > [otherFrame yPos] - [otherFrame height] && yPos - height < [otherFrame yPos] - [otherFrame height]) {
            return true;
        }
	}
	return false;
}

/*
 Checks to see if this frame is contained within another frame.
 @param otherFrame - the frame to compare this frame with
 Return - true if the given frame encapsulates this frame, false otherwise.
 */
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
