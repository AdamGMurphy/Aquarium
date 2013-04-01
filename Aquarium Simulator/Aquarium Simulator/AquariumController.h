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

- (NSMutableArray *) colorArray;

- (Frame *) frame;

- (double) size;

- (double) facing;

@end
