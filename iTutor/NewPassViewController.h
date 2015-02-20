//
//  NewPassViewController.h
//  iTutor
//
//  Created by Andrew gayLuigi Morgan on 3/12/13.
//  Copyright (c) 2013 Andrew Morgan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LogInViewController.h"

@interface NewPassViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *theNewPassField;
- (IBAction)setPressed:(id)sender;


@end
NSString *theNewPassHash;