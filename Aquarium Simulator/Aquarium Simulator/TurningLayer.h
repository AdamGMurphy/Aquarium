//
//  TurningLayer.h
//  Aquarium Simulator
//
//  Created by Adam G Murphy on 2013-03-30.
//  Copyright (c) 2013 Adam G Murphy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TurningLayer : NSObject

- (id) initWithMaxHunger: (double) setMaxHunger turningModifier: (double) setTurningModifier;

- (void) resetMovementModifier;

- (void) incrememntMovementModifier: (double) increment;

- (double) activationWithHunger: (double) hunger;

@end
