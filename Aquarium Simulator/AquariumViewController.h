//
//  AquariumViewController.h
//  Aquarium
//
//  Created by Dazza on 2013-03-29.
//  Copyright (c) 2013 Darren Perry. All rights reserved.
//
//
//  Computer Science 4768
//  Team Project: My Pet Fish!
//  By: Adam Murphy and Darren Perry

#import <UIKit/UIKit.h>
#import "FishDataModel.h"

@interface AquariumViewController : UIViewController

- (id)initWithFish: (FishDataModel *) setFishModel NibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;

- (void) addFood:(UITapGestureRecognizer *)press;

- (void) refresh;

-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event;


- (BOOL)canBecomeFirstResponder;

@end
