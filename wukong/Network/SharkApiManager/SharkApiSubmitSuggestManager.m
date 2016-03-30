//
//  SharkApiSubmitSuggestManager.m
//  customer-ios
//
//  Created by liuweiqing on 15/12/8.
//  Copyright (c) 2015年 Leoc O'Cear. All rights reserved.
//

#import "SharkApiSubmitSuggestManager.h"

NSString * const kSharkApiSubmitSuggestManagerRequestPramsLongitude = @"longitude";
NSString * const kSharkApiSubmitSuggestManagerRequestPramsLatitude = @"latitude";
NSString * const kSharkApiSubmitSuggestManagerRequestPramsUserToken = @"user_token";
NSString * const kSharkApiSubmitSuggestManagerRequestPramsServerToken = @"server_token";
NSString * const kSharkApiSubmitSuggestManagerRequestPramsUid = @"uid";
NSString * const kSharkApiSubmitSuggestManagerRequestPramsFeedback = @"feedback";
NSString * const kSharkApiSubmitSuggestManagerRequestPramsContact = @"contact";
NSString * const kSharkApiSubmitSuggestManagerRequestPramsAreaId = @"area_id";

@implementation SharkApiSubmitSuggestManager

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
    return @"api.feedback";
}

- (NSString *)serviceType
{
    return @"kAXServiceShark";
}

- (RTAPIManagerRequestType)requestType
{
    return RTAPIManagerRequestTypePost;
}


#pragma mark --RTAPIManagerValidator
- (BOOL)manager:(RTApiBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data
{
    return YES;
}
- (BOOL)manager:(RTApiBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data
{
    return YES;
}
@end
