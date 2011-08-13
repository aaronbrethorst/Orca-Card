//
//  AFDataRequestOperation.m
//  Orca
//
//  Created by Aaron Brethorst on 8/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AFDataRequestOperation.h"
#include <Availability.h>

@implementation AFDataRequestOperation

+ (id)operationWithRequest:(NSURLRequest *)urlRequest                
                   success:(void (^)(id JSON))success
{
    return [self operationWithRequest:urlRequest success:success failure:nil];
}

+ (id)operationWithRequest:(NSURLRequest *)urlRequest 
                   success:(void (^)(id JSON))success
                   failure:(void (^)(NSError *error))failure
{    
    return [self operationWithRequest:urlRequest acceptableStatusCodes:[self defaultAcceptableStatusCodes] acceptableContentTypes:[self defaultAcceptableContentTypes] success:success failure:failure];
}

+ (id)operationWithRequest:(NSURLRequest *)urlRequest
     acceptableStatusCodes:(NSIndexSet *)acceptableStatusCodes
    acceptableContentTypes:(NSSet *)acceptableContentTypes
                   success:(void (^)(id JSON))success
                   failure:(void (^)(NSError *error))failure
{
    return [self operationWithRequest:urlRequest completion:^(NSURLRequest *request, NSHTTPURLResponse *response, NSData *data, NSError *error) {        
        BOOL statusCodeAcceptable = [acceptableStatusCodes containsIndex:[response statusCode]];
        BOOL contentTypeAcceptable = YES;
        if (!statusCodeAcceptable || !contentTypeAcceptable) {
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
            [userInfo setValue:[NSHTTPURLResponse localizedStringForStatusCode:[response statusCode]] forKey:NSLocalizedDescriptionKey];
            [userInfo setValue:[request URL] forKey:NSURLErrorFailingURLErrorKey];
            
            error = [[[NSError alloc] initWithDomain:NSURLErrorDomain code:[response statusCode] userInfo:userInfo] autorelease];
        }
        
        if (error) {
            if (failure) {
                failure(error);
            }
        } else {
            if (error) {
                if (failure) {
                    failure(error);
                }
            } else {
                if (success) {
                    success(data);
                }
            }
        }
    }];
}

+ (NSIndexSet *)defaultAcceptableStatusCodes {
    return [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 100)];
}

+ (NSSet *)defaultAcceptableContentTypes {
    return [NSSet setWithObjects:@"application/json", @"application/x-javascript", @"text/javascript", @"text/x-javascript", @"text/x-json", @"text/json", @"text/plain", nil];
}

@end
