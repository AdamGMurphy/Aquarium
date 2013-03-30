//
//  FishBehaviorController.m
//  Aquarium Simulator
//
//  Created by Adam G Murphy on 2013-03-30.
//  Copyright (c) 2013 Adam G Murphy. All rights reserved.
//

#import "FishBehaviorController.h"
#import "Frame.h"
#import "Position.h"
#import "FishDataModel.h"
#import "HungerLayer.h"
#import "TurningLayer.h"
#import "RestingLayer.h"
#import "MovingLayer.h"

@implementation FishBehaviorController {
    FishDataModel *fishModel;
    Frame *boundary;
	HungerLayer *hungerLayer;
    TurningLayer *turningLayer;
    RestingLayer *restingLayer;
    MovingLayer *movingLayer;
}

- (id) initWithFishModel: (FishDataModel *) setFishModel boundary: (Frame *) setBoundary{
    self = [super init];
    
    fishModel = setFishModel;
	[fishModel setDelegate:self];
    boundary = setBoundary;
    hungerLayer = [[HungerLayer alloc] initWithMaxHunger:[fishModel maxHunger]];
    restingLayer = [[RestingLayer alloc] initWithMaxHunger:[fishModel maxHunger]];
    turningLayer = [[TurningLayer alloc] initWithMaxHunger:[fishModel maxHunger] turningModifier:0.0];
    movingLayer = [[MovingLayer alloc] initWithMaxHunger:[fishModel maxHunger] movementModifier:0.0];
    
    return self;
}

- (void) actionFinished {
	[self beginAction];
}

- (void) beginAction {
	double action = [self nextAction];
	
	if (action == 1) {
		int xPos = arc4random() % (int) ([boundary width] - [[fishModel frame] width]);
		int yPos = arc4random() % (int) ([boundary height] - [[fishModel frame] height]);
		
		Position *position = [[Position alloc] initWithX:xPos y:yPos];
		
		[fishModel setAction:1];
		Boolean moved = [fishModel moveToPosition:position withSpeed:1.0];
		if (!moved) {
			[fishModel setAction: 0];
			[self beginAction];
			return;
		}
	}
	else if (action == 2) {
		[fishModel setAction: 2];
		[fishModel turnAroundWithSpeed: 1.0];
	}
}

- (int) nextAction {
    int action = 0;
	double activationRequirement = 0.0;
	
	double movingActivation = [movingLayer activationWithHunger: [fishModel hunger]];
	if (movingActivation > activationRequirement) {
		activationRequirement = movingActivation;
		action = 1;
	}
	
	double turningActivation = [turningLayer activationWithHunger: [fishModel hunger]];
	if (turningActivation > activationRequirement) {
		activationRequirement = turningActivation;
		action = 2;
	}

	return action;
}





@end
