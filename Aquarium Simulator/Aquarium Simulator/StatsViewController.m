//
//  StatsViewController.m
//  Aquarium Simulator
//
//  Created by Dazza on 2013-03-31.
//  Copyright (c) 2013 Adam G Murphy. All rights reserved.
//

#import "StatsViewController.h"
#import "FishDataModel.h"
#import "FishLoader.h"
#import "MainViewController.h"  

//controller for the statistics screen
@interface StatsViewController (){
    
    id delegate;

}

@end

@implementation StatsViewController

//the stats to display
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

//initialize delegate
- (void) setDelegate: (id) newDelegate {
	delegate = newDelegate;
}

- (id) delegate{
	return delegate;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //turn on the nav bar and set the title
    [self.navigationController setNavigationBarHidden:NO];
    self.title = @"Statistics";
    
    //get the data model for the stats
    FishDataModel *statsFish = [delegate getFish];
    
    nameText.text = statsFish.name;
    hungerText.text = [NSString stringWithFormat:@"%.f",statsFish.hunger];
    sizeText.text = [NSString stringWithFormat:@"%f",statsFish.size];
    
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
