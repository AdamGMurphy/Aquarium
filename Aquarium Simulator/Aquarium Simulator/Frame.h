//
//  Position.h
//  Aquarium Simulator
//
//  Created by Adam G Murphy on 2013-03-28.
//  Copyright (c) 2013 Adam G Murphy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Frame : NSObject

- (id) initWithxPos: (double) setXPos yPos: (double) setYPos width: (double) setWidth height: (double) setHeight;

- (void) setXPos: (double) setXPos;

- (void) setYPos: (double) setYPos;

- (void) setWidth: (double) setWidth;

- (void) setHeight: (double) setHeight;

- (double) xPos;

- (double) yPos;

- (double) width;

- (double) height;

- (Boolean) collidesWith: (Frame *) otherFrame;

- (Boolean) containedWithin: (Frame *) otherFrame;

@end
