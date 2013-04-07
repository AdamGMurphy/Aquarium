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
    float refreshRate;
}

//Initializes with the boundary of the screen.
- (id) initWithBoundary: (Frame *) setBoundary {
    self = [super init];
    
    boundary = setBoundary;
    refreshRate = 0.01;
    
    return self;
}

//Creates food with the given frame.
- (void) createFoodWithFrame: setFrame {
    frame = setFrame;
    foodTimer = [[NSTimer alloc] init];
    foodTimer = [NSTimer scheduledTimerWithTimeInterval: refreshRate target:self selector:@selector (timerFunction) userInfo:nil repeats:YES];
}

- (Frame *) foodFrame {
    return frame;
}

//Returns whether there is a piece of food on screen.
- (Boolean) isFood {
    return frame != nil;
}

//Destroys the food that is on screen.
- (void) destroyFood {
    [foodTimer invalidate];
    foodTimer = nil;
    frame = nil;
}

//Moves the food a distance modified by the refreshRate.
- (void) timerFunction {
    [frame setYPos: [frame yPos] + 15.0 * refreshRate];
    if ([boundary height] < [frame yPos]) {
        [self destroyFood];
    }
}




@end
