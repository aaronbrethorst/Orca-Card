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
    
    username = [[UITextField alloc] initWithFrame:CGRectMake(90, 12, 200, 21)];
    username.delegate = self;
    username.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    password = [[UITextField alloc] initWithFrame:CGRectMake(90, 12, 200, 21)];
    password.delegate = self;
    password.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    password.secureTextEntry = YES;
    
    usernameCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@""];
    usernameCell.selectionStyle = UITableViewCellSelectionStyleNone;
    usernameCell.textLabel.text = NSLocalizedString(@"Username:", @"");
    [usernameCell.contentView addSubview:username];
    
    passwordCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@""];
    passwordCell.selectionStyle = UITableViewCellSelectionStyleNone;
    passwordCell.textLabel.text = NSLocalizedString(@"Password:", @"");
    [passwordCell.contentView addSubview:password];
    
    buttonCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    buttonCell.textLabel.text = NSLocalizedString(@"Log In", @"");
    buttonCell.selectionStyle = UITableViewCellSelectionStyleBlue;
    buttonCell.textLabel.textAlignment = UITextAlignmentCenter;
    
    [username becomeFirstResponder];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    [username release];
    [password release];
    [usernameCell release];
    [passwordCell release];
    [buttonCell release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (username == textField)
    {
        [password becomeFirstResponder];
    }
    else if (password == textField)
    {
        [password resignFirstResponder];
        [self storeCredentials:textField];
    }
    return YES;
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return NSLocalizedString(@"Your password is securely stored and is never transmitted in plain text.", @"");
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
        {
            return usernameCell;
        }
        case 1:
        {
            return passwordCell;
        }
        case 2:
        {
            return buttonCell;
        }
        default:
        {
            return nil;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (2 == indexPath.row)
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self storeCredentials:tableView];
    }
}


#pragma mark - IBActions

- (IBAction)storeCredentials:(id)sender
{
    if ([username.text length] > 0 && [password.text length] > 0)
    {
        [OrcaCredentials setUsername:username.text password:password.text];
        [self.delegate didStoreUsernamePassword];        
        [self dismissModalViewControllerAnimated:YES];
    }
    else
    {
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"") message:NSLocalizedString(@"Please enter your username and password.", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"Dismiss", @"") otherButtonTitles:nil] autorelease];
        [alert show];
    }
}

@end
