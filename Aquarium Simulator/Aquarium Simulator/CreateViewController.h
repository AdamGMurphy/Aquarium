//
//  CreateViewController.h
//  Aquarium Simulator
//
//  Created by Dazza on 2013-03-30.
//  Copyright (c) 2013 Adam G Murphy. All rights reserved.
//
//
//  Computer Science 4768
//  Team Project: My Pet Fish!
//  By: Adam Murphy and Darren Perry

#import <UIKit/UIKit.h>
#import "Frame.h"

@interface CreateViewController : UIViewController {

    UIButton *finsResultButton;
    UIButton *bodyResultButton;
    UIButton *eyesResultButton;
    
    IBOutlet UISlider *finsRedSlider;
    IBOutlet UISlider *finsGreenSlider;
    IBOutlet UISlider *finsBlueSlider;
    
    IBOutlet UISlider *bodyRedSlider;
    IBOutlet UISlider *bodyGreenSlider;
    IBOutlet UISlider *bodyBlueSlider;
    
    IBOutlet UISlider *eyesRedSlider;
    IBOutlet UISlider *eyesGreenSlider;
    IBOutlet UISlider *eyesBlueSlider;
  
   

}
@property (weak, nonatomic) IBOutlet UITextField *name;

@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@property(nonatomic, retain) IBOutlet UISlider *finsRedSlider;
@property(nonatomic, retain) IBOutlet UISlider *finsGreenSlider;
@property(nonatomic, retain) IBOutlet UISlider *finsBlueSlider;

@property(nonatomic, retain) IBOutlet UISlider *bodyRedSlider;
@property(nonatomic, retain) IBOutlet UISlider *bodyGreenSlider;
@property(nonatomic, retain) IBOutlet UISlider *bodyBlueSlider;

@property(nonatomic, retain) IBOutlet UISlider *eyesRedSlider;
@property(nonatomic, retain) IBOutlet UISlider *eyesGreenSlider;
@property(nonatomic, retain) IBOutlet UISlider *eyesBlueSlider;

@property (strong, nonatomic) IBOutlet UIButton *finsResultButton;
@property (strong, nonatomic) IBOutlet UIButton *bodyResultButton;
@property (strong, nonatomic) IBOutlet UIButton *eyesResultButton;


-(IBAction)finsRedSliderChanged:(id)sender;
-(IBAction)finsGreenSliderChanged:(id)sender;
-(IBAction)finsBlueSliderChanged:(id)sender;

-(IBAction)bodyRedSliderChanged:(id)sender;
-(IBAction)bodyGreenSliderChanged:(id)sender;
-(IBAction)bodyBlueSliderChanged:(id)sender;

-(IBAction)eyesRedSliderChanged:(id)sender;
-(IBAction)eyesGreenSliderChanged:(id)sender;
-(IBAction)eyesBlueSliderChanged:(id)sender;

-(IBAction)saveButtonPressed:(id)sender;


@end
