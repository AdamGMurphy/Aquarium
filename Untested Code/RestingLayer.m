#import "RestingLayer.h"
#import <stdlib.h>

@implementation RestingLayer {
	double maxHunger;
}

- (id) initWithMaxHunger: (double) setMaxHunger {
	maxHunger = setMaxHunger;
}

- (double) activationWithHunger: (double) hunger food: (Boolean) food {
	if (food) {
		if (hunger == 100.0)
			return 0.0;
		desire = 1.0 - hunger / 100.0;
		randomDesire = ((arc4random() % 60) - 30.0) / 100.0;
		finalDesire = desire + randomDesire * (1 - desire);
	}
	else {
		desire = hunger / 100.0;
		randomDesire = ((arc4random() % 60) - 30.0) / 100.0;
		return desire + randomDires * (1 - desire);
	}
}

@end