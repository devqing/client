//
//  WKApiAcceptFriendManager.m
//  wukong
//
//  Created by liuweiqing on 16/4/13.
//  Copyright © 2016年 RT. All rights reserved.
//

#import "WKApiAcceptFriendManager.h"

@implementation WKApiAcceptFriendManager

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
    return @"api.accept";
}

- (NSString *)serviceType
{
    return @"kAXServiceWK";
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
