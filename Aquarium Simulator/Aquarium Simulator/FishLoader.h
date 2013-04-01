//
//  FishLoader.h
//  Aquarium Simulator
//
//  Created by Adam G Murphy on 2013-03-31.
//  Copyright (c) 2013 Adam G Murphy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishDataModel.h"

@interface FishLoader : NSObject

- (Boolean) savedFish;

- (FishDataModel *) loadFish;

@end
