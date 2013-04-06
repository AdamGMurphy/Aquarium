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

/*
 Initializes the color model with a set of colors.
 setFinColor the given UIColor for fish fins.
 setBodyColor the given UIColor for the fish body.
 setEyeColor the given UIColor for fish eyes.
 */
- (id) initWithFinColor: (UIColor *) setFinColor bodyColor: (UIColor *) setBodyColor eyeColor: (UIColor *) setEyeColor {
	self = [super init];
	
	finColor = setFinColor;
	bodyColor = setBodyColor;
	eyeColor = setEyeColor;
	
	return self;
}

//Sets finColor to setFinColor.
- (void) setFinColor: (UIColor *) setFinColor {
	finColor = setFinColor;
}

//Sets bodyColor to setBodyColor.
- (void) setBodyColor: (UIColor *) setBodyColor {
	bodyColor = setBodyColor;
}

//Sets eyeColor to setEyeColor.
- (void) setEyeColor: (UIColor *) setEyeColor {
	eyeColor = setEyeColor;
}

//Returns finColor.
- (UIColor *) finColor {
	return finColor;
}

//Returns bodyColor.
- (UIColor *) bodyColor {
	return bodyColor;
}

//Returns eyeColor.
- (UIColor *) eyeColor {
	return eyeColor;
}


@end
