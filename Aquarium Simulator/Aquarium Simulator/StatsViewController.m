//
//  StatsViewController.m
//  Aquarium Simulator
//
//  Created by Dazza on 2013-03-31.
//  Copyright (c) 2013 Adam G Murphy. All rights reserved.
//

#import "StatsViewController.h"

@interface StatsViewController ()

@end

@implementation StatsViewController

@synthesize nameText;
@synthesize hungerText;
@synthesize sizeText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //turn on the nav bar and set the title
    [self.navigationController setNavigationBarHidden:NO];
    self.title = @"Statistics";
}

-(void)viewWillDisappear:(BOOL)animated
{
    //moving to main page so we disable the nav bar
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
