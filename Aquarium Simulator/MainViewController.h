//
//  MainViewController.h
//  Aquarium
//
//  Created by Dazza on 2013-03-27.
//  Copyright (c) 2013 Darren Perry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BluetoothViewController.h"
#import "AquariumViewController.h"

@interface MainViewController : UIViewController

-(IBAction)newGamePressed:(id)sender;
-(IBAction)loadGamePressed:(id)sender;
-(IBAction)linkPressed:(id)sender;
-(IBAction)statsPressed:(id)sender;


@end
