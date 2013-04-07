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
}

- (id) initWithFish: (FishDataModel *) setFishModel Boundary: (CGRect) rectBoundary {
    self = [super init];

	Frame *screen = [[Frame alloc] initWithxPos:CGRectGetMinX(rectBoundary) yPos:CGRectGetMinY(rectBoundary) width:CGRectGetWidth(rectBoundary) height:CGRectGetHeight(rectBoundary)];

	fishModel = setFishModel;
	
	behaviorController = [[FishBehaviorController alloc] initWithFishModel: fishModel boundary: screen];
	[behaviorController setDelegate: self];
	[behaviorController beginAction];
	foodModel = [[FoodModel alloc] initWithBoundary:screen];
	
    return self;
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
