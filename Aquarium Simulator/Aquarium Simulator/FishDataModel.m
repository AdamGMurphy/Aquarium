//
//  FishBehaviorController.m
//  Aquarium Simulator
//
//  Created by Adam G Murphy on 2013-03-30.
//  Copyright (c) 2013 Adam G Murphy. All rights reserved.
//

#import "FishDataModel.h"
#import "FishBehaviorController.h"
#import "FishMovementModel.h"
#import "FishColorModel.h"
#import "Frame.h"
#import "Position.h"


@implementation FishDataModel {
	FishMovementModel *movementModel;
	FishColorModel *colorModel;
    NSString *name;
    double maxHunger;
	double hunger;
	double size;
	int currentAction;
	id delegate;
    
    NSString *finColorRedKey;
	NSString *finColorGreenKey;
	NSString *finColorBlueKey;
	NSString *finColorAlphaKey;
	
	NSString *bodyColorRedKey;
	NSString *bodyColorGreenKey;
	NSString *bodyColorBlueKey;
	NSString *bodyColorAlphaKey;
	
	NSString *eyeColorRedKey;
	NSString *eyeColorGreenKey;
	NSString *eyeColorBlueKey;
	NSString *eyeColorAlphaKey;
    
    NSString *nameKey;
    NSString *sizeKey;
    NSString *maxHungerKey;
    NSString *hungerKey;
}

- (id) initWithName: (NSString *) setName Size: (double) setSize movementModel: (FishMovementModel *) setMovementModel colorModel: (FishColorModel *) setColorModel maxHunger: (double) setMaxHunger currentHunger: (double) setHunger {
	self = [super init];
    
    name = setName;
	size = setSize;
	movementModel = setMovementModel;
	[movementModel setDelegate: self];
	colorModel = setColorModel;
    maxHunger = setMaxHunger;
	hunger = setHunger;
	currentAction = 0;
	/*
     Actions:
     0 - No action
     1 - Moving
     2 - Turning
     3 - Moving to food
     */
    
	return self;
}

- (id) initWithArchive: (NSData *) archive {
    [self setKeys];
    
    FishColorModel *unarchivedColorModel;
    
    UIColor *unarchivedFinColor;
	UIColor *unarchivedBodyColor;
	UIColor *unarchivedEyeColor;
	
	NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:archive];
	float red = [unarchiver decodeFloatForKey:finColorRedKey];
	float green = [unarchiver decodeFloatForKey:finColorGreenKey];
	float blue = [unarchiver decodeFloatForKey:finColorBlueKey];
	float alpha = [unarchiver decodeFloatForKey:finColorAlphaKey];
	unarchivedFinColor = [[UIColor alloc] initWithRed:red green:green blue:blue alpha:alpha];
	
	red = [unarchiver decodeFloatForKey:bodyColorRedKey];
	green = [unarchiver decodeFloatForKey:bodyColorGreenKey];
	blue = [unarchiver decodeFloatForKey:bodyColorBlueKey];
	alpha = [unarchiver decodeFloatForKey:bodyColorAlphaKey];
	unarchivedBodyColor = [[UIColor alloc] initWithRed:red green:green blue:blue alpha:alpha];
	
	red = [unarchiver decodeFloatForKey:bodyColorRedKey];
	green = [unarchiver decodeFloatForKey:bodyColorGreenKey];
	blue = [unarchiver decodeFloatForKey:bodyColorBlueKey];
	alpha = [unarchiver decodeFloatForKey:bodyColorAlphaKey];
	unarchivedEyeColor = [[UIColor alloc] initWithRed:red green:green blue:blue alpha:alpha];
    
    unarchivedColorModel = [[FishColorModel alloc] initWithFinColor:unarchivedFinColor bodyColor:unarchivedBodyColor eyeColor:unarchivedEyeColor];
    
    
    CGRect mainScreen = [[UIScreen mainScreen] bounds];
    CGRect rotatedScreen = CGRectMake(CGRectGetMinX(mainScreen), CGRectGetMinY(mainScreen), CGRectGetHeight(mainScreen), CGRectGetWidth(mainScreen));
    Frame *fishBoundary = [[Frame alloc] initWithxPos:CGRectGetMinX(rotatedScreen) yPos:CGRectGetMinY(rotatedScreen) width:CGRectGetWidth(rotatedScreen) height:CGRectGetHeight(rotatedScreen)];
    
    Frame *fishFrame = [[Frame alloc] initWithxPos:50.0 yPos:50.0 width:60.0 * size height:50.0 * size];
    FishMovementModel *movementModel = [[FishMovementModel alloc] initWithFrame:fishFrame boundary:fishBoundary refreshRate:0.01];
    
    NSString *unarchivedName = [unarchiver decodeObjectForKey:nameKey];
    float unarchivedSize = [unarchiver decodeFloatForKey:sizeKey];
    float unarchivedHunger = [unarchiver decodeFloatForKey:hungerKey];
    float unarchivedMaxHunger = [unarchiver decodeFloatForKey:maxHungerKey];
    
    self = [self initWithName:unarchivedName Size:unarchivedSize movementModel:movementModel colorModel:unarchivedColorModel maxHunger:unarchivedMaxHunger currentHunger:unarchivedHunger];
    
    return self;
}

