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
#import "AquariumController.h"

@implementation FishBehaviorController {
    FishDataModel *fishModel;
    Frame *boundary;
	HungerLayer *hungerLayer;
    TurningLayer *turningLayer;
    RestingLayer *restingLayer;
    MovingLayer *movingLayer;
	id delegate;
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

- (void) setDelegate: (id) newDelegate {
	delegate = newDelegate;
}

- (void) actionFinished {
	[self beginAction];
}

- (void) beginAction {
	int action = [self nextAction];

	if (action == 1) {
		float xPos = arc4random() % (int) ([boundary width] - [[fishModel frame] width]);
		float yPos = arc4random() % (int) ([boundary height] - [[fishModel frame] height]);
		
		Position *position = [[Position alloc] initWithX:xPos y:yPos];
		
		[fishModel setAction:1];
		Boolean moved = [fishModel moveToPosition:position withSpeed:50.0];

		if (!moved) {
			[movingLayer decrementMovementModifier:1.0];
			[turningLayer incrememntMovementModifier:1.0];
			[fishModel setAction: 0];
			[self beginAction];
			return;
		}
	}
	else if (action == 2) {
		[movingLayer resetMovementModifier];
		[turningLayer resetMovementModifier];
		[fishModel setAction: 2];
		[fishModel turnAroundWithSpeed: 1.0];
	}
	else if (action == 3) {
		[movingLayer resetMovementModifier];
		[turningLayer resetMovementModifier];
		[fishModel setAction: 3];
		[fishModel moveToFoodWithSpeed: 50.0];
	}
	else {
		[self beginAction];
		return;
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
	
	double hungerActivation = [hungerLayer activationWithHunger:[fishModel hunger] food:[delegate isFood]];
	if (hungerActivation > activationRequirement) {
		activationRequirement = hungerActivation;
		action = 3;
	}

	return action;
}

- (Boolean) isFood {
    return [delegate isFood];
}

- (Frame*) foodFrame {
    return [delegate foodFrame];
}

- (void) destroyFood {
	[delegate destroyFood];
}

@end
