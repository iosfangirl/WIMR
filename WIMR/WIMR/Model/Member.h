//
//  Representative.h
//  WIMR
//
//  Created by Maddy Patel on 7/13/15.
//  Copyright (c) 2015 Maddy Patel. All rights reserved.
//

#import "WIMRModel.h"

typedef enum {
    MEMBER_TYPE_REPRESNTATIVE,
    MEMBER_TYPE_SENATOR,
} MEMBER_TYPE;

@interface Member : WIMRModel

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *district;
@property (strong, nonatomic) NSString *link;
@property (strong, nonatomic) NSString *office;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *party;
@property (assign, nonatomic) MEMBER_TYPE type;

/**
 Get all members @pram zipcode. You can also take parameter as Member class if you want to send multiple param in future.
 */
- (void)getAllMember:(NSString *)zipCode completion:(void(^)(NSArray *members))completion;

/**
 Get all representative @pram name
 */
- (void)getAllRepresentativeByName:(NSString *)name completion:(void(^)(NSArray *representatives))completion;

/**
 Get all representative @pram state
 */
- (void)getAllRepresentativeByState:(NSString *)state completion:(void(^)(NSArray *representatives))completion;

/**
 Get all Senator @pram name
 */
- (void)getAllSenatorByName:(NSString *)name completion:(void(^)(NSArray *senators))completion;

/**
 Get all Senator @pram state
 */
- (void)getAllSenatorByState:(NSString *)state completion:(void(^)(NSArray *senators))completion;

@end
