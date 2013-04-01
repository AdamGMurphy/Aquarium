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
    NSTimer *hungerTimer;
    NSTimer *saveTimer;
}

- (id) initWithFishModel: (FishDataModel * )setFishModel {
    self = [super init];
    
    fishModel = setFishModel;
    fishSaver = [[FishSaver alloc] init];
    
    hungerTimer = [[NSTimer alloc] init];
    hungerTimer = [NSTimer scheduledTimerWithTimeInterval: 120 target:self selector:@selector (timerFunction) userInfo:nil repeats:YES];
    
    saveTimer = [[NSTimer alloc] init];
    saveTimer = [NSTimer scheduledTimerWithTimeInterval: 30 target:self selector:@selector (saveFunction) userInfo:nil repeats:YES];
    
    return self;
}

- (void) hungerFunction {
    [fishModel setHunger: [fishModel hunger] - 1];
}

- (void) saveFunction {
    [fishSaver saveFish:fishModel];
}

- (void) stopTimer {
    if (hungerTimer != nil) {
        [hungerTimer invalidate];
        [saveTimer invalidate];
        hungerTimer = nil;
        saveTimer = nil;
    }
}

@end
