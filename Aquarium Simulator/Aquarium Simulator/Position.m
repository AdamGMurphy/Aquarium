//
//  Position.m
//  Aquarium Simulator
//
//  Created by Adam G Murphy on 2013-03-28.
//  Copyright (c) 2013 Adam G Murphy. All rights reserved.
//

#import "Position.h"

@implementation Position {
    double x;
    double y;
}

- (id) initWithX: (double) setX y: (double) setY {
    self = [super init];
    
    x = setX;
    y = setY;
    
    return self;
}


- (void) setX: (double) setX {
    x = setX;
}

- (void) setY: (double) setY {
    y = setY;
}

- (double) x {
    return x;
}

- (double) y {
    return y;
}


@end
