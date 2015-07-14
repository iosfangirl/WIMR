//
//  WIMRClient.h
//  WIMR
//
//  Created by Maddy Patel on 7/13/15.
//  Copyright (c) 2015 Maddy Patel. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"
#import "Constants.h"
#import "WIMRJSONResponseSerializer.h"

@interface WIMRClient : AFHTTPRequestOperationManager

/**
 Singleton instance of the HTTP client
 */
+ (instancetype)sharedClient;

/**
 Make http request.
 */
-(void)getMembersData:(JSONResultBlock)success
                  url:(NSString *)urlString
           parameters:(id)parameters
              failure:(ErrorResultBlock)failure;


@end
