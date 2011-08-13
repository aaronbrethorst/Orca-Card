//
//  AFDataRequestOperation.h
//  Orca
//
//  Created by Aaron Brethorst on 8/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AFHTTPRequestOperation.h"

@interface AFDataRequestOperation : AFHTTPRequestOperation

+ (id)operationWithRequest:(NSURLRequest *)urlRequest                
                   success:(void (^)(id JSON))success;

+ (id)operationWithRequest:(NSURLRequest *)urlRequest 
                   success:(void (^)(id JSON))success
                   failure:(void (^)(NSError *error))failure;

+ (id)operationWithRequest:(NSURLRequest *)urlRequest
     acceptableStatusCodes:(NSIndexSet *)acceptableStatusCodes
    acceptableContentTypes:(NSSet *)acceptableContentTypes
                   success:(void (^)(id JSON))success
                   failure:(void (^)(NSError *error))failure;

+ (NSIndexSet *)defaultAcceptableStatusCodes;
+ (NSSet *)defaultAcceptableContentTypes;

@end
