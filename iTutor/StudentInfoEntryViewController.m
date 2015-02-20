//
//  StudentInfoEntryViewController.m
//  iTutor
//
//  Created by Siewkeat on 26/3/13.
//  Copyright (c) 2013 Andrew Morgan. All rights reserved.
//

#import "StudentInfoEntryViewController.h"
#import <CommonCrypto/CommonDigest.h>

@interface StudentInfoEntryViewController ()

@end

@implementation StudentInfoEntryViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setEmailAddressField:nil];
    [self setPassField:nil];
    [self setConfirmPassField:nil];
    [self setHomeAddressField:nil];
    [self setRedX:nil];
    [super viewDidUnload];
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
//It's neccessary to #import <CommonCrypto/CommonDigest.h>
- (IBAction)nextPressed:(UIButton *)sender {
    //nil doesn't seem to work. It doesn't detect whether a text is nil. or does it? No it doesn't.
    if([self.emailAddressField.text isEqualToString:@""] || [self.passField.text isEqualToString:@""] || [self.confirmPassField.text isEqualToString:@""] || [self.homeAddressField.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please fill out all fields." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        alert.alertViewStyle = UIAlertViewStyleDefault;
        [alert show];
    }else if(![self.passField.text isEqualToString:self.confirmPassField.text]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Passwords do not match." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        alert.alertViewStyle = UIAlertViewStyleDefault;
        [alert show];
    }else{
        [[NSUserDefaults standardUserDefaults] setValue:self.emailAddressField.text forKey:@"studentRegisterEmailAddress"];
        [[NSUserDefaults standardUserDefaults] setValue:self.passField.text forKey:@"studentRegisterPassword"];
        
        [[NSUserDefaults standardUserDefaults] setValue:[self convertIntoMD5:self.passField.text] forKey:@"password"];
        
        [[NSUserDefaults standardUserDefaults] setValue:self.confirmPassField.text forKey:@"studentRegisterConfirmPassword"];
        [[NSUserDefaults standardUserDefaults] setValue:self.homeAddressField forKey:@"studentRegisterHomeAddress"];
        
        //Tell the Table View Controller that this is the view that it is segueing from.
        [[NSUserDefaults standardUserDefaults] setValue:@"Student" forKey:@"segue"];
        
        [self performSegueWithIdentifier: @"studentSegueToTable" sender: self];
    }
}

- (IBAction)finishedEditingEmail:(id)sender {
    if(![self validateEmail:self.emailAddressField.text]){
        self.redX.alpha = 1.0f;
    }else{
        self.redX.alpha = 0.0f;
    }
}

- (BOOL)validateEmail:(NSString *)emailStr {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailStr];
}

@end
