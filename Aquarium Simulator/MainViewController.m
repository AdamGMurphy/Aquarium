//
//  MainViewController.m
//  Aquarium
//
//  Created by Dazza on 2013-03-27.
//  Copyright (c) 2013 Darren Perry. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

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
    //[self.navigationController setNavigationBarHidden:YES];
}


-(IBAction)newGamePressed:(id)sender{
    
    
}


-(IBAction)loadGamePressed:(id)sender{
    
    AquariumViewController *aquariumView = [[AquariumViewController alloc] initWithNibName:@"AquariumViewController" bundle:nil];
    [self.navigationController pushViewController:aquariumView animated:YES];
    
}


-(IBAction)linkPressed:(id)sender{
    
    BluetoothViewController *bluetoothView = [[BluetoothViewController alloc] initWithNibName:@"BluetoothViewController" bundle:nil];
    [self.navigationController pushViewController:bluetoothView animated:YES];

}


-(IBAction)statsPressed:(id)sender{
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
