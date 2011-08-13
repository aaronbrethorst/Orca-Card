//
//  RootViewController.m
//  Orca
//
//  Created by Aaron Brethorst on 8/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "XPathQuery.h"

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    lm = [[LoginManager alloc] init];
    lm.delegate = self;
    [lm loginWithUsername:@"aaronbrethorst" password:@"ABE143st"];
//    LoginViewController *login = [[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil] autorelease];
//    login.delegate = self;
//    UINavigationController *nav = [[[UINavigationController alloc] initWithRootViewController:login] autorelease];
//    [self presentModalViewController:nav animated:YES];
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

#pragma mark - LoginViewControllerDelegate

- (void)loginDidFinish
{
    [[OrcaAPIClient sharedClient] getPath:@"ERG-Seattle/welcomePage.do?m=52" parameters:[NSDictionary dictionary] success:^(id response) {
        NSArray *nodes = PerformHTMLXPathQuery(response, @"//td[@class='currency']");
        NSString *textResp = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
        
        NSLog(@"Found nodes: %@", nodes);
        
    } failure:^(NSError *error) {
        NSLog(@"boo: %@", error);
    }];
    
    //    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    //    [dict setObject:@"aaronbrethorst" forKey:@"j_username"];
    //    [dict setObject:@"ABE143st" forKey:@"j_password"];
    //    
    //    [[OrcaAPIClient sharedClient] postPath:@"/ERG-Seattle/j_security_check" parameters:dict success:^(id response) {
    //        NSLog(@"%@", response);
    //    } failure:^(NSError *error) {
    //        NSLog(@"%@", error);
    //    }];
}

- (void)loginDidFail
{
    NSLog(@"");
}

#pragma mark - UITableView

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

    // Configure the cell.
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
    [super dealloc];
}

@end
