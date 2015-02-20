//Adrian really did this
//  NewPassViewController.m
//  iTutor
//
//  Created by Andrew GayLuigig Morgan on 3/12/13.
//  Copyright (c) 2013 Andrew gayLuigi Morgan. No rights reserved.
//

#import "NewPassViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "LogInViewController.h"

@interface NewPassViewController ()

@end


@implementation NewPassViewController

@synthesize theNewPassField = _theNewPassField;

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

- (NSString *)convertIntoMD5:(NSString *) string{
    const char *cStr = [string UTF8String];
    unsigned char digest[16];
    
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *resultString = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [resultString appendFormat:@"%02x", digest[i]];
    return  resultString;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)setPressed:(id)sender {
    theNewPassHash = [self convertIntoMD5:self.theNewPassField.text];
    //NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    //[prefs setValue:theNewPassHash forKey:@"password"];
    [[NSUserDefaults standardUserDefaults] setValue:theNewPassHash forKey:@"password"];
    [[NSUserDefaults standardUserDefaults] setValue:self.theNewPassField.text forKey:@"unencryptedPassword"];
    [self performSegueWithIdentifier:@"preLoginSegue" sender:self];
}
@end
