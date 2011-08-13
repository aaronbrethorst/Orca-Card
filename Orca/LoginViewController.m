//
//  LoginViewController.m
//  Orca
//
//  Created by Aaron Brethorst on 8/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "OrcaCredentials.h"

@implementation LoginViewController
@synthesize username, password;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = NSLocalizedString(@"Log In", @"");
    }
    return self;
}

- (void)dealloc
{
    self.delegate = nil;    
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.username = nil;
    self.password = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - IBActions

- (IBAction)storeCredentials:(id)sender
{
    [OrcaCredentials setUsername:self.username.text password:self.password.text];
    [self.delegate didStoreUsernamePassword];
    
    [self dismissModalViewControllerAnimated:YES];
}

@end
