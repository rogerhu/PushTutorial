//
//  Copyright (c) 2012 Parse. All rights reserved.

#import "ViewController.h"
#import <Parse/Parse.h>

@implementation ViewController

@synthesize genderControl, ageControl, ageLabel;


#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self setTitle:@"Parse Push Notifications"];
    [self loadInstallData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - ()

/* Touch handler for the button */
- (IBAction)broadcastPushNotification:(id)sender  {
    [PFPush sendPushMessageToChannelInBackground:@"global" withMessage:@"Hello World!"];
}

- (void)viewDidUnload {
    [self setGenderControl:nil];
    [self setAgeLabel:nil];
    [self setAgeControl:nil];
    [super viewDidUnload];
}

- (IBAction)updateInstallation:(id)sender {
    NSLog(@"updateInstallation");
    NSNumber *age = [NSNumber numberWithInt:(int)ageControl.value];
    NSString *gender = @"male";
    if (genderControl.selectedSegmentIndex == 1) {
        gender = @"female";
    }
    PFInstallation *install = [PFInstallation currentInstallation];
    [install setObject:age forKey:@"age"];
    [install setObject:gender forKey:@"gender"];
    [install saveInBackground];
}

- (IBAction)updateAgeLabel:(id)sender {
    ageLabel.text = [NSString stringWithFormat:@"%i", (int)ageControl.value];
}

- (void) loadInstallData {
    NSLog(@"loadInstallData");
    PFInstallation *install = [PFInstallation currentInstallation];
    NSNumber *age = [install objectForKey:@"age"];
    NSString *gender = [install objectForKey:@"gender"];

    // Handle saved age, or populate default age.
    if (!age) {
        age = [[NSNumber alloc] initWithInt:35];
        [install setObject:age forKey:@"age"];
    }
    ageLabel.text = [NSString stringWithFormat:@"%@", age];
    
    // Handle saved gender, or populate default gender.
    if ([gender isEqualToString:@"male"]) {
        genderControl.selectedSegmentIndex = 0;
    } else if ([gender isEqualToString:@"female"]) {
        genderControl.selectedSegmentIndex = 1;
    } else {
        genderControl.selectedSegmentIndex = 0;
        [install setObject:@"male" forKey:@"gender"];
    }
    
    [install saveInBackground];
    
}

@end
