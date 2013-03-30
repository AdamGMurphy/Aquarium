//
//  HungerLayer.h
//  Aquarium Simulator
//
//  Created by Adam G Murphy on 2013-03-30.
//  Copyright (c) 2013 Adam G Murphy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HungerLayer : NSObject

- (id) initWithMaxHunger: (double) setMaxHunger;

- (double) activationWithHunger: (double) hunger food: (Boolean) food;

@end
