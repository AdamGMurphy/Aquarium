//
//  CreateViewController.m
//  Aquarium Simulator
//
//  Created by Dazza on 2013-03-30.
//  Copyright (c) 2013 Adam G Murphy. All rights reserved.
//

#import "CreateViewController.h"
#import "FishSaver.h"

#import "AquariumController.h"
#import "FishDataModel.h"
#import "FishMovementModel.h"
#import "FishColorModel.h"
#import "FishBehaviorController.h"
#import "Frame.h"

#define ARC4RANDOM_MAX      0x100000000

@interface CreateViewController ()

@end

@implementation CreateViewController

@synthesize name;

@synthesize saveButton;

@synthesize finsRedSlider;
@synthesize finsGreenSlider;
@synthesize finsBlueSlider;

@synthesize bodyRedSlider;
@synthesize bodyGreenSlider;
@synthesize bodyBlueSlider;

@synthesize eyesRedSlider;
@synthesize eyesGreenSlider;
@synthesize eyesBlueSlider;


@synthesize finsResultButton;
@synthesize bodyResultButton;
@synthesize eyesResultButton;



-(IBAction)finsRedSliderChanged:(id)sender{
    
    [finsResultButton setBackgroundColor:[UIColor colorWithRed:finsRedSlider.value green:finsGreenSlider.value blue:finsBlueSlider.value alpha:1]];
    
}

-(IBAction)finsGreenSliderChanged:(id)sender{
    
    [finsResultButton setBackgroundColor:[UIColor colorWithRed:finsRedSlider.value green:finsGreenSlider.value blue:finsBlueSlider.value alpha:1]];
    
}

-(IBAction)finsBlueSliderChanged:(id)sender{
    
    [finsResultButton setBackgroundColor:[UIColor colorWithRed:finsRedSlider.value green:finsGreenSlider.value blue:finsBlueSlider.value alpha:1]];
    
}


-(IBAction)bodyRedSliderChanged:(id)sender{
    
    [bodyResultButton setBackgroundColor:[UIColor colorWithRed:bodyRedSlider.value green:bodyGreenSlider.value blue:bodyBlueSlider.value alpha:1]];
    
}

-(IBAction)bodyGreenSliderChanged:(id)sender{
    
    [bodyResultButton setBackgroundColor:[UIColor colorWithRed:bodyRedSlider.value green:bodyGreenSlider.value blue:bodyBlueSlider.value alpha:1]];
    
}

-(IBAction)bodyBlueSliderChanged:(id)sender{
    
    [bodyResultButton setBackgroundColor:[UIColor colorWithRed:bodyRedSlider.value green:bodyGreenSlider.value blue:bodyBlueSlider.value alpha:1]];
    
}


-(IBAction)eyesRedSliderChanged:(id)sender{
    
    [eyesResultButton setBackgroundColor:[UIColor colorWithRed:eyesRedSlider.value green:eyesGreenSlider.value blue:eyesBlueSlider.value alpha:1]];
    
}

-(IBAction)eyesGreenSliderChanged:(id)sender{
    
    [eyesResultButton setBackgroundColor:[UIColor colorWithRed:eyesRedSlider.value green:eyesGreenSlider.value blue:eyesBlueSlider.value alpha:1]];
    
}

-(IBAction)eyesBlueSliderChanged:(id)sender{
    
    [eyesResultButton setBackgroundColor:[UIColor colorWithRed:eyesRedSlider.value green:eyesGreenSlider.value blue:eyesBlueSlider.value alpha:1]];
    
}



