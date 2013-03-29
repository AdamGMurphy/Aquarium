//
//  FishMovementModel.m
//  Aquarium Simulator
//
//  Created by Adam G Murphy on 2013-03-28.
//  Copyright (c) 2013 Adam G Murphy. All rights reserved.
//

#import "FishMovementModel.h"
#import "Frame.h"
#import "Position.h"

@implementation FishMovementModel {
    double angle;
    double refreshRate;
    Frame *currentFrame;
    Frame *boundary;
    Position *goalPosition;
    NSTimer *moveTimer;
    Boolean moving;
    double speed;
    id delegate;
}

- (id) initWithFrame: (Frame *) setFrame boundary: (Frame *) setBoundary{
    self = [super init];
    
    currentFrame = setFrame;
    boundary = setBoundary;
    angle = 0.0;
    moving = false;
    refreshRate = 0.1;
    
    return self;
}

- (id) initWithFrame: (Frame *) setFrame angle: (double) setAngle boundary: (Frame *) setBoundary {
    self = [super init];
    
    currentFrame = setFrame;
    boundary = setBoundary;
    angle = setAngle;
    moving = false;
    refreshRate = 0.1;
    
    return self;
}

- (id) initWithPosition: (Frame *) setFrame angle: (double) setAngle boundary: (Frame *) setBoundary delegate: setDelegate {
    self = [super init];
    
    currentFrame = setFrame;
    boundary = setBoundary;
    angle = setAngle;
    delegate = setDelegate;
    moving = false;
    refreshRate = 0.1;
    
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

- (void) stopMovement {
    if (moving) {
        [moveTimer invalidate];
        moveTimer = nil;
    }
    moving = false;
    goalPosition = nil;
    speed = 0.0;
//    [delegate movementStopped];
}

- (void) moveToGoal {
    if ([goalPosition x] < [currentFrame xPos] && angle < 1.0)
        [self stopMovement];
    if ([goalPosition x] > [currentFrame xPos] && angle > 1.0)
        [self stopMovement];
    
    double distanceToMove = speed * refreshRate;
//    double moveAngle = tan([currentFrame ]
    
}






@end
