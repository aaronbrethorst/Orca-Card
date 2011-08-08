//
//  OrcaAPIClient.m
//  Orca
//
//  Created by Aaron Brethorst on 8/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OrcaAPIClient.h"

static OrcaAPIClient *_sharedClient = nil;

NSString * const kOrcaBaseURLString = @"http://www.orcacard.com/";

@implementation OrcaAPIClient

+ (id)sharedClient
{
    if (_sharedClient == nil)
    {
        @synchronized(self)
        {
            _sharedClient = [[self alloc] init];
        }
    }
    
    return _sharedClient;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        //
    }
    return self;
}

+ (NSURL *)baseURL
{
    return [NSURL URLWithString:kOrcaBaseURLString];
}

@end
