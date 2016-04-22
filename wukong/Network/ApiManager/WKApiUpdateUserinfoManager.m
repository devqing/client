//
//  WKApiUpdateUserinfoManager.m
//  wukong
//
//  Created by liuweiqing on 16/4/18.
//  Copyright © 2016年 RT. All rights reserved.
//

#import "WKApiUpdateUserinfoManager.h"

@implementation WKApiUpdateUserinfoManager

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
    return @"api.update_userinfo";
}

- (NSString *)serviceType
{
    return @"kAXServiceWK";
}

- (RTAPIManagerRequestType)requestType
{
    return RTAPIManagerRequestTypePUT;
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
