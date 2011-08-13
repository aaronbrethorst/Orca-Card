//
//  LoginManager.m
//  Orca
//
//  Created by Aaron Brethorst on 8/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LoginManager.h"

@implementation LoginManager
@synthesize username, password;
@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self)
    {
        webView = [[UIWebView alloc] initWithFrame:CGRectZero];
        webView.delegate = self;
        requestState = LMNotStarted;
    }
    
    return self;
}

- (void)dealloc
{
    self.username = nil;
    self.password = nil;
    
    self.delegate = nil;
    
    webView.delegate = nil;
    [webView release];
    
    [super dealloc];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)wv
{
    switch (requestState)
    {
        case LMNotStarted:
        {
            requestState = LMSubmittingCredentials;
            
            [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementById('main-username').value = '%@'", self.username]];
            [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementById('main-password').value = '%@'", self.password]];
            [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByName('loginform')[0].submit()"];
            
            break;
        }
        case LMSubmittingCredentials:
        {
            NSString *result = [wv stringByEvaluatingJavaScriptFromString:@"document.evaluate(\"//h2[@id='start-content']/span\", document, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null).snapshotItem().innerText"];
            
            if ([result rangeOfString:@"you're logged in"].location != NSNotFound)
            {
                [self.delegate loginDidFinish];
            }
            else
            {
                requestState = LMErroredOut;
                [self.delegate loginDidFail];
            }
            
            break;
        }
        default:
        {
            requestState = LMErroredOut;
            break;
        }
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    requestState = LMErroredOut;
}

#pragma mark - Public Methods

- (void)loginWithUsername:(NSString*)aUsername password:(NSString*)aPassword
{
    if (LMNotStarted == requestState || LMErroredOut == requestState)
    {
        self.username = aUsername;
        self.password = aPassword;
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.orcacard.com/ERG-Seattle/welcomePage.do?m=52"]];
        [webView loadRequest:request];
    }
}

@end
