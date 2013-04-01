//
//  FishBehaviorController.h
//  Aquarium Simulator
//
//  Created by Adam G Murphy on 2013-03-30.
//  Copyright (c) 2013 Adam G Murphy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Frame.h"
#import "Position.h"
#import "FishDataModel.h"
#import "HungerLayer.h"
#import "TurningLayer.h"
#import "RestingLayer.h"
#import "MovingLayer.h"

@interface FishBehaviorController : NSObject

- (id) initWithFishModel: (FishDataModel *) setFishModel boundary: (Frame *) setBoundary;

- (void) setDelegate: (id) newDelegate;

- (void) actionFinished;

- (void) beginAction;

- (int) nextAction;

- (Boolean) isFood;

- (Frame*) foodFrame;

- (void) destroyFood;

@end
