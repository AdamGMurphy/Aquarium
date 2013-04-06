//
//  BluetoothViewController.m
//  Aquarium
//
//  Created by Dazza on 2013-03-28.
//  Copyright (c) 2013 Darren Perry. All rights reserved.
//

#import "BluetoothViewController.h"
#import "MainViewController.h"
#import "FishDataModel.h"


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
    [self.session sendDataToAllPeers:fishData withDataMode:GKSendDataReliable error:nil];
    selfTradeAccepted = true;
    if (selfTradeAccepted && otherTradeAccepted)
        [self completeTrade];
    
}

//TODO The receiving data method.
- (void)receiveData:(NSData *)data fromPeer:(NSString *)peer inSession:(GKSession *)session context:(void *)context
{
    receivedFish = [[FishDataModel alloc] initWithArchive:data];
    otherTradeAccepted = true;
    if (selfTradeAccepted && otherTradeAccepted)
        [self completeTrade];
}

- (void) completeTrade {
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
