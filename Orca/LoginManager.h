//
//  LoginManager.h
//  Orca
//
//  Created by Aaron Brethorst on 8/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SFHFKeychainUtils.h"

@protocol LoginManagerDelegate <NSObject>
- (void)loginDidFinish;
- (void)loginDidFail;
@end

typedef enum _LoginManagerRequestState {
    LMNotStarted = 0,
    LMRequestingLoginPage = 1,
    LMSubmittingCredentials = 2,
    LMErroredOut = 3,
} LoginManagerRequestState;

@interface LoginManager : NSObject <UIWebViewDelegate>
{
    UIWebView *webView;
    LoginManagerRequestState requestState;
}
@property(nonatomic,retain) NSString *username;
@property(nonatomic,retain) NSString *password;
@property(nonatomic,assign) id<LoginManagerDelegate> delegate;
- (void)loginWithUsername:(NSString*)aUsername password:(NSString*)aPassword;
@end
