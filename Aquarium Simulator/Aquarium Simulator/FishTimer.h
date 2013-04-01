//
//  FishTimer.h
//  Aquarium Simulator
//
//  Created by Adam G Murphy on 2013-04-01.
//  Copyright (c) 2013 Adam G Murphy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishDataModel.h"

@interface FishTimer : NSObject

- (id) initWithFishModel: (FishDataModel * )setFishModel;

- (void) hungerFunction;

- (void) saveFunction;

- (void) stopTimer;

@end
