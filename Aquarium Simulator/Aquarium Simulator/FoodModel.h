//
//  FoodModel.h
//  Aquarium Simulator
//
//  Created by Adam G Murphy on 2013-04-01.
//  Copyright (c) 2013 Adam G Murphy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Frame.h"

@interface FoodModel : NSObject

- (id) initWithBoundary: (Frame *) setBoundary;

- (void) createFoodWithFrame: setFrame;

- (Frame *) getFoodFrame;

- (Boolean) isFood;

- (void) destroyFood;

- (void) timerFunction;

@end
