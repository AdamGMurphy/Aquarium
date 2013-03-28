//
//  FishColorModel.m
//  Aquarium Simulator
//
//  Created by Adam G Murphy on 2013-03-28.
//  Copyright (c) 2013 Adam G Murphy. All rights reserved.
//

/*
 This class acts like a container holding the colors of the fish.
 */



#import "FishColorModel.h"

@implementation FishColorModel {
    UIColor *finColor;
    UIColor *bodyColor;
    UIColor *eyeColor;
}

- (id) initWithFinColor: (UIColor *) setFinColor bodyColor: (UIColor *) setBodyColor eyeColor: (UIColor *) setEyeColor {
	self = [super init];
	
	finColor = setFinColor;
	bodyColor = setBodyColor;
	eyeColor = setEyeColor;
	
	return self;
}

- (void) setFinColor: (UIColor *) setFinColor {
	finColor = setFinColor;
}

- (void) setBodyColor: (UIColor *) setBodyColor {
	bodyColor = setBodyColor;
}

- (void) setEyeColor: (UIColor *) setEyeColor {
	eyeColor = setEyeColor;
}

- (UIColor *) finColor {
	return finColor;
}

- (UIColor *) bodyColor {
	return bodyColor;
}

- (UIColor *) eyeColor {
	return eyeColor;
}

@end
