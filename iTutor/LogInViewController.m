//
//  LogInViewController.m
//  iTutor
//
//  Created by Andrew Morgan on 3/6/13.
//  Copyright (c) 2013 Andrew Morgan. All rights reserved.
//

#import "LogInViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "NewPassViewController.h"

@interface LogInViewController ()

@end

@implementation LogInViewController
@synthesize emailAddress = _emailAddress;
@synthesize passField = _passField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    passHashCheckString = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    NSLog(@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"unencryptedPassword"]);
    if([passHashCheckString isEqualToString:nil]){
        passHashCheckString = [self convertIntoMD5:@"alpine"];
    }
    //passHashCheckString = [prefs stringForKey:@"password"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginPressed:(UIButton *)sender {
    userEmail = self.emailAddress.text;
    passHash = [self convertIntoMD5:self.passField.text];
    
    NSLog(@"%@", passHash);
    NSLog(@"%@", passHashCheckString);
    
    if(![passHash isEqualToString:passHashCheckString]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Email Address or password is incorrect." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        alert.alertViewStyle = UIAlertViewStyleDefault;
        [alert show];
    }else{
        [self performSegueWithIdentifier:@"loginMainSegue" sender:self];
    }
}

- (IBAction)debugPassPressed:(UIBarButtonItem *)sender {
    passHashCheckString = [self convertIntoMD5:@"alpine"];
}

// No longer neccessary
- (void)importMD5:(NSString *) string{
    passHashCheckString = string;
}

- (NSString *)convertIntoMD5:(NSString *) string{
    const char *cStr = [string UTF8String];
    unsigned char digest[16];
    
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *resultString = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [resultString appendFormat:@"%02x", digest[i]];
    return  resultString;
}
- (void)viewDidUnload {
    //[self setNewPasswordField:nil];
    [super viewDidUnload];
}
@end
