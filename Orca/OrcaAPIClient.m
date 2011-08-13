//
//  OrcaAPIClient.m
//  Orca
//
//  Created by Aaron Brethorst on 8/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OrcaAPIClient.h"
#import "XPathQuery.h"

static OrcaAPIClient *_sharedClient = nil;

NSString * const kOrcaBaseURLString = @"http://www.orcacard.com/";

@implementation OrcaAPIClient

#pragma mark - API

- (void)retrieveCards:(void (^)(id response))success failure:(void (^)(NSError *error))failure
{
    [[OrcaAPIClient sharedClient] getPath:@"ERG-Seattle/p7_002ad.do" parameters:[NSDictionary dictionary] success:^(id response) {
        
        // How many rows are there in the first table?
        int numberOfCards = [PerformHTMLXPathQuery(response, @"//table[@class='data'][1]//tbody/tr") count];
        
        NSMutableArray *cards = [NSMutableArray arrayWithCapacity:numberOfCards];
        
        for (int i=1; i<=numberOfCards;i++)
        {
            NSString *expression = [NSString stringWithFormat:@"//table[@class='data'][1]//tbody/tr[%d]", i];
            NSArray *result = PerformHTMLXPathQuery(response, expression);
            
            Card *card = [[Card alloc] init];
            
            card.cardID = [[[[[[result objectAtIndex:0] objectForKey:@"nodeChildArray"] objectAtIndex:0] objectForKey:@"nodeChildArray"] objectAtIndex:0] objectForKey:@"nodeContent"];
            card.cardNickname = [[[[result objectAtIndex:0] objectForKey:@"nodeChildArray"] objectAtIndex:1] objectForKey:@"nodeContent"];
            card.passengerType = [[[[result objectAtIndex:0] objectForKey:@"nodeChildArray"] objectAtIndex:2] objectForKey:@"nodeContent"];
            card.balance = [[[[result objectAtIndex:0] objectForKey:@"nodeChildArray"] objectAtIndex:3] objectForKey:@"nodeContent"];
            card.cardStatus = [[[[result objectAtIndex:0] objectForKey:@"nodeChildArray"] objectAtIndex:4] objectForKey:@"nodeContent"];
 
            [cards addObject:card];
            [card release];
        }
        
        success(cards);
        
    } failure:failure];
}

#pragma mark - Base Methods

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
	[request setAllHTTPHeaderFields:headers];
    
	return request;
}

@end
