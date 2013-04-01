//
//  FishLoader.m
//  Aquarium Simulator
//
//  Created by Adam G Murphy on 2013-03-31.
//  Copyright (c) 2013 Adam G Murphy. All rights reserved.
//

#import "FishLoader.h"
#import "FishColorModel.h"
#import "FishDataModel.h"
#import "FishMovementModel.h"

@implementation FishLoader

- (Boolean) savedFish {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger numFishSaved = [defaults integerForKey:@"numFishSaved"];
    return numFishSaved == 1;
}

- (FishDataModel *) loadFish {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *name = [defaults objectForKey:@"fishName"];
    double size = [defaults doubleForKey:@"fishSize"];
    double hunger = [defaults doubleForKey:@"fishHunger"];
    
    double finRed = [defaults doubleForKey:@"fishFinRed"];
    double finGreen = [defaults doubleForKey:@"fishFinGreen"];
    double finBlue = [defaults doubleForKey:@"fishFinBlue"];
    double finAlpha = [defaults doubleForKey:@"fishFinAlpha"];
    
    UIColor *finColor = [[UIColor alloc] initWithRed:finRed green:finGreen blue:finBlue alpha:finAlpha];
    
    double bodyRed = [defaults doubleForKey:@"fishBodyRed"];
    double bodyGreen = [defaults doubleForKey:@"fishBodyGreen"];
    double bodyBlue = [defaults doubleForKey:@"fishBodyBlue"];
    double bodyAlpha = [defaults doubleForKey:@"fishBodyAlpha"];
    
    UIColor *bodyColor = [[UIColor alloc] initWithRed:bodyRed green:bodyGreen blue:bodyBlue alpha:bodyAlpha];

    double eyeRed = [defaults doubleForKey:@"fishEyeRed"];
    double eyeGreen = [defaults doubleForKey:@"fishEyeGreen"];
    double eyeBlue = [defaults doubleForKey:@"fishEyeBlue"];
    double eyeAlpha = [defaults doubleForKey:@"fishEyeAlpha"];
    
    UIColor *eyeColor = [[UIColor alloc] initWithRed:eyeRed green:eyeGreen blue:eyeBlue alpha:eyeAlpha];
    
    FishColorModel *colorModel = [[FishColorModel alloc] initWithFinColor:finColor bodyColor:bodyColor eyeColor:eyeColor];
    
    CGRect mainScreen = [[UIScreen mainScreen] bounds];
    CGRect rotatedScreen = CGRectMake(CGRectGetMinX(mainScreen), CGRectGetMinY(mainScreen), CGRectGetHeight(mainScreen), CGRectGetWidth(mainScreen));
    Frame *fishBoundary = [[Frame alloc] initWithxPos:CGRectGetMinX(rotatedScreen) yPos:CGRectGetMinY(rotatedScreen) width:CGRectGetWidth(rotatedScreen) height:CGRectGetHeight(rotatedScreen)];
    
    Frame *fishFrame = [[Frame alloc] initWithxPos:0.0 yPos:0.0 width:60.0 * size height:50.0 * size];
    FishMovementModel *movementModel = [[FishMovementModel alloc] initWithFrame:fishFrame boundary:fishBoundary refreshRate:0.1];
    
    FishDataModel *fishModel = [[FishDataModel alloc] initWithName:name Size:size movementModel:movementModel colorModel:colorModel maxHunger:100.0 currentHunger:hunger];
    
    return fishModel;
}




@end
