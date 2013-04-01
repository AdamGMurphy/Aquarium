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
#import "FoodModel.h"

@implementation AquariumController {
    FishDataModel *fishModel;
    FishMovementModel *movementModel;
    FishColorModel *colorModel;
    FishBehaviorController *behaviorController;
	FoodModel *foodModel;
//	NSThread *behaviorThread;
}

- (id) initWithFish: (FishDataModel *) setFishModel Boundary: (CGRect) rectBoundary {
    self = [super init];


	Frame *screen = [[Frame alloc] initWithxPos:CGRectGetMinX(rectBoundary) yPos:CGRectGetMinY(rectBoundary) width:CGRectGetWidth(rectBoundary) height:CGRectGetHeight(rectBoundary)];
/*
    Frame *fishFrame = [[Frame alloc] initWithxPos:50.0 yPos:50.0 width:50.0 height:50.0];
    Frame *boundary = screen;
    
    UIColor *finColor = [[UIColor alloc] initWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
	UIColor *bodyColor = [[UIColor alloc] initWithRed:0.0 green:1.0 blue:0.0 alpha:1.0];
	UIColor *eyeColor = [[UIColor alloc] initWithRed:0.0 green:0.0 blue:1.0 alpha:1.0];
    
    movementModel = [[FishMovementModel alloc] initWithFrame:fishFrame facing:1.0 boundary:boundary refreshRate:0.1];
    colorModel = [[FishColorModel alloc] initWithFinColor:finColor bodyColor:bodyColor eyeColor:eyeColor];
    
    fishModel = [[FishDataModel alloc] initWithName: @"lolz" Size:1.0 movementModel: movementModel colorModel: colorModel maxHunger:100.0 currentHunger:50.0];
*/
	
	
	
	
	fishModel = setFishModel;
	
	behaviorController = [[FishBehaviorController alloc] initWithFishModel: fishModel boundary: screen];
	[behaviorController setDelegate: self];

	[behaviorController beginAction];
	
//	behaviorThread = [[NSThread alloc] initWithTarget: behaviorController selector: @selector(beginAction) object: nil];
//	[behaviorThread start];
	
	foodModel = [[FoodModel alloc] initWithBoundary:screen];
	
    return self;
}

- (void) endBehavior {
	
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

- (NSMutableArray *) colorArray{
	NSMutableArray *colorArray = [NSMutableArray array];
	FishColorModel *tempColorModel = [fishModel colorModel];
	[colorArray addObject: [tempColorModel finColor]];
	[colorArray addObject: [tempColorModel bodyColor]];
	[colorArray addObject: [tempColorModel eyeColor]];
	
	return colorArray;
}

- (void) addFoodAtX: (double) x y: (double) y {
    if([foodModel isFood]) {
        return;
    }
    
    Frame *foodFrame = [[Frame alloc] initWithxPos:x yPos:y width:10.0 height:10.0];
    
    [foodModel createFoodWithFrame:foodFrame];
}

- (Boolean) isFood {
    return [foodModel isFood];
}

- (Frame *) foodFrame {
    return [foodModel foodFrame];
}

- (void) destroyFood {
	[foodModel destroyFood];
}

@end
