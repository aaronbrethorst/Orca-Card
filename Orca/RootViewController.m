//
//  RootViewController.m
//  Orca
//
//  Created by Aaron Brethorst on 8/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()
- (void)logIn;
@end

@implementation RootViewController
@synthesize cards;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.cards = [NSArray array];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"username"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"password"])
    {
        [self logIn];
    }
    else
    {
        LoginViewController *login = [[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil] autorelease];
        login.delegate = self;
        UINavigationController *nav = [[[UINavigationController alloc] initWithRootViewController:login] autorelease];
        [self presentModalViewController:nav animated:YES];
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
        NSLog(@"here?");
        self.cards = response;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)loginDidFail
{
    NSLog(@"");
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
    [lm loginWithUsername:[[NSUserDefaults standardUserDefaults] objectForKey:@"username"]
                 password:[[NSUserDefaults standardUserDefaults] objectForKey:@"password"]];    
}

#pragma mark - UITableView

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cards count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    Card *c = [self.cards objectAtIndex:indexPath.row];
    cell.textLabel.text = c.balance;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
	*/
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc
{
    self.cards = nil;
    
    [lm release];
    
    [super dealloc];
}

@end