-(IBAction)saveButtonPressed:(id)sender{
    
    double size = 1.0;

    CGRect mainScreen = [[UIScreen mainScreen] bounds];
    CGRect rotatedScreen = CGRectMake(CGRectGetMinX(mainScreen), CGRectGetMinY(mainScreen), CGRectGetHeight(mainScreen), CGRectGetWidth(mainScreen));
    
    Frame *fishBoundary = [[Frame alloc] initWithxPos:CGRectGetMinX(rotatedScreen) yPos:CGRectGetMinY(rotatedScreen) width:CGRectGetWidth(rotatedScreen) height:CGRectGetHeight(rotatedScreen)];

    Frame *fishFrame = [[Frame alloc] initWithxPos:0.0 yPos:0.0 width:60.0 * size height:50.0 * size];

    FishMovementModel *movementModel = [[FishMovementModel alloc] initWithFrame:fishFrame boundary:fishBoundary refreshRate:0.1];
    
    FishColorModel *newFishColorModel = [[FishColorModel alloc] initWithFinColor:finsResultButton.backgroundColor bodyColor:bodyResultButton.backgroundColor eyeColor:eyesResultButton.backgroundColor];
    
    FishDataModel *newFishDataModel = [[FishDataModel alloc] initWithName:name.text Size:1 movementModel:movementModel colorModel: newFishColorModel maxHunger:100.0 currentHunger:50.0];
    
    FishSaver *newFishSaver = [[FishSaver alloc] init];
    
    [newFishSaver saveFish:newFishDataModel];
    


    self.saveButton.enabled = NO;
    
    [NSThread sleepForTimeInterval:0.5];

    self.saveButton.enabled = YES;

    [self.navigationController popToRootViewControllerAnimated:YES];
    
}


//clear the keyboard if clicked outside the text field
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [name resignFirstResponder];
}




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
    
    double val = ((double)arc4random() / ARC4RANDOM_MAX);
    
    [finsRedSlider setThumbImage:[UIImage imageNamed:@"reddot"] forState:UIControlStateNormal];
    finsRedSlider.value = val;
    
    val = ((double)arc4random() / ARC4RANDOM_MAX);
    [bodyRedSlider setThumbImage:[UIImage imageNamed:@"reddot"] forState:UIControlStateNormal];
    bodyRedSlider.value = val;
    
    val = ((double)arc4random() / ARC4RANDOM_MAX);
    [eyesRedSlider setThumbImage:[UIImage imageNamed:@"reddot"] forState:UIControlStateNormal];
    eyesRedSlider.value = val;
    
    
    val = ((double)arc4random() / ARC4RANDOM_MAX);
    
    [finsGreenSlider setThumbImage:[UIImage imageNamed:@"greendot"] forState:UIControlStateNormal];
    finsGreenSlider.value = val;
    
    val = ((double)arc4random() / ARC4RANDOM_MAX);
    [bodyGreenSlider setThumbImage:[UIImage imageNamed:@"greendot"] forState:UIControlStateNormal];
    bodyGreenSlider.value = val;

    val = ((double)arc4random() / ARC4RANDOM_MAX);
    [eyesGreenSlider setThumbImage:[UIImage imageNamed:@"greendot"] forState:UIControlStateNormal];
    eyesGreenSlider.value = val;
    
    
    val = ((double)arc4random() / ARC4RANDOM_MAX);
    
    [finsBlueSlider setThumbImage:[UIImage imageNamed:@"bluedot"] forState:UIControlStateNormal];
    finsBlueSlider.value = val;

    val = ((double)arc4random() / ARC4RANDOM_MAX);
    [bodyBlueSlider setThumbImage:[UIImage imageNamed:@"bluedot"] forState:UIControlStateNormal];
    bodyBlueSlider.value = val;
    
    val = ((double)arc4random() / ARC4RANDOM_MAX);
    [eyesBlueSlider setThumbImage:[UIImage imageNamed:@"bluedot"] forState:UIControlStateNormal];
    eyesBlueSlider.value = val;
    
    
    [finsResultButton setBackgroundColor:[UIColor colorWithRed:finsRedSlider.value green:finsGreenSlider.value blue:finsBlueSlider.value alpha:1]];
    
    [bodyResultButton setBackgroundColor:[UIColor colorWithRed:bodyRedSlider.value green:bodyGreenSlider.value blue:bodyBlueSlider.value alpha:1]];
    
    [eyesResultButton setBackgroundColor:[UIColor colorWithRed:eyesRedSlider.value green:eyesGreenSlider.value blue:eyesBlueSlider.value alpha:1]];
    
    
    
    
    [self.navigationController setNavigationBarHidden:NO];
    self.title = @"Customize Pet";
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
