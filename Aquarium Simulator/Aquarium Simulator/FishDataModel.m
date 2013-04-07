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

/*
 Initialize with the basics for a fish.
 name the name of the fish.
 size the size of the fish.
 movementModel the object representing the boundary and position of the fish.
 colorModel the object representing the colors of the fish.
 maxHunger the fish will not eat food when hunger is hgiher than this value
 hunger the hunger level of the fish.
 */
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
     4 - Resting
     */
    
	return self;
}

/*
 Initializes the fish using NSData received during a bluetooth exchange of fish.
 */
- (id) initWithArchive: (NSData *) archive {
    [self setKeys];
    
    FishColorModel *unarchivedColorModel;
    
    UIColor *unarchivedFinColor;
	UIColor *unarchivedBodyColor;
	UIColor *unarchivedEyeColor;
	
    //Get the color of the fish's fins.
	NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:archive];
	float red = [unarchiver decodeFloatForKey:finColorRedKey];
	float green = [unarchiver decodeFloatForKey:finColorGreenKey];
	float blue = [unarchiver decodeFloatForKey:finColorBlueKey];
	float alpha = [unarchiver decodeFloatForKey:finColorAlphaKey];
	unarchivedFinColor = [[UIColor alloc] initWithRed:red green:green blue:blue alpha:alpha];
	
    //Get the color of the fish's body.
	red = [unarchiver decodeFloatForKey:bodyColorRedKey];
	green = [unarchiver decodeFloatForKey:bodyColorGreenKey];
	blue = [unarchiver decodeFloatForKey:bodyColorBlueKey];
	alpha = [unarchiver decodeFloatForKey:bodyColorAlphaKey];
	unarchivedBodyColor = [[UIColor alloc] initWithRed:red green:green blue:blue alpha:alpha];
	
    //Get the color of the fish's eye.
	red = [unarchiver decodeFloatForKey:bodyColorRedKey];
	green = [unarchiver decodeFloatForKey:bodyColorGreenKey];
	blue = [unarchiver decodeFloatForKey:bodyColorBlueKey];
	alpha = [unarchiver decodeFloatForKey:bodyColorAlphaKey];
	unarchivedEyeColor = [[UIColor alloc] initWithRed:red green:green blue:blue alpha:alpha];
    
    //Create a color model for the fish.
    unarchivedColorModel = [[FishColorModel alloc] initWithFinColor:unarchivedFinColor bodyColor:unarchivedBodyColor eyeColor:unarchivedEyeColor];
    
    
    //Create the boundary of the screen.
    CGRect mainScreen = [[UIScreen mainScreen] bounds];
    CGRect rotatedScreen = CGRectMake(CGRectGetMinX(mainScreen), CGRectGetMinY(mainScreen), CGRectGetHeight(mainScreen), CGRectGetWidth(mainScreen));
    Frame *fishBoundary = [[Frame alloc] initWithxPos:CGRectGetMinX(rotatedScreen) yPos:CGRectGetMinY(rotatedScreen) width:CGRectGetWidth(rotatedScreen) height:CGRectGetHeight(rotatedScreen)];
    
    //Create a frame that represents the position and size of the fish.
    Frame *fishFrame = [[Frame alloc] initWithxPos:50.0 yPos:50.0 width:60.0 * size height:50.0 * size];
    FishMovementModel *newMovementModel = [[FishMovementModel alloc] initWithFrame:fishFrame boundary:fishBoundary refreshRate:0.01];
    
    //Get other values for the fish, name, size, hunger and maxHunger.
    NSString *unarchivedName = [unarchiver decodeObjectForKey:nameKey];
    float unarchivedSize = [unarchiver decodeFloatForKey:sizeKey];
    float unarchivedHunger = [unarchiver decodeFloatForKey:hungerKey];
    float unarchivedMaxHunger = [unarchiver decodeFloatForKey:maxHungerKey];
    
    //Call this constructor using the values obtained from the archive.
    self = [self initWithName:unarchivedName Size:unarchivedSize movementModel:newMovementModel colorModel:unarchivedColorModel maxHunger:unarchivedMaxHunger currentHunger:unarchivedHunger];
    
    return self;
}

//Return the name of the fish.
- (NSString *) name {
    return name;
}

//Set the delegate for this object.
- (void) setDelegate: setDelegate {
	delegate = setDelegate;
}

//Return the delegate for this object.
- (id) delegate{
	return delegate;
}

//Return the size for the fish.
- (double) size {
	return size;
}

//Set the size of the fish.
- (void) setSize: (double) setSize {
	size = setSize;
}

//Increase the size of the fish.
- (void) incrementSize: (double) increment {
	size = log(pow(4, size) + increment) / log(4);
}

//Set the current action of the fish.
- (void) setAction: (int) setAction {
    currentAction = setAction;
}

//Return the current action of the fish.
- (int) action {
	return currentAction;
}

//Reeturn the maxHunger of the fish.
- (double) maxHunger {
    return maxHunger;
}

//Set the maxHunger of the fish.
- (void) setHunger: (double) setHunger {
    hunger = setHunger;
}

//Return the hunger of the fish.
- (double) hunger {
	return hunger;
}

//Return the facing of the fish.
- (double) facing {
    return [movementModel facing];
}

//Return the frame of the fish.
- (Frame *) frame {
	return [movementModel frame];
}

//Return the colorModel of the fish.
- (FishColorModel *) colorModel {
	return colorModel;
}

//Inform the delegate that the fish has stopped moving.
- (void) movementStopped {
	[delegate actionFinished];
}

//Tells the movementModel for this fish to move to the given position with the indicated speed.
- (Boolean) moveToPosition: (Position *) position withSpeed: (double) speed {
	return [movementModel moveToPosition: position withSpeed: speed];
}

//Tells the movementModel for this fish to turn around with the indicated speed.
- (void) turnAroundWithSpeed: (double) speed {
	[movementModel turnAroundWithSpeed: speed];
}

//Tells the movementModel that it needs to move towards food with the indicated speed.
- (void) moveToFoodWithSpeed:(double)speed {
    [movementModel moveToFoodWithSpeed: speed];
}

//Returns the status of the presence of food as indicated by the delegate.
- (Boolean) isFood {
    return [delegate isFood];
}

//Returns the frame for the food on screen as given by the delegate.
- (Frame*) foodFrame {
    return [delegate foodFrame];
}

//Tells the delegate to destroy any food on screen.
- (void) destroyFood {
    [delegate destroyFood];
}

//Sets the keys required for archiving and unarchiving information for this object.
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

//Stores the important information for this fish in a NSData and returns it.
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