//
//  StatsViewController.h
//  Aquarium Simulator
//
//  Created by Dazza on 2013-03-31.
//  Copyright (c) 2013 Adam G Murphy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatsViewController : UIViewController{
    
    IBOutlet UILabel *nameText;
    IBOutlet UILabel *hungerText;
    IBOutlet UILabel *sizeText;
}

@property(atomic, readwrite) IBOutlet UILabel *nameText;
@property(atomic, readwrite) IBOutlet UILabel *hungerText;
@property(atomic, readwrite) IBOutlet UILabel *sizeText;


- (void) setDelegate: (id) newDelegate;

- (id) delegate;

@end
