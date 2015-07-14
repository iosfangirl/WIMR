//
//  WIMRClient.m
//  WIMR
//
//  Created by Maddy Patel on 7/13/15.
//  Copyright (c) 2015 Maddy Patel. All rights reserved.
//

#import "WIMRClient.h"


@implementation WIMRClient

/**
 Init the singleton
 */
+ (instancetype)sharedClient {
    static id shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [WIMRClient new];
    });
    
    return shared;
}

/**
 Set up the base URL
 */
- (id)init {
    self = [super initWithBaseURL:[NSURL URLWithString:kWIMRResourceUrl]];

    self.requestSerializer = [AFHTTPRequestSerializer serializer];
    self.responseSerializer = [WIMRJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/xml"];
    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    self.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithArray:@[@"POST"]];

    return self;
}

- (AFHTTPRequestOperation *)makeRequest:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
        NSString *urlString = [NSString stringWithFormat:@"%@%@",kWIMRResourceUrl,URLString];
    
        AFHTTPRequestOperation *operation = [self POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject){
            if (success)
        success(operation, responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSDictionary *responseDict = (NSDictionary *)operation.responseObject;
        if ([responseDict isKindOfClass:[NSDictionary class]]){
            success(operation,responseDict);
        }
        else{
            failure(operation,error);
        }
        }];
    
    return operation;
}

#pragma mark - Public Method
-(void)getMembersData:(JSONResultBlock)success
                  url:(NSString *)urlString
           parameters:(id)parameters
               failure:(ErrorResultBlock)failure{
    [self makeRequest:urlString
   parameters:parameters
      success:^(AFHTTPRequestOperation *operation, id JSON) {
          if (success)
              success(JSON);
      }
      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          if (failure)
              failure(error);
      }];
}
@end
