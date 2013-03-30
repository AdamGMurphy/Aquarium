//
//  MovingLayer.h
//  Aquarium Simulator
//
//  Created by Adam G Murphy on 2013-03-30.
//  Copyright (c) 2013 Adam G Murphy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovingLayer : NSObject

- (id) initWithMaxHunger: (double) setMaxHunger movementModifier: (double) setMovementModifier;

- (void) resetMovementModifier;

- (void) decrementMovementModifier: (double) decrement;

- (double) activationWithHunger: (double) hunger;

@end
