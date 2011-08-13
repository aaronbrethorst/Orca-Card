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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
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
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
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
    LoginViewController *login = [[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil] autorelease];
    login.delegate = self;
    UINavigationController *nav = [[[UINavigationController alloc] initWithRootViewController:login] autorelease];
    [self presentModalViewController:nav animated:YES];
}

#pragma mark - UITableView

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return NSLocalizedString(@"My Cards", @"");
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)dealloc
{
    self.cards = nil;
    
    [lm release];
    
    [super dealloc];
}

@end
