//
//  OrcaAPIClient.h
//  Orca
//
//  Created by Aaron Brethorst on 8/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFRestClient.h"

extern NSString * const kOrcaBaseURLString;

@interface OrcaAPIClient : AFRestClient
+ (id)sharedClient;
@end

