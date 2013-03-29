//
//  Copyright (c) 2012 Parse. All rights reserved.

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

/* Touch handler for the button */
-(IBAction)broadcastPushNotification:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *genderControl;
@property (weak, nonatomic) IBOutlet UISlider *ageControl;

@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
- (IBAction)updateInstallation:(id)sender;
- (IBAction)updateAgeLabel:(id)sender;
@end
