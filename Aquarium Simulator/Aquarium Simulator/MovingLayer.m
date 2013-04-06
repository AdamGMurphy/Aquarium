//
//  MovingLayer.m
//  Aquarium Simulator
//
//  Created by Adam G Murphy on 2013-03-30.
//  Copyright (c) 2013 Adam G Murphy. All rights reserved.
//

#import "MovingLayer.h"
#import <stdlib.h>

@implementation MovingLayer {
	double maxHunger;
	double movementModifier;
}

- (id) initWithMaxHunger: (double) setMaxHunger movementModifier: (double) setMovementModifier {
	self = [super init];
    
    maxHunger = setMaxHunger;
	movementModifier = setMovementModifier;
    
    return self;
}

- (void) resetMovementModifier {
	movementModifier = 0.0;
}

- (void) decrementMovementModifier: (double) decrement {
	movementModifier -= decrement;
}

- (double) activationWithHunger: (double) hunger {
	double desire = hunger / maxHunger;
	double randomDesire = ((arc4random() % 60) - 30.0) / 100.0;
	double finalDesire = desire + randomDesire * ((0.5 - abs(desire - 0.5)) / 0.5) + movementModifier;
    
	return MIN(MAX(finalDesire, 0.0), 100.0);
}

@end
