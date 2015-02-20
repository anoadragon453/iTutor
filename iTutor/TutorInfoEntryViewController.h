//
//  TutorInfoEntryViewController.h
//  iTutor
//
//  Created by Siewkeat on 26/3/13.
//  Copyright (c) 2013 Andrew Morgan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TutorInfoEntryViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *emailAddressField;
@property (weak, nonatomic) IBOutlet UITextField *passField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassField;
@property (weak, nonatomic) IBOutlet UITextField *homeAddressField;
@property (weak, nonatomic) IBOutlet UIImageView *redX;
- (IBAction)nextPressed:(UIButton *)sender;
- (IBAction)finishedEditingEmail:(UITextField *)sender;

@end
