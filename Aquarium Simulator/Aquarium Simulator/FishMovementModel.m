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
    double facing;
	Frame *currentFrame;
    
    double refreshRate;
    Frame *boundary;
    Position *goalPosition;
    NSTimer *moveTimer;
    Boolean moving;
    Boolean movingToFood;
	Boolean turning;
    double speed;
    id delegate;
}

/*
 Initializes this fishMovementModel with a relative frame for a fish, the boundary frame of the phone's screen, and a refresh rate at which to update the fish's position.
 The facing of the fish is set to the right.
 
 setFrame the frame for the fish.
 setBoundary the frame for the phone screen.
 setRefreshRate the rate at which to update the position of the fish.
 */
- (id) initWithFrame: (Frame *) setFrame boundary: (Frame *) setBoundary refreshRate: (double) setRefreshRate {
    self = [super init];
    
    currentFrame = setFrame;
    boundary = setBoundary;
    facing = 1.0;
    moving = false;
    refreshRate = setRefreshRate;
    
    return self;
}

/*
 Initializes this fishMovementModel with a relative frame for a fish, the direction the fish is facing, the boundary frame of the phone's screen, and a refresh rate at which to update the fish's position.
 
 setFrame the frame for the fish.
 setFacing the direction the fishing is facing, 1.0 is right, -1.0 is left.
 setBoundary the frame for the phone screen.
 setRefreshRate the rate at which to update the position of the fish.
 */
- (id) initWithFrame: (Frame *) setFrame facing: (double) setFacing boundary: (Frame *) setBoundary refreshRate: (double) setRefreshRate {
    self = [super init];
    
    currentFrame = setFrame;
    boundary = setBoundary;
    facing = setFacing;
    moving = false;
    refreshRate = setRefreshRate;
    
    return self;
}

/*
 Initializes this fishMovementModel with a relative frame for a fish, the direction the fish is facing, the boundary frame of the phone's screen, and a refresh rate at which to update the fish's position.
 
 setFrame the frame for the fish.
 setFacing the direction the fishing is facing, 1.0 is right, -1.0 is left.
 setBoundary the frame for the phone screen.
 setRefreshRate the rate at which to update the position of the fish.
 setDelegate the delegate for this object.
 */
- (id) initWithPosition: (Frame *) setFrame facing: (double) setFacing boundary: (Frame *) setBoundary refreshRate: (double) setRefreshRate delegate: setDelegate {
    self = [super init];
    
    currentFrame = setFrame;
    boundary = setBoundary;
    facing = setFacing;
    delegate = setDelegate;
    moving = false;
    refreshRate = setRefreshRate;
    
    return self;
}

//Sets the delegate for this object.
- (void) setDelegate: (id) setDelegate {
    delegate = setDelegate;
}

//Returns the delegate for this object.
- (id) delegate {
    return delegate;
}

/*
 Instructs the fish to move towards the location of food.
 The location of food is found out by requesting its location from this object's delegate.
 */
- (void) moveToFoodWithSpeed:(double) setSpeed {
    moving = true;
    movingToFood = true;
    speed = setSpeed;
    
    //The position of the fish is updated according to refresh rate.
    moveTimer = [[NSTimer alloc] init];
    moveTimer = [NSTimer scheduledTimerWithTimeInterval: refreshRate target:self selector:@selector (moveToFood) userInfo:nil repeats:YES];
}

- (void) restForTime: (float) time {
    moveTimer = [[NSTimer alloc] init];
    moveTimer = [NSTimer scheduledTimerWithTimeInterval: time target:self selector:@selector (stopMovement) userInfo:nil repeats:NO];
    moving = true;
}

- (void) moveToFood {
    if (![delegate isFood]) {
        [self stopMovement];
        return;
    }
    
    Frame *foodFrame = [delegate foodFrame];

    if ([foodFrame containedWithin:currentFrame]){
        [delegate incrementSize:1.0];
        [delegate setHunger: [delegate hunger] + 10.0];
        [delegate destroyFood];
        
        [self stopMovement];
        return;
    }


    goalPosition = [[Position alloc] initWithX:[foodFrame xPos] - [currentFrame width] / 2 y:[foodFrame yPos] - [currentFrame height] / 2];

    
    if ([goalPosition x] < [currentFrame xPos] && facing == -1.0)
        [self turnAround];
    if ([goalPosition x] > [currentFrame xPos] && facing == 1.0)
        [self turnAround];
    
    [self moveToGoal];
}


