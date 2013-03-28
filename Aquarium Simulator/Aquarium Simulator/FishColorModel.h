//
//  FishColorModel.h
//  Aquarium Simulator
//
//  Created by Adam G Murphy on 2013-03-28.
//  Copyright (c) 2013 Adam G Murphy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FishColorModel : NSObject

- (id) initWithFinColor: (UIColor *) setFinColor bodyColor: (UIColor *) setBodyColor eyeColor: (UIColor *) setEyeColor;

- (void) setFinColor: (UIColor *) setFinColor;

- (void) setBodyColor: (UIColor *) setBodyColor;

- (void) setEyeColor: (UIColor *) setEyeColor;

- (UIColor *) finColor;

- (UIColor *) bodyColor;

- (UIColor *) eyeColor;

@end
