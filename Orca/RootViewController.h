//
//  RootViewController.h
//  Orca
//
//  Created by Aaron Brethorst on 8/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "LoginViewController.h"
#import "LoginManager.h"

@interface RootViewController : UITableViewController <LoginManagerDelegate> // <LoginViewControllerDelegate>
{
    LoginManager *lm;
}
@end
