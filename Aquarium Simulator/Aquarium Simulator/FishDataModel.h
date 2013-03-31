//
//  FishDataModel.h
//  Aquarium Simulator
//
//  Created by Adam G Murphy on 2013-03-28.
//  Copyright (c) 2013 Adam G Murphy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishMovementModel.h"
#import "FishColorModel.h"
#import "Frame.h"
#import "Position.h"

@interface FishDataModel : NSObject

- (id) initWithSize: (double) setSize movementModel: (FishMovementModel *) setMovementModel colorModel: (FishColorModel *) setColorModel maxHunger: (double) setMaxHunger currentHunger: (double) setHunger;

- (void) setDelegate: setDelegate;

- (id) delegate;

- (double) size;

- (void) setSize: (double) setSize;

- (void) incrementSize: (double) increment;

- (void) setAction: (int) setAction;

- (int) action;

- (double) maxHunger;

- (double) hunger;

- (double) facing;

- (Frame *) frame;

- (FishColorModel *) colorModel;

- (void) movementStopped;

- (void) turningStopped;

- (Boolean) moveToPosition: (Position *) position withSpeed: (double) speed;

- (void) turnAroundWithSpeed: (double) speed;

@end
