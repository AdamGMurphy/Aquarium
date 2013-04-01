//
//  FishTimer.m
//  Aquarium Simulator
//
//  Created by Adam G Murphy on 2013-04-01.
//  Copyright (c) 2013 Adam G Murphy. All rights reserved.
//

#import "FishTimer.h"
#import "FishDataModel.h"
#import "FishSaver.h"

@implementation FishTimer {
    FishDataModel *fishModel;
    FishSaver *fishSaver;
    NSTimer *fishTimer;
}

- (id) initWithFishModel: (FishDataModel * )setFishModel {
    self = [super init];
    
    fishModel = setFishModel;
    fishSaver = [[FishSaver alloc] init];
    
    fishTimer = [[NSTimer alloc] init];
    fishTimer = [NSTimer scheduledTimerWithTimeInterval: 18000 target:self selector:@selector (timerFunction) userInfo:nil repeats:YES];
    
    return self;
}

- (void) timerFunction {
    [fishModel setHunger: [fishModel hunger] - 1];
    [fishSaver saveFish:fishModel];
}

- (void) stopTimer {
    if (fishTimer != nil) {
        [fishTimer invalidate];
        fishTimer = nil;
    }
}

@end
