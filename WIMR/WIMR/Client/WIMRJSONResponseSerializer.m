//
//  WIMRJSONResponseSerializer.m
//  WIMR
//
//  Created by Maddy Patel on 7/13/15.
//  Copyright (c) 2015 Maddy Patel. All rights reserved.
//

#import "WIMRJSONResponseSerializer.h"
#import "Constants.h"

@implementation WIMRJSONResponseSerializer
/**
 Overrides the AFJSONResponseSerializer responseObjectForResponse method to add the data
 from the response body to the userInfo object of the error object
 */
- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
{
    id JSONObject = [super responseObjectForResponse:response data:data error:error];
    if (*error != nil) {
        id JSON = data ? [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil] : nil;
        if ([data length] > 100)
        {
            error = nil;
            return (JSON);
        }
        NSMutableDictionary *userInfo = [(*error).userInfo mutableCopy];
        userInfo[kJSONErrorResponseKey] = JSON ? JSON : [NSMutableDictionary new];
        NSError *newError = [NSError errorWithDomain:(*error).domain code:(*error).code userInfo:userInfo];
        (*error) = newError;

    }
    
    return (JSONObject);
}

@end
