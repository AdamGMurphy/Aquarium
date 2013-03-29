#import "FishDataModel.h"
#import "FishMovementModel.h"
#import "FishColorModel.h"
#import "Frame.h"
#import "Position.h"

@implementation FishDataModel {
	FishMovementModel *movementModel;
	FishColorModel *colorModel;
	double hunger;
	int currentAction;
	id delegate;
}

- (id) initWithMovementModel: (FishMovementModel *) setMovementModel colorModel: (FishColorModel *) setColorModel hunger: (double) setHunger {
	self = [super init];

	movementModel = setMovementModel;
	[movementModel setDelegate: self];
	colorModel = colorModel;
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

- (int) action {
	return action;
}

- (double) hunger {
	return hunger;
}

- (Frame *) frame {
	return [movementModel frame];
}

- (colorModel *) colorModel {
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