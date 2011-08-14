//
//  OrcaCredentials.m
//  Orca
//
//  Created by Aaron Brethorst on 8/13/11.

//  Copyright (c) 2011 Aaron Brethorst
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without 
//  limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following
//  conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT 
//  SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR 
//  OTHER DEALINGS IN THE SOFTWARE.


#import "OrcaCredentials.h"

@implementation OrcaCredentials

+ (BOOL)hasCredentials
{
    return ([OrcaCredentials username] && [OrcaCredentials password]);
}

+ (NSString*)username
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
}

+ (NSString*)password
{
    return [SFHFKeychainUtils getPasswordForUsername:[OrcaCredentials username] andServiceName:[[NSBundle mainBundle] bundleIdentifier] error:nil];    
}

+ (void)logOut
{
    [SFHFKeychainUtils deleteItemForUsername:[OrcaCredentials username] andServiceName:[[NSBundle mainBundle] bundleIdentifier] error:nil];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setUsername:(NSString*)aUsername password:(NSString*)aPassword
{
    [SFHFKeychainUtils storeUsername:aUsername andPassword:aPassword forServiceName:[[NSBundle mainBundle] bundleIdentifier] updateExisting:YES error:nil];
    [[NSUserDefaults standardUserDefaults] setObject:aUsername forKey:@"username"];
    [[NSUserDefaults standardUserDefaults] synchronize];    
}

@end
