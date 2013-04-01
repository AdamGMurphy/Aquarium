//
//  FoodModel.m
//  Aquarium Simulator
//
//  Created by Adam G Murphy on 2013-04-01.
//  Copyright (c) 2013 Adam G Murphy. All rights reserved.
//

#import "FoodModel.h"
#import "Frame.h"

@implementation FoodModel {
    Frame *frame;
    Frame *boundary;
    NSTimer *foodTimer;
}

- (id) initWithBoundary: (Frame *) setBoundary {
    self = [super init];
    
    boundary = setBoundary;
    
    return self;
}

- (void) createFoodWithFrame: setFrame {
    frame = setFrame;
    foodTimer = [[NSTimer alloc] init];
    foodTimer = [NSTimer scheduledTimerWithTimeInterval: 0.1 target:self selector:@selector (timerFunction) userInfo:nil repeats:YES];
}

- (Frame *) foodFrame {
    return frame;
}

- (Boolean) isFood {
    return frame != nil;
}

- (void) destroyFood {
    [foodTimer invalidate];
    foodTimer = nil;
    frame = nil;
}

- (void) timerFunction {
    [frame setYPos: [frame yPos] - 0.5];
    if ([frame collidesWith:boundary]) {
        [self destroyFood];
    }
}




@end
