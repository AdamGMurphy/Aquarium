//
//  Position.h
//  Aquarium Simulator
//
//  Created by Adam G Murphy on 2013-03-28.
//  Copyright (c) 2013 Adam G Murphy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Position : NSObject

- (id) initWithX: (double) setX y: (double) setY;


- (void) setX: (double) setX;

- (void) setY: (double) setY;

- (double) x;

- (double) y;

@end
