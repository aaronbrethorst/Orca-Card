//
//  RootViewController.m
//  Orca
//
//  Created by Aaron Brethorst on 8/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "OrcaCredentials.h"

@interface RootViewController ()
- (void)logIn;
- (void)logOut;
- (void)displayLoginViewController;
@end

@implementation RootViewController
@synthesize cards;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Orca Balance", @"");
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Sign Out", @"") style:UIBarButtonItemStyleBordered target:self action:@selector(logOut)] autorelease];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    self.cards = [NSArray array];
    
    if ([OrcaCredentials hasCredentials])
    {
        [self logIn];
    }
    else
    {
        [self displayLoginViewController];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - LoginManagerDelegate

- (void)loginDidFinish
{
    [[OrcaAPIClient sharedClient] retrieveCards:^(id response) {
        self.cards = response;
        [self.tableView reloadData];
        self.navigationItem.rightBarButtonItem.enabled = YES;
        [SVProgressHUD dismissWithSuccess:NSLocalizedString(@"All Done!", @"") afterDelay:.5f];
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"") message:[error localizedDescription] delegate:nil cancelButtonTitle:NSLocalizedString(@"Dismiss", @"") otherButtonTitles:nil] autorelease];
        [alert show];
    }];
}

- (void)loginDidFail
{
    [self logOut];
    
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Login Failed", @"") message:NSLocalizedString(@"Unable to log you in. Please check your username and password and try again.", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"Dismiss", @"") otherButtonTitles:nil] autorelease];
    [alert show];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

#pragma mark - LoginViewControllerDelegate

- (void)didStoreUsernamePassword
{
    [self logIn];
}

#pragma mark - Private Methods

- (void)logIn
{
    [SVProgressHUD showInView:self.view];
    
    lm = [[LoginManager alloc] init];
    lm.delegate = self;
    [lm loginWithUsername:[OrcaCredentials username]
                 password:[OrcaCredentials password]];
}

- (void)logOut
{
    [OrcaCredentials logOut];
    self.cards = [NSArray array];
    [self.tableView reloadData];
    [self displayLoginViewController];
}

- (void)displayLoginViewController;
{
    LoginViewController *login = [[[LoginViewController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
    login.delegate = self;
    UINavigationController *nav = [[[UINavigationController alloc] initWithRootViewController:login] autorelease];
    [self presentModalViewController:nav animated:YES];
}

#pragma mark - UITableView

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return NSLocalizedString(@"My Cards", @"");
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return NSLocalizedString(@"Created by Aaron Brethorst. In no way approved by the Orca Card people. Uses SVProgressHUD, AFNetworking, SFHFKeychain, XPathQuery, JSONKit.\n\nSee http://bit.ly/orca-ios for more.", @"");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cards count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    Card *c = [self.cards objectAtIndex:indexPath.row];
    
    if (c.cardNickname && ![c.cardNickname isEqual:@""])
    {
        cell.textLabel.text = [NSString stringWithFormat:@"%@ (%@)", c.cardNickname, c.cardID];
    }
    else
    {
        cell.textLabel.text = c.cardID;
    }
    
    cell.detailTextLabel.text = c.balance;
    
    return cell;
}

- (void)dealloc
{
    self.cards = nil;
    
    [lm release];
    
    [super dealloc];
}

@end
