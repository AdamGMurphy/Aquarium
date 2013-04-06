//
//  TurningLayer.m
//  Aquarium Simulator
//
//  Created by Adam G Murphy on 2013-03-30.
//  Copyright (c) 2013 Adam G Murphy. All rights reserved.
//

#import "TurningLayer.h"
#import <stdlib.h>

@implementation TurningLayer {
	double maxHunger;
	double turningModifier;
}

- (id) initWithMaxHunger: (double) setMaxHunger turningModifier: (double) setTurningModifier {
	self = [super init];
    
    maxHunger = setMaxHunger;
	turningModifier = setTurningModifier;
    
    return self;
}

- (void) resetMovementModifier {
	turningModifier = 0.0;
}

- (void) incrememntMovementModifier: (double) increment {
	turningModifier += increment;
}

- (double) activationWithHunger: (double) hunger {
	double desire = (maxHunger / maxHunger) * 0.5;
	double randomDesire = ((arc4random() % 20) - 10.0) / 100.0;
	double finalDesire = desire + randomDesire * ((0.5 - abs(desire - 0.5)) / 0.5) + turningModifier;
    
	return MIN(MAX(finalDesire, 0.0), 100.0);
}

@end
