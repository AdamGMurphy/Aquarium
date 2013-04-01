//
//  FishSaver.h
//  Aquarium Simulator
//
//  Created by Adam G Murphy on 2013-03-31.
//  Copyright (c) 2013 Adam G Murphy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishDataModel.h"

@interface FishSaver : NSObject

- (void) saveFish: (FishDataModel *) fish;

- (void) deleteFish;

@end
