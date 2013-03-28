//
//  FishMovementModel.m
//  Aquarium Simulator
//
//  Created by Adam G Murphy on 2013-03-28.
//  Copyright (c) 2013 Adam G Murphy. All rights reserved.
//

#import "FishMovementModel.h"
#import "Frame.h"

@implementation FishMovementModel {
    double angle;
    Frame *currentFrame;
    id delegate;
}

- (id) initWithFrame: (Frame *) setFrame {
    self = [super init];
    
    currentFrame = setFrame;
    angle = 0.0;
    
    return self;
}

- (id) initWithFrame: (Frame *) setFrame angle: (double) setAngle{
    self = [super init];
    
    currentFrame = setFrame;
    angle = setAngle;
    
    return self;
}

- (id) initWithPosition: (Frame *) setFrame angle: (double) setAngle delegate: setDelegate {
    self = [super init];
    
    currentFrame = setFrame;
    angle = setAngle;
    delegate = setDelegate;
    
    return self;
}

- (void) setDelegate: (id) setDelegate {
    delegate = setDelegate;
}

- (id) delegate {
    return delegate;
}










@end
