//
//  FishSaver.m
//  Aquarium Simulator
//
//  Created by Adam G Murphy on 2013-03-31.
//  Copyright (c) 2013 Adam G Murphy. All rights reserved.
//

#import "FishSaver.h"
#import "FishDataModel.h"
#import "FishColorModel.h"

@implementation FishSaver

- (void) saveFish: (FishDataModel *) fish {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:1 forKey:@"numFishSaved"];
    [defaults setObject:[fish name] forKey:@"fishName"];
    [defaults setDouble:[fish size] forKey:@"fishSize"];
    [defaults setDouble:[fish hunger] forKey:@"fishHunger"];
    
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat alpha;
    
    FishColorModel *colorModel = [fish colorModel];
    [[colorModel finColor] getRed:&red green:&green blue:&blue alpha:&alpha];
    [defaults setDouble:red forKey:@"fishFinRed"];
    [defaults setDouble:green forKey:@"fishFinGreen"];
    [defaults setDouble:blue forKey:@"fishFinBlue"];
    [defaults setDouble:red forKey:@"fishFinRed"];
	[defaults setDouble:alpha forKey:@"fishFinAlpha"];
	
    [[colorModel bodyColor] getRed:&red green:&green blue:&blue alpha:&alpha];
    [defaults setDouble:red forKey:@"fishBodyRed"];
    [defaults setDouble:green forKey:@"fishBodyGreen"];
    [defaults setDouble:blue forKey:@"fishBodyBlue"];
    [defaults setDouble:red forKey:@"fishBodyRed"];
	[defaults setDouble:alpha forKey:@"fishBodyAlpha"];
	
	[[colorModel eyeColor] getRed:&red green:&green blue:&blue alpha:&alpha];
    [defaults setDouble:red forKey:@"fishEyeRed"];
    [defaults setDouble:green forKey:@"fishEyeGreen"];
    [defaults setDouble:blue forKey:@"fishEyeBlue"];
    [defaults setDouble:red forKey:@"fishEyeRed"];
	[defaults setDouble:alpha forKey:@"fishEyeAlpha"];	
}

- (void) deleteFish {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setInteger: 0 forKey:@"numFishSaved"];
}

@end
