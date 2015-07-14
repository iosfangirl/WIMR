//
//  Representative.m
//  WIMR
//
//  Created by Maddy Patel on 7/13/15.
//  Copyright (c) 2015 Maddy Patel. All rights reserved.
//

#import "Member.h"
#import "wimRClient.h"
#import "Constants.h"

@implementation Member

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err {
    if (self = [super initWithDictionary:dict error:err]) {
    }
    return self;
}

- (void)getAllMember:(NSString *)zipCode completion:(void(^)(NSArray *members))completion{
    [[WIMRClient sharedClient] getMembersData:^(id JSON) {
        NSDictionary *json = (NSDictionary *)JSON;
        completion([self getMemberArray:[json objectForKey:@"results"]]);
    } url:kAllMember parameters:[NSDictionary dictionaryWithObjectsAndKeys:zipCode,@"zip",@"json",@"output", nil] failure:^(NSError *error) {
    }];
}

- (void)getAllRepresentativeByName:(NSString *)name completion:(void(^)(NSArray *representatives))completion{
    [[WIMRClient sharedClient] getMembersData:^(id JSON) {
        NSDictionary *json = (NSDictionary *)JSON;
        completion([self getMemberArray:[json objectForKey:@"results"]]);
    } url:kRepByName parameters:[NSDictionary dictionaryWithObjectsAndKeys:name,@"name",@"json",@"output", nil] failure:^(NSError *error) {
    }];
}

- (void)getAllRepresentativeByState:(NSString *)state completion:(void(^)(NSArray *representatives))completion{
    [[WIMRClient sharedClient] getMembersData:^(id JSON) {
        NSDictionary *json = (NSDictionary *)JSON;
        completion([self getMemberArray:[json objectForKey:@"results"]]);
    } url:kRepByState parameters:[NSDictionary dictionaryWithObjectsAndKeys:state,@"state",@"json",@"output",nil] failure:^(NSError *error) {
    }];
}

- (void)getAllSenatorByName:(NSString *)name completion:(void(^)(NSArray *senators))completion{
    [[WIMRClient sharedClient] getMembersData:^(id JSON) {
        NSDictionary *json = (NSDictionary *)JSON;
        completion([self getMemberArray:[json objectForKey:@"results"]]);
    } url:kSenByName parameters:[NSDictionary dictionaryWithObjectsAndKeys:name,@"name",@"json",@"output",nil] failure:^(NSError *error) {
    }];
}


- (void)getAllSenatorByState:(NSString *)state completion:(void(^)(NSArray *senators))completion{
    [[WIMRClient sharedClient] getMembersData:^(id JSON) {
        NSDictionary *json = (NSDictionary *)JSON;
        completion([self getMemberArray:[json objectForKey:@"results"]]);
    } url:kSenByState parameters:[NSDictionary dictionaryWithObjectsAndKeys:state,@"state",@"json",@"output", nil] failure:^(NSError *error) {
    }];
}

-(void)setTypeForMember:(Member *)member{
    if ([member.party isEqualToString:@"R"]) {
        member.type = MEMBER_TYPE_REPRESNTATIVE;
    }
    else{
        member.type = MEMBER_TYPE_SENATOR;
    }
}

-(NSArray *)getMemberArray:(NSArray *)data{
    NSMutableArray *arrayData = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dict in data){
        Member *member = [[Member alloc] initWithDictionary:dict error:nil];
        [member setTypeForMember:member];
        [arrayData addObject:member];
    }
    return arrayData;
}
@end
