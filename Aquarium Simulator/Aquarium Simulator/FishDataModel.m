#import "FishDataModel.h"
#import "FishMovementModel.h"
#import "FishColorModel.h"
#import "Frame.h"
#import "Position.h"

@implementation FishDataModel {
	FishMovementModel *movementModel;
	FishColorModel *colorModel;
	double hunger;
	double size;
	int currentAction;
	id delegate;
}

- (id) initWithSize: (double) setSize movementModel: (FishMovementModel *) setMovementModel setColorModel: (FishColorModel *) setColorModel hunger: (double) setHunger {
	self = [super init];
    
	size = setSize;
	movementModel = setMovementModel;
	[movementModel setDelegate: self];
	colorModel = setColorModel;
	hunger = setHunger;
	currentAction = 0;
	/*
     Actions:
     0 - No action
     1 - Moving
     2 - Turning
     3 - Moving to food
     */
    
	return self;
}

- (void) setDelegate: setDelegate {
	delegate = setDelegate;
}

- (id) delegate{
	return delegate;
}

- (double) size {
	return size;
}

- (void) setSize: (double) setSize {
	size = setSize;
}

- (void) incrementSize: (double) increment {
	size = log(pow(10, size) + increment);
}

- (int) action {
	return currentAction;
}

- (double) hunger {
	return hunger;
}

- (Frame *) frame {
	return [movementModel frame];
}

- (FishColorModel *) colorModel {
	return colorModel;
}

- (void) movementStopped {
	[delegate movementStopped];
}

- (void) turningStopped {
	[delegate turningStopped];
}

- (void) moveToPosition: (Position *) position withSpeed: (double) speed {
	[movementModel moveToPosition: position withSpeed: speed];
}

- (void) turnAroundWithSpeed: (double) speed {
	[movementModel turnAroundWithSpeed: speed];
}

@end