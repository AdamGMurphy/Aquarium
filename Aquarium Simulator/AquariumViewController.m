//
//  AquariumViewController.m
//  Aquarium
//
//  Created by Dazza on 2013-03-29.
//  Copyright (c) 2013 Darren Perry. All rights reserved.
//

#import "AquariumViewController.h"
#import "AquariumController.h"
#import "AquariumView.h"
#import "FishDataModel.h"
#import "FoodModel.h"


@interface AquariumViewController ()


@end

@implementation AquariumViewController{
    AquariumController *aquaController;
    AquariumView *aquaView;
    FishDataModel *fishModel;
}




- (id)initWithFish: (FishDataModel *) setFishModel NibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        fishModel = setFishModel; 
        // Custom initialization

    }
    
    return self;
}

- (void)viewDidLoad
{
  
    //a list of available background images
    NSArray *imageArray2 = [NSArray arrayWithObjects:@"back1smallr.png",@"back1smallr.png",@"back2smallr.png",@"back3smallr.png",@"back4smallr.png",@"back4smallr.png", nil];
    
    int i = random()%5;

    //choose one of the 5 random images as the background
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:imageArray2[i]]];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    //show the nav bar and title
    [self.navigationController setNavigationBarHidden:NO];
    self.title = @"Aquarium";

    //set the screen
    CGRect mainScreen = [[UIScreen mainScreen] bounds];
    CGRect rotatedScreen = CGRectMake(CGRectGetMinX(mainScreen), CGRectGetMinY(mainScreen), CGRectGetHeight(mainScreen), CGRectGetWidth(mainScreen));
    
    //set the aquarium view information
    aquaController = [[AquariumController alloc] initWithFish: fishModel Boundary: rotatedScreen];
    aquaView = [[AquariumView alloc] initWithFrame: rotatedScreen];
    [aquaView setDelegate: aquaController];
    [self.view addSubview: aquaView];
    
    [NSTimer scheduledTimerWithTimeInterval: 0.01 target:self selector:@selector(refresh) userInfo: nil repeats: YES];

    //add food recognizer
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addFood:)];
    [self.view addGestureRecognizer:tapRecognizer];
}

//add food element to the view
- (void) addFood:(UITapGestureRecognizer *)press {

    [aquaController addFoodAtX: [press locationInView:self.view].x y: [press locationInView:self.view].y];
}

//refresh the screen
- (void) refresh {
    [aquaView setNeedsDisplay];
}

//gesture recognizer to change the background on a device shake
-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    NSArray *imageArray2 = [NSArray arrayWithObjects:@"back1smallr.png",@"back1smallr.png",@"back2smallr.png",@"back3smallr.png",@"back4smallr.png",@"back4smallr.png", nil];
    int i = random()%5;
    
    //on shake change to one of the above backgrounds
    if(event.subtype == UIEventSubtypeMotionShake){
    
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:imageArray2[i]]];
    }
}


//allow first responder
- (BOOL)canBecomeFirstResponder {
    return YES;
}


-(void)viewDidAppear:(BOOL)animated
{
    //set first responder
    [self becomeFirstResponder];
}

-(void)viewWillDisappear:(BOOL)animated
{
    //resign and hide nav bar on close
    [self resignFirstResponder];
    [self.navigationController setNavigationBarHidden:YES];
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
