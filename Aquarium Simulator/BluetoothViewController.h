		//
//  BluetoothViewController.h
//  Aquarium
//
//  Created by Dazza on 2013-03-28.
//  Copyright (c) 2013 Darren Perry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>


@interface BluetoothViewController : UIViewController <GKSessionDelegate, GKPeerPickerControllerDelegate>{
    
    GKPeerPickerController *connectionPicker;
    NSMutableArray *connectionPeers;
    
    UIButton *connectButton;
    UIButton *disconnectButton;
    UIButton *tradeButton;
}

@property (strong, nonatomic) IBOutlet UIButton *connectButton;
@property (strong, nonatomic) IBOutlet UIButton *disconnectButton;
@property (strong, nonatomic) IBOutlet UIButton *tradeButton;
@property (strong, nonatomic) GKSession *session;

//@property (retain) GKSession* connectionSession;
@property (nonatomic, retain) NSMutableArray* connectionPeers;
@property (nonatomic, retain) GKPeerPickerController* connectionPicker;

-(IBAction)connectPressed:(id)sender;
-(IBAction)disconnectPressed:(id)sender;
-(IBAction)tradePressed:(id)sender;

@end
