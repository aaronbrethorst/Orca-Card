//
//  OrcaCredentials.h
//  Orca
//
//  Created by Aaron Brethorst on 8/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFHFKeychainUtils.h"

@interface OrcaCredentials : NSObject
+ (NSString*)username;
+ (NSString*)password;
+ (BOOL)hasCredentials;
+ (void)logOut;
+ (void)setUsername:(NSString*)aUsername password:(NSString*)aPassword;
@end
