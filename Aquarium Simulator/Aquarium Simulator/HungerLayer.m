//
//  HungerLayer.m
//  Aquarium Simulator
//
//  Created by Adam G Murphy on 2013-03-30.
//  Copyright (c) 2013 Adam G Murphy. All rights reserved.
//

#import "HungerLayer.h"
#import <stdlib.h>

@implementation HungerLayer  {
	double maxHunger;
}

- (id) initWithMaxHunger: (double) setMaxHunger {
    self = [super init];
	
    maxHunger = setMaxHunger;

    return self;
}

- (double) activationWithHunger: (double) hunger food: (Boolean) food {
	if (!food || hunger >= maxHunger) {
		return 0.0;
	}
	else if (hunger <= 2.0) {
		return 1.0;
	}
	
	double randomDesire = ((arc4random() % 60) - 10.0) / 100.0;
	return (1 - hunger / 100.0) + randomDesire * (hunger / 100.0);
}

@end