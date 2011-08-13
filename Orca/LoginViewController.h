//
//  LoginViewController.h
//  Orca
//
//  Created by Aaron Brethorst on 8/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginViewControllerDelegate <NSObject>
- (void)didStoreUsernamePassword;
@end

@interface LoginViewController : UITableViewController <UITextFieldDelegate>
{
    UITableViewCell *usernameCell;
    UITableViewCell *passwordCell;
    UITableViewCell *buttonCell;
    
    UITextField *username;
    UITextField *password;
}
@property(nonatomic,assign) id<LoginViewControllerDelegate> delegate;
- (IBAction)storeCredentials:(id)sender;
@end
