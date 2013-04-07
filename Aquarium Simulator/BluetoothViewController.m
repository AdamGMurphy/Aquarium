//
//  BluetoothViewController.m
//  Aquarium
//
//  Created by Dazza on 2013-03-28.
//  Copyright (c) 2013 Darren Perry. All rights reserved.
//
//
//  Computer Science 4768
//  Team Project: My Pet Fish!
//  By: Adam Murphy and Darren Perry

#import "BluetoothViewController.h"
#import "MainViewController.h"
#import "FishDataModel.h"

//controller for the trade screen
@interface BluetoothViewController ()

@end

@implementation BluetoothViewController

@synthesize tradeButton;
@synthesize connectButton;
@synthesize disconnectButton;

@synthesize connectionPeers;
@synthesize connectionPicker;
@synthesize session = _session;

id delegate;
Boolean selfTradeAccepted;
Boolean otherTradeAccepted;
FishDataModel *receivedFish;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    
    selfTradeAccepted = false;
    otherTradeAccepted = false;
    
    return self;
}

- (void) setDelegate: (id) newDelegate {
    delegate = newDelegate;
}


-(IBAction)connectPressed:(id)sender{
    
    if (self.session == nil) {
        //create peer picker and show picker of connections
        GKPeerPickerController *peerPicker = [[GKPeerPickerController alloc] init];
        peerPicker.delegate = self;
        peerPicker.connectionTypesMask = GKPeerPickerConnectionTypeNearby;
        [peerPicker show];
    }
    
}

//Disconnect from all peers 
-(IBAction)disconnectPressed:(id)sender{
    
    [self.session disconnectFromAllPeers];
    
    //disable disconnect and trade buttons
    self.disconnectButton.enabled = NO;
    self.tradeButton.enabled = NO;
    
}

-(IBAction)tradePressed:(id)sender{
    
    NSData *fishData = [[delegate getFish] archive];
    NSLog(@"Fish data retrieved and archived");
    [self.session sendData: fishData toPeers:connectionPeers withDataMode:GKSendDataReliable error:nil];
    NSLog(@"Fish data sent");
    selfTradeAccepted = true;
    if (selfTradeAccepted && otherTradeAccepted){
        NSLog(@"Trade completed");
        [self completeTrade];
    }
    else {
        UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"Trade started!"
                                                         message:@"Please wait for the other user to confirm the trade."
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
        [alert1 show];
    }
}

//TODO The receiving data method.
- (void)receiveData:(NSData *)data fromPeer:(NSString *)peer inSession:(GKSession *)session context:(void *)context
{
    
    if (!otherTradeAccepted) {
        UIAlertView *alert3 = [[UIAlertView alloc] initWithTitle:@"The other user wishes to trade!"
                                                         message:@"Please accept the trade by clicking trade, or disconnect."
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
        [alert3 show];
    }
    
    
    NSLog(@"Fish data received");
    receivedFish = [[FishDataModel alloc] initWithArchive:data];
    NSLog(@"Fish data converted into a fish.");
    otherTradeAccepted = true;
    if (selfTradeAccepted && otherTradeAccepted) {
        NSLog(@"Trade completed");
        [self completeTrade];
    }
}

- (void) completeTrade {
    NSLog(@"Fish saved");
    UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"Trade Completed!"
                                                     message:@"View your new fish from the main screen."
                                                    delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
    [alert2 show];
    [delegate setFish:receivedFish];
}

//Get a session based on the connection type specified.
- (GKSession *)peerPickerController:(GKPeerPickerController *)picker sessionForConnectionType:(GKPeerPickerConnectionType)type
{
    //create ID for session
    NSString *sessionIDString = @"AquariumBluetoothSessionID";
    //create GKSession object
    GKSession *session = [[GKSession alloc] initWithSessionID:sessionIDString displayName:nil sessionMode:GKSessionModePeer];
    return session;
}




//Take control of the session and dismiss the picker.
- (void)peerPickerController:(GKPeerPickerController *)picker didConnectPeer:(NSString *)peerID toSession:(GKSession *)session
{
    //set session delegate and dismiss the picker
    session.delegate = self;
    self.session = session;
    picker.delegate = nil;
    [picker dismiss];
}


//Set the ViewController object to receive data from its peers
- (void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state
{
    if (state == GKPeerStateConnected){
        [connectionPeers addObject:peerID];
        NSString *str = [NSString stringWithFormat:@"Connected with %@",[session displayNameForPeer:peerID]];
        UIAlertView *alert4 = [[UIAlertView alloc] initWithTitle:@"Connected" message:str delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert4 show];
        
        
        [session setDataReceiveHandler:self withContext:nil]; //set ViewController to receive data
        self.tradeButton.enabled = YES; //enable send button when session is connected
        self.disconnectButton.enabled = YES; //enable disconnect button if connected
    }
    else {
        self.tradeButton.enabled = NO; //disable send button if session is disconnected
        self.disconnectButton.enabled = NO; //disable disconnect button until session connected
        self.session.delegate = nil;
        self.session = nil; //allow session to reconnect if it gets disconnected
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    //turn on the nav bar and set the title
    [self.navigationController setNavigationBarHidden:NO];
    self.title = @"Bluetooth Connection";

    //disable disconnect and trade buttons until connection available
    self.disconnectButton.enabled = NO;
    self.tradeButton.enabled = NO;
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
