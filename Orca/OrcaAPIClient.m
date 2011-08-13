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

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters
{
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
	NSMutableDictionary *headers = [NSMutableDictionary dictionaryWithDictionary:self.defaultHeaders];
	NSURL *url = [NSURL URLWithString:path relativeToURL:[[self class] baseURL]];
	
    if (parameters)
    {
        NSMutableArray *mutableParameterComponents = [NSMutableArray array];
    
        for (id key in [parameters allKeys])
        {
            NSString *component = [NSString stringWithFormat:@"%@=%@", [key urlEncodedStringWithEncoding:kAFRestClientStringEncoding],
                                                                       [[parameters valueForKey:key] urlEncodedStringWithEncoding:kAFRestClientStringEncoding]];
            [mutableParameterComponents addObject:component];
        }

        NSString *queryString = [mutableParameterComponents componentsJoinedByString:@"&"];
        
        if ([method isEqualToString:@"GET"])
        {
            url = [NSURL URLWithString:[[url absoluteString] stringByAppendingFormat:[path rangeOfString:@"?"].location == NSNotFound ? @"?%@" : @"&%@", queryString]];
        }
        else
        {
            NSString *charset = (NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(kAFRestClientStringEncoding));
            [headers setObject:[NSString stringWithFormat:@"application/x-www-form-urlencoded; charset=%@", charset] forKey:@"Content-Type"];
            [request setHTTPBody:[queryString dataUsingEncoding:NSUTF8StringEncoding]];
        }
    }
    
	[request setURL:url];
	[request setHTTPMethod:method];
	[request setHTTPShouldHandleCookies:NO];
	[request setAllHTTPHeaderFields:headers];
    
	return request;
}

@end
