//
//  LoginViewController.h
//  Orca
//
//  Created by Aaron Brethorst on 8/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginViewControllerDelegate <NSObject>
- (void)loginDidFinish;
@end

@interface LoginViewController : UIViewController
@property(nonatomic,assign) id<LoginViewControllerDelegate> delegate;
@property(nonatomic,retain) IBOutlet UIWebView *webView;
@end
