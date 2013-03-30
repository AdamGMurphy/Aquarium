#import "TurningLayer.h"
#import <stdlib.h>

@implementation TurningLayer {
	double maxHunger;
	double movementModifier;
}

- (id) initWithMaxHunger: (double) setMaxHunger turningModifier: (double) setTurningModifier {
	maxHunger = setMaxHunger;
	turningModifier = setTurningModifier;
}

- (double) resetMovementModifier {
	movementModifier = 0.0;
}

- (double) incrememntMovementModifier: (double) increment {
	turningModifier += incrememnt;
}

- (double) activationWithHunger: (double) hunger {
	double desire = (abs(hunger - maxHunger) / maxHunger) * 0.5;
	double randomDesire = ((arc4Random() % 20) - 10.0) / 100.0;
	double finalDesire = desire + randomDesire * ((0.5 - abs(desire - 0.5)) / 0.5) + movementModifier;

	return min(max(finalDesire, 100.0), 0.0);
}

@end