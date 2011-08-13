//
//  OrcaCredentials.m
//  Orca
//
//  Created by Aaron Brethorst on 8/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

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
