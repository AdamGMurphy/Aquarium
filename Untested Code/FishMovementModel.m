//
//  FishMovementModel.m
//  Aquarium Simulator
//
//  Created by Adam G Murphy on 2013-03-28.
//  Copyright (c) 2013 Adam G Murphy. All rights reserved.
//

#import "FishMovementModel.h"
#import "FishDataModel.h"
#import "Frame.h"
#import "Position.h"

@implementation FishMovementModel {
    double angle;
	Frame *currentFrame;

    double refreshRate;
    Frame *boundary;
    Position *goalPosition;
    NSTimer *moveTimer;
    Boolean moving;
	Boolean turning;
    double speed;
    id delegate;
}

- (id) initWithFrame: (Frame *) setFrame boundary: (Frame *) setBoundary refreshRate: (double) setRefreshRate {
    self = [super init];
    
    currentFrame = setFrame;
    boundary = setBoundary;
    angle = 0.0;
    moving = false;
    refreshRate = setRefreshRate;
    
    return self;
}

- (id) initWithFrame: (Frame *) setFrame angle: (double) setAngle boundary: (Frame *) setBoundary refreshRate: (double) setRefreshRate {
    self = [super init];
    
    currentFrame = setFrame;
    boundary = setBoundary;
    angle = setAngle;
    moving = false;
    refreshRate = setRefreshRate;
    
    return self;
}

- (id) initWithPosition: (Frame *) setFrame angle: (double) setAngle boundary: (Frame *) setBoundary refreshRate: (double) setRefreshRate delegate: setDelegate {
    self = [super init];
    
    currentFrame = setFrame;
    boundary = setBoundary;
    angle = setAngle;
    delegate = setDelegate;
    moving = false;
    refreshRate = setRefreshRate;
    
    return self;
}

- (void) setDelegate: (id) setDelegate {
    delegate = setDelegate;
}

- (id) delegate {
    return delegate;
}

- (void) moveToPosition: (Position *) position withSpeed: (double) setSpeed{
    [self stopMovement];
    
    moveTimer = [[NSTimer alloc] init];
    moveTimer = [NSTimer scheduledTimerWithTimeInterval: refreshRate target:self selector:@selector (moveToGoal) userInfo:nil repeats:YES];
    moving = true;
    
    goalPosition = position;
    speed = setSpeed;
    moving = true;
    
}

- (void) turnAroundWithSpeed: (double) setSpeed {
	[self stopMovement];
	
	moveTimer = [[NSTimer aloc] init];
	moveTimer = [NSTimer scheduledTimerWithTimerInterval: refreshRate target:self selector@selector(turnAround) userInfo:nil repeats:YES];
	turning = true;
}

- (void) stopMovement {
    if (moving) {
        [moveTimer invalidate];
        moveTimer = nil;
		moving = false;
		goalPosition = nil;
		speed = 0.0;
//    [delegate movementStopped];
	}
}

- (void) stopTurning {
	if (turning) {
		[moveTimer invalidate];
		moveTimer = nil;
		turning = false;
		speed = 0.0;
//		[delegate turningStopped];
	}
}

- (void) moveToGoal {
    if ([goalPosition x] < [currentFrame xPos] && angle < 1.0)
        [self stopMovement];
    if ([goalPosition x] > [currentFrame xPos] && angle > 1.0)
        [self stopMovement];
    
    double distanceToMove = speed * refreshRate;
    double moveAngle = tan(abs(([goalPosition y] - [currentFrame yPos]) / ([goalPosition x] - [currentFrame xPos])));
	xMove = speed * cos(moveAngle) * ([goalPosition x] - [currentFrame xPos]) / abs([goalPosition x] - [currentFrame xPos]);
	yMove = speed * sin(moveAngle) * ([goalPosition y] - [currentFrame yPos]) / abs([goalPosition y] - [currentFrame yPos]);
	
	[currentFrame setXPos: [currentFrame xPos] + xMove];
	[currentFrame setYPos: [currentFrame yPos] + yMove];
    
	if ([currentFrame collidesWith: boundary]) {
		[currentFrame setXPos: [currentFrame xPos] - xMove];
		[currentFrame setYPos: [currentFrame yPox] - yMove];
		[self stopMovement];
	}
}

- (void) turnAround {
	angle += speed * refreshRate;
	
	if ((angle < 360.5 && angle > 359.5) || (angle < 180.5 && angle > 179.5)) {
		[self stopTurning];
	}
}

- (double) angle {
	return angle;
}

- (Frame *) frame {
	return currentFrame
}


@end
