#import "MovingLayer.h"
#import <stdlib.h>

@implementation MovingLayer {
	double maxHunger;
	double movementModifier;
}

- (id) initWithMaxHunger: (double) setMaxHunger movementModifier: (double) setMovementModifier {
	maxHunger = setMaxHunger;
	movementModifier = setMovementModifier;
}

- (double) resetMovementModifier {
	movementModifier = 0.0;
}

- (double) decrementMovementModifier: (double) decrement {
	movementModifier -= decrement;
}

- (double) activationWithHunger: (double) hunger {
	double desire = abs(hunger - maxHunger) / maxHunger;
	double randomDesire = (double) (arc4Random() % 60) - 30.0;
	double finalDesire = desire + randomDesire * ((0.5 - abs(desire - 0.5)) / 0.5) + movementModifier;

	return min(max(finalDesire, 100.0), 0.0);
}

@end