- (Boolean) moveToPosition: (Position *) position withSpeed: (double) setSpeed{
    [self stopMovement];
    
    goalPosition = position;

    if ([goalPosition x] < 0.0 || [goalPosition y] < 0.0 || [goalPosition x] + [currentFrame width] > [boundary width] || [goalPosition y] + [currentFrame height] > [boundary height]) {
        return false;
    }
    
    if (([goalPosition x] < [currentFrame xPos] && facing == -1.0) || ([goalPosition x] > [currentFrame xPos] && facing == 1.0))
        return false;
    
    moveTimer = [[NSTimer alloc] init];
    moveTimer = [NSTimer scheduledTimerWithTimeInterval: refreshRate target:self selector:@selector (moveToGoal) userInfo:nil repeats:YES];
    moving = true;
    

    speed = setSpeed;
    return true;
}

- (void) turnAroundWithSpeed: (double) setSpeed {
	[self stopMovement];
		facing *= -1.0;
    [delegate turningStopped];
}

- (void) turnAround {
    facing *= -1.0;
}

- (void) stopMovement {
    if (moving) {
        [moveTimer invalidate];
        moveTimer = nil;
		moving = false;
        movingToFood = false;
		goalPosition = nil;
		speed = 0.0;
        [delegate movementStopped];
	}
}

- (void) moveToGoal {

    if (!movingToFood) {
        if ([goalPosition x] < [currentFrame xPos] && facing == -1.0){
            [self stopMovement];
            return;
        }
        if ([goalPosition x] > [currentFrame xPos] && facing == 1.0){
            [self stopMovement];
            return;
        }
        if ([goalPosition x] - [currentFrame xPos] == 0.0 && [goalPosition y] - [currentFrame yPos] == 0) {
            [self stopMovement];
            return;
        }
    }
    
    double distanceToMove = speed * refreshRate;
    double moveAngle = atan(fabs(([goalPosition y] - [currentFrame yPos]) / ([goalPosition x] - [currentFrame xPos])));
    
    double xMove = 0.0;
    double yMove = 0.0;
    
    if ([goalPosition y] == [currentFrame yPos]) {
        xMove = MIN(distanceToMove, [goalPosition x] - [currentFrame xPos]);
    }
    if ([goalPosition x] == [currentFrame xPos]){
        yMove = MIN(distanceToMove, [goalPosition y] - [currentFrame yPos]);
    }
    if (fabs([goalPosition x] - [currentFrame xPos]) != 0.0) {
        xMove = MIN(distanceToMove * cos(moveAngle) * ([goalPosition x] - [currentFrame xPos]) / fabs([goalPosition x] - [currentFrame xPos]), fabs([goalPosition x] - [currentFrame xPos]));
    }
    if (fabs([goalPosition y] - [currentFrame yPos]) != 0.0) {
        yMove = MIN(distanceToMove * sin(moveAngle) * ([goalPosition y] - [currentFrame yPos]) / fabs([goalPosition y] - [currentFrame yPos]), fabs([goalPosition y] - [currentFrame yPos]));
    }

	[currentFrame setXPos: [currentFrame xPos] + xMove];
	[currentFrame setYPos: [currentFrame yPos] + yMove];
     
	if ([currentFrame collidesWith: boundary]) {

		[currentFrame setXPos: [currentFrame xPos] - xMove];
		[currentFrame setYPos: [currentFrame yPos] - yMove];
		[self stopMovement];
        return;
	}
}

- (double) facing {
	return facing;
}

- (Frame *) frame {
	return currentFrame;
}

- (void) changeFrameSizeWithFishSize: (double) size {
    [currentFrame setHeight: 50 * size];
    [currentFrame setWidth: 60 * size];
}

@end