- (NSString *) name {
    return name;
}

- (void) setDelegate: setDelegate {
	delegate = setDelegate;
}

- (id) delegate{
	return delegate;
}

- (double) size {
	return size;
}

- (void) setSize: (double) setSize {
	size = setSize;
}

- (void) incrementSize: (double) increment {
	size = log(pow(10.0, size) + increment) / log(8.5);
}

- (void) setAction: (int) setAction {
    currentAction = setAction;
}

- (int) action {
	return currentAction;
}

- (double) maxHunger {
    return maxHunger;
}

- (void) setHunger: (double) setHunger {
    hunger = setHunger;
}

- (double) hunger {
	return hunger;
}

- (double) facing {
    return [movementModel facing];
}

- (Frame *) frame {
	return [movementModel frame];
}

- (FishColorModel *) colorModel {
	return colorModel;
}

- (void) movementStopped {
	[delegate actionFinished];
}

- (void) turningStopped {
	[delegate actionFinished];
}

- (Boolean) moveToPosition: (Position *) position withSpeed: (double) speed {
	return [movementModel moveToPosition: position withSpeed: speed];
}

- (void) turnAroundWithSpeed: (double) speed {
	[movementModel turnAroundWithSpeed: speed];
}

- (void) moveToFoodWithSpeed:(double)speed {
    [movementModel moveToFoodWithSpeed: speed];
}

- (Boolean) isFood {
    return [delegate isFood];
}

- (Frame*) foodFrame {
    return [delegate foodFrame];
}

- (void) destroyFood {
    [delegate destroyFood];
}

- (void) setKeys {
	finColorRedKey = @"fin_color_red";
	finColorGreenKey = @"fin_color_green";
	finColorBlueKey = @"fin_color_blue";
	finColorAlphaKey = @"fin_color_alpha";
	
	bodyColorRedKey = @"body_color_red";
	bodyColorGreenKey = @"body_color_green";
	bodyColorBlueKey = @"body_color_blue";
	bodyColorAlphaKey = @"body_color_alpha";
	
	eyeColorRedKey = @"eye_color_red";
	eyeColorGreenKey = @"eye_color_green";
	eyeColorBlueKey = @"eye_color_blue";
	eyeColorAlphaKey = @"eye_color_alpha";
    
    nameKey = @"name";
    sizeKey = @"size";
    maxHungerKey = @"max_hunger";
    hungerKey = @"hunger";
}

- (NSData *) archive {
	NSMutableData *archive = [NSMutableData data];
	NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:archive];
	
	CGFloat *red = NULL;
	CGFloat *green = NULL;
	CGFloat *blue = NULL;
	CGFloat *alpha = NULL;

	[[colorModel finColor] getRed:red green:green blue:blue alpha:alpha];
	[archiver encodeFloat:*red forKey:finColorRedKey];
	[archiver encodeFloat:*green forKey:finColorGreenKey];
	[archiver encodeFloat:*blue forKey:finColorBlueKey];
	[archiver encodeFloat:*alpha forKey:finColorAlphaKey];
	
	[[colorModel bodyColor] getRed:red green:green blue:blue alpha:alpha];
	[archiver encodeFloat:*red forKey:bodyColorRedKey];
	[archiver encodeFloat:*green forKey:bodyColorGreenKey];
	[archiver encodeFloat:*blue forKey:bodyColorBlueKey];
	[archiver encodeFloat:*alpha forKey:bodyColorAlphaKey];
	
	[[colorModel eyeColor] getRed:red green:green blue:blue alpha:alpha];
	[archiver encodeFloat:*red forKey:eyeColorAlphaKey];
	[archiver encodeFloat:*green forKey:eyeColorGreenKey];
	[archiver encodeFloat:*blue forKey:eyeColorBlueKey];
	[archiver encodeFloat:*alpha forKey:eyeColorAlphaKey];
	
    [archiver encodeObject:name forKey:nameKey];
    [archiver encodeFloat:size forKey:sizeKey];
    [archiver encodeFloat:maxHunger forKey:maxHungerKey];
    [archiver encodeFloat:hunger forKey:hungerKey];

	return archive;
}


@end