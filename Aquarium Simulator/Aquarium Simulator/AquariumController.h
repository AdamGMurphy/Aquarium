//
//  AquariumController.h
//  Aquarium Simulator
//
//  Created by Adam G Murphy on 2013-03-30.
//  Copyright (c) 2013 Adam G Murphy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Frame.h"
#import "FishDataModel.h"

@interface AquariumController : NSObject

- (id) initWithFish: (FishDataModel *) setFishModel Boundary: (CGRect) rectBoundary;

- (Frame *) frame;

- (double) size;

- (double) facing;

- (NSMutableArray*) colorArray;

- (void) addFoodAtX: (double) x y: (double) y ;

- (Boolean) isFood;

- (Frame *) foodFrame;

@end
