#import "HungerLayer.h"
#import <stdlib.h>

@implementation HungerLayer  {
	double maxHunger;
}

- (id) initWithMaxHunger: setMaxHunger {
	maxHunger = setMaxHunger;
}

- (double) activationWithHunger: (double) hunger food: (Boolean) food {
	if (!food || hunger >= maxHunger.0) {
		return 0.0;
	}
	else if (hunger <= 2.0) {
		return 1.0
	}
	
	double randomDesire = ((arc4random() % 60) - 30.0) / 100.0;
	return (log(2) / log(hunger)) + randomDesire * (1 - (log(2) / log(hunger)));
}

@end