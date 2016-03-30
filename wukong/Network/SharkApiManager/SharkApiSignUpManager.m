//
//  SharkApiSignUpManager.m
//  customer-ios
//
//  Created by liuweiqing on 15/12/4.
//  Copyright (c) 2015年 Leoc O'Cear. All rights reserved.
//

#import "SharkApiSignUpManager.h"

NSString * const kSharkApiSignUpManagerRequestPramsMobile = @"mobile";
NSString * const kSharkApiSignUpManagerRequestPramsCode = @"code";
NSString * const kSharkApiSignUpManagerRequestPramsPassWord = @"password";
NSString * const kSharkApiSignUpManagerRequestPramsInviteCode = @"invite_code";
NSString * const kSharkApiSignUpManagerRequestPramsRDID = @"rdid";

@implementation SharkApiSignUpManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.validator = self;
    }
    return self;
}

- (NSString *)methodName
{
    return @"api.signup";
}

- (NSString *)serviceType
{
    return @"kAXServiceShark";
}

- (RTAPIManagerRequestType)requestType
{
    return RTAPIManagerRequestTypePost;
}

#pragma mark --SharkAPIManagerValidator
- (BOOL)manager:(RTApiBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data
{
    if ([data[@"flag"] isEqualToString:@"ok"]) {
        return YES;
    }
    return NO;
}

- (BOOL)manager:(RTApiBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data
{
    NSLog(@"%@",data);
    return YES;
}

@end
