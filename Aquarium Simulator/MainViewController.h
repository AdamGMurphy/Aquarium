//
//  MainViewController.h
//  Aquarium
//
//  Created by Dazza on 2013-03-27.
//  Copyright (c) 2013 Darren Perry. All rights reserved.
//
//
//  Computer Science 4768
//  Team Project: My Pet Fish!
//  By: Adam Murphy and Darren Perry

#import <UIKit/UIKit.h>
#import "BluetoothViewController.h"
#import "AquariumViewController.h"
#import "CreateViewController.h"
#import "StatsViewController.h"
#import "FishDataModel.h"

@interface MainViewController : UIViewController{
    
    IBOutlet UIButton *viewButton;
}

@property (strong, nonatomic) IBOutlet UIButton *viewButton;

-(IBAction)newGamePressed:(id)sender;
-(IBAction)loadGamePressed:(id)sender;
-(IBAction)linkPressed:(id)sender;
-(IBAction)statsPressed:(id)sender;

- (void) setFish: (FishDataModel *) setFishModel;

- (FishDataModel *) getFish;


@end
