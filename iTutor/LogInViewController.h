//
//  LogInViewController.h
//  iTutor
//
//  Created by Andrew Morgan on 3/6/13.
//  Copyright (c) 2013 Andrew Morgan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogInViewController : UIViewController
- (IBAction)loginPressed:(UIButton *)sender;

- (IBAction)debugPassPressed:(UIBarButtonItem *)sender;
@property (strong, nonatomic) IBOutlet UITextField *emailAddress;
@property (strong, nonatomic) IBOutlet UITextField *passField;
//-(void)importMD5;
@end
NSString *passHash;
NSString *passHashCheckString;
NSString *userEmail;