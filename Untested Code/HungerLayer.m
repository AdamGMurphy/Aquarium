#import "HungerLayer.h"
#import <stdlib.h>

@implementation HungerLayer 

- (double) activationWithHunger: (double) hunger food: (Boolean) food {
	if (!food || hunger >= 100.0) {
		return 0.0;
	}
	else if (hunger <= 2.0) {
		return 100.0
	}
	
	double randomDesire = (double) (arc4random() % 60) - 30.0;
	return (log(2) / log(hunger)) + randomDesire * (1 - (log(2) / log(hunger)));
}

@end