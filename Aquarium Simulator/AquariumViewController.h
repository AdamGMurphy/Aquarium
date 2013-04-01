//
//  AquariumViewController.h
//  Aquarium
//
//  Created by Dazza on 2013-03-29.
//  Copyright (c) 2013 Darren Perry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FishDataModel.h"

@interface AquariumViewController : UIViewController

- (id)initWithFish: (FishDataModel *) setFishModel NibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;

-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event;

- (void) addFood:(UILongPressGestureRecognizer *)press;

- (Boolean) isFood;

- (Frame *) foodFrame;

- (void) refresh;

- (BOOL)canBecomeFirstResponder;

@end
