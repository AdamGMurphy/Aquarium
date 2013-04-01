//
//  FishBehaviorController.m
//  Aquarium Simulator
//
//  Created by Adam G Murphy on 2013-03-30.
//  Copyright (c) 2013 Adam G Murphy. All rights reserved.
//

#import "FishDataModel.h"
#import "FishBehaviorController.h"
#import "FishMovementModel.h"
#import "FishColorModel.h"
#import "Frame.h"
#import "Position.h"

@implementation FishDataModel {
	FishMovementModel *movementModel;
	FishColorModel *colorModel;
    NSString *name;
    double maxHunger;
	double hunger;
	double size;
	int currentAction;
	id delegate;
}

- (id) initWithName: (NSString *) setName Size: (double) setSize movementModel: (FishMovementModel *) setMovementModel colorModel: (FishColorModel *) setColorModel maxHunger: (double) setMaxHunger currentHunger: (double) setHunger {
	self = [super init];
    
    name = setName;
	size = setSize;
	movementModel = setMovementModel;
	[movementModel setDelegate: self];
	colorModel = setColorModel;
    maxHunger = setMaxHunger;
	hunger = setHunger;
	currentAction = 0;
	/*
     Actions:
     0 - No action
     1 - Moving
     2 - Turning
     3 - Moving to food
     */
    
	return self;
}

- (NSString *) name {
    return name;
}

- (void) setDelegate: setDelegate {
	delegate = setDelegate;
}

- (id) delegate{
	return delegate;
}

- (double) size {
	return size;
}

- (void) setSize: (double) setSize {
	size = setSize;
}

- (void) incrementSize: (double) increment {
	size = log(pow(10, size) + increment);
}

- (void) setAction: (int) setAction {
    currentAction = setAction;
}

- (int) action {
	return currentAction;
}

- (double) maxHunger {
    return maxHunger;
}

- (double) hunger {
	return hunger;
}

- (double) facing {
    return [movementModel facing];
}

- (Frame *) frame {
	return [movementModel frame];
}

- (FishColorModel *) colorModel {
	return colorModel;
}

- (void) movementStopped {
	[delegate actionFinished];
}

- (void) turningStopped {
	[delegate actionFinished];
}

- (Boolean) moveToPosition: (Position *) position withSpeed: (double) speed {
	return [movementModel moveToPosition: position withSpeed: speed];
}

- (void) turnAroundWithSpeed: (double) speed {
	[movementModel turnAroundWithSpeed: speed];
}

@end