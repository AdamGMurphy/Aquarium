//
//  AquariumController.m
//  Aquarium Simulator
//
//  Created by Adam G Murphy on 2013-03-30.
//  Copyright (c) 2013 Adam G Murphy. All rights reserved.
//

#import "AquariumController.h"
#import "FishDataModel.h"
#import "FishMovementModel.h"
#import "FishColorModel.h"
#import "FishBehaviorController.h"
#import "Frame.h"

@implementation AquariumController {
    FishDataModel *fishModel;
    FishMovementModel *movementModel;
    FishColorModel *colorModel;
    FishBehaviorController *behaviourController;
}

- (id) init {
    self = [super init];
    
    Frame *fishFrame = [[Frame alloc] initWithxPos:50.0 yPos:50.0 width:50.0 height:50.0];
    Frame *boundary = [[Frame alloc] initWithxPos:0.0 yPos:0.0 width:500.0 height:500.0];
    
    UIColor *finColor = [[UIColor alloc] initWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
	UIColor *bodyColor = [[UIColor alloc] initWithRed:0.0 green:1.0 blue:0.0 alpha:1.0];
	UIColor *eyeColor = [[UIColor alloc] initWithRed:0.0 green:0.0 blue:1.0 alpha:1.0];
    
    movementModel = [[FishMovementModel alloc] initWithFrame:fishFrame facing:1.0 boundary:boundary refreshRate:0.1];
    colorModel = [[FishColorModel alloc] initWithFinColor:finColor bodyColor:bodyColor eyeColor:eyeColor];
    
    fishModel = [[FishDataModel alloc] initWithSize:1.0 movementModel: movementModel colorModel: colorModel maxHunger:100.0 currentHunger:50.0];
    
    
    return self;
}

- (NSMutableArray *) colorArray{
	NSMutableArray *colorArray = [NSMutableArray array];
	FishColorModel *currentColorModel = [fishModel colorModel];
	[colorArray addObject:[currentColorModel finColor]];
	[colorArray addObject:[currentColorModel bodyColor]];
	[colorArray addObject:[currentColorModel eyeColor]];
	
	return colorArray;
}

- (Frame *) frame {
	return [fishModel frame];
}

- (double) size {
	return [fishModel size];
}

- (double) facing {
	return [fishModel facing];
}

@end
