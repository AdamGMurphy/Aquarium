//
//  MainViewController.m
//  Aquarium
//
//  Created by Dazza on 2013-03-27.
//  Copyright (c) 2013 Darren Perry. All rights reserved.
//

#import "MainViewController.h"
#import "StatsViewController.h"
#import "FishLoader.h"
#import "FishDataModel.h"
#import "FishTimer.h"

@interface MainViewController () {
    FishDataModel *fishModel;
    FishTimer *fishTimer;
}

@end

@implementation MainViewController

@synthesize viewButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
          
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //[self.navigationController setNavigationBarHidden:YES];


    
    fishTimer = nil;
}

-(void) viewWillAppear:(BOOL)animated{
    
    FishLoader *newFishLoader = [[FishLoader alloc] init];
    if(![newFishLoader savedFish]){
        self.viewButton.enabled = NO;
    }
    else{
        self.viewButton.enabled = YES;
        [self setFish:[newFishLoader loadFish]];
    }
    
}


-(IBAction)newGamePressed:(id)sender{
    
    CreateViewController *createView = [[CreateViewController alloc] initWithNibName:@"CreateViewController" bundle:nil];
    [self.navigationController pushViewController:createView animated:YES];
    
}


- (void) setFish: (FishDataModel *) setFishModel {
    fishModel = setFishModel;
    [fishTimer stopTimer];
    fishTimer = [[FishTimer alloc] initWithFishModel:fishModel];
}

- (FishDataModel *) getFish{
    
    return fishModel;
}


-(IBAction)loadGamePressed:(id)sender{
    AquariumViewController *aquariumView = [[AquariumViewController alloc] initWithFish: fishModel NibName:@"AquariumViewController" bundle:nil];
    [self.navigationController pushViewController:aquariumView animated:YES];
    
}


-(IBAction)linkPressed:(id)sender{
    
    BluetoothViewController *bluetoothView = [[BluetoothViewController alloc] initWithNibName:@"BluetoothViewController" bundle:nil];
    [self.navigationController pushViewController:bluetoothView animated:YES];

}


-(IBAction)statsPressed:(id)sender{
    
    StatsViewController *statsView = [[StatsViewController alloc] initWithNibName:@"StatsViewController" bundle:nil];
    [statsView setDelegate:self];
    [self.navigationController pushViewController:statsView animated:YES];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
