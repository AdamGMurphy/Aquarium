//
//  AquariumController.h
//  Aquarium Simulator
//
//  Created by Adam G Murphy on 2013-03-30.
//  Copyright (c) 2013 Adam G Murphy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Frame.h"

@interface AquariumController : NSObject

- (id) initWithBoundary: (CGRect) rectBoundary;

- (NSMutableArray *) colorArray;

- (Frame *) frame;

- (double) size;

- (double) facing;

@end
