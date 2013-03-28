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
    Frame *currentPosition;
    id delegate;
}

- (id) initWithPosition: (Frame *) setPosition {
    self = [super init];
    
    currentPosition = setPosition;
    
    return self;
}

- (id) initWithPosition: (Frame *) setPosition delegate: setDelegate {
    self = [super init];
    
    currentPosition = setPosition;
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
