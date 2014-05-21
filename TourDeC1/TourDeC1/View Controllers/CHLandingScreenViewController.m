//
//  CHLandingScreenViewController.m
//  TourDeC1
//
//  Created by Anuradha Ramprakash on 3/28/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import "CHLandingScreenViewController.h"
#import "CHWelcomeViewController.h"
#import "CHBeaconStore.h"
#import "CGGlobals.h"

@interface CHLandingScreenViewController ()

@end

@implementation CHLandingScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Turn on notifications about beacons
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handleEvent:)
                                                name:CCHContextEventManagerDidPostEvent
                                              object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    // Definitely make sure we get no more notifications about beacons (next screen will turn them on when needed
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

// Handles events from beacons
- (void)handleEvent:(NSNotification *)notification {
    if (self.navigationController.topViewController == self) {
        CHBeaconMetadata *anyBeacon = [CHBeaconMetadata beaconFromNotification:notification];
        
        // At the landing screen, we only care we can detect the BeaconUUID (meaning we are somewhere near the office)
        if([anyBeacon.uuid isEqualToString:BeaconUdid]) {
            // Turn off notifications about beacons
            [[NSNotificationCenter defaultCenter]removeObserver:self];
            [self performSegueWithIdentifier:@"showWelcomeScreen" sender:nil];
        }
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"showWelcomeScreen"]){
        // Set up the beacon info the welcome screen needs to know about (Beacon1)
        CHWelcomeViewController *welcomeVC = segue.destinationViewController;
        
        // Not currently at any specific beacon
        welcomeVC.currentBeaconMetadata = nil;
        // Destination is beacon 1
        welcomeVC.destinationBeaconMetadata = [[CHBeaconStore sharedStore] metadataForBeaconWithName:BeaconB1];
    }
}

@end
