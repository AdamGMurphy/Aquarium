//
//  Position.h
//  Aquarium Simulator
//
//  Created by Adam G Murphy on 2013-03-28.
//  Copyright (c) 2013 Adam G Murphy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Position : NSObject

- (id) initWithxPos: (double) setXPos yPos: (double) setYPos angle: (double) setAngle;

- (id) initWithxPos: (double) setXPos yPos: (double) setYPos;

- (void) setXPos: (double) setXPos;

- (void) setYPos: (double) setYPos;

- (void) setAngle: (double) setAngle;

- (double) xPos;

- (double) yPos;

- (double) angle;

@end
