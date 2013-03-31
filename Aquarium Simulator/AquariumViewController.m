//
//  AquariumViewController.m
//  Aquarium
//
//  Created by Dazza on 2013-03-29.
//  Copyright (c) 2013 Darren Perry. All rights reserved.
//

#import "AquariumViewController.h"

@interface AquariumViewController ()


@end





@implementation AquariumViewController




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
    
    NSArray *imageArray2 = [NSArray arrayWithObjects:@"back1smallr.png",@"back1smallr.png",@"back2smallr.png",@"back3smallr.png",@"back4smallr.png",@"back4smallr.png", nil];
    
    int i = random()%5;
    
    NSLog(@"this is %d", i);
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:imageArray2[i]]];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self.navigationController setNavigationBarHidden:NO];
    self.title = @"Aquarium";


    
}

-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    NSArray *imageArray2 = [NSArray arrayWithObjects:@"back1smallr.png",@"back1smallr.png",@"back2smallr.png",@"back3smallr.png",@"back4smallr.png",@"back4smallr.png", nil];
    int i = random()%5;
    
    NSLog(@"this is %d", i);    
    
    if(event.subtype == UIEventSubtypeMotionShake){
    
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:imageArray2[i]]];
        [self.view setNeedsDisplay];        
    }
}

/*
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    // Do your thing after shaking device
    //NSArray *imageArray = [NSArray arrayWithObjects:                           [UIImage imageNamed:@"back1smallr.png"],                           [UIImage imageNamed:@"back2smallr.png"],                           [UIImage imageNamed:@"back3smallr.png"],                           [UIImage imageNamed:@"back4smallr.png"],                           [UIImage imageNamed:@"back5smallr.png"],                           nil];
    NSArray *imageArray2 = [NSArray arrayWithObjects:@"back1smallr.png",@"back1smallr.png",@"back2smallr.png",@"back3smallr.png",@"back4smallr.png",@"back4smallr.png", nil];
    int i = random()%5;

    NSLog(@"this is %d", i);
    //NSString *myImage = imageArray[i] image;
    //NSLog(@"this is %@", imageArray[i]);
    NSLog(@"this is %@", imageArray2[i]);
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:imageArray2[i]]];
    //self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"back2smallr.png"]];

     //[[self view] setBackgroundColor: [UIColor colorWithPatternImage: [UIImage imageNamed:@"back2smallr.png"]]];

    //[[self view] setBackgroundColor: [UIColor colorWithPatternImage:imageArray[i]]];
    //self->_view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"back2smallr.png"]];
    [self.view setNeedsDisplay];
    
}
*/



- (BOOL)canBecomeFirstResponder {
    return YES;
}

-(void)viewDidAppear:(BOOL)animated
{
    
    [self becomeFirstResponder];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self resignFirstResponder];
    [self.navigationController setNavigationBarHidden:YES];
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
