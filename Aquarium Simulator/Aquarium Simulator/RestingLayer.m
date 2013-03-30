//
//  RestingLayer.m
//  Aquarium Simulator
//
//  Created by Adam G Murphy on 2013-03-30.
//  Copyright (c) 2013 Adam G Murphy. All rights reserved.
//

#import "RestingLayer.h"
#import <stdlib.h>

@implementation RestingLayer {
	double maxHunger;
}

- (id) initWithMaxHunger: (double) setMaxHunger {
	self = [super init];
    
    maxHunger = setMaxHunger;
    
    return self;
}

- (double) activationWithHunger: (double) hunger food: (Boolean) food {
	if (food) {
		if (hunger == 100.0)
			return 0.0;
		double desire = 1.0 - hunger / 100.0;
		double randomDesire = ((arc4random() % 60) - 30.0) / 100.0;
		double finalDesire = desire + randomDesire * (1 - desire);
        return MIN(MAX(finalDesire, 0.0), 100.0);
	}
	else {
		double desire = hunger / 100.0;
		double randomDesire = ((arc4random() % 60) - 30.0) / 100.0;
		double finalDesire = desire + randomDesire * (1 - desire);
        return MIN(MAX(finalDesire, 0.0), 100.0);
	}
}

@end
