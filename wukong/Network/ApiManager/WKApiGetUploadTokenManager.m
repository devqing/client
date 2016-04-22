//
//  WKApiGetUploadTokenManager.m
//  wukong
//
//  Created by liuweiqing on 16/4/18.
//  Copyright © 2016年 RT. All rights reserved.
//

#import "WKApiGetUploadTokenManager.h"

@implementation WKApiGetUploadTokenManager

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
    return @"api.upload_token";
}

- (NSString *)serviceType
{
    return @"kAXServiceWK";
}

- (RTAPIManagerRequestType)requestType
{
    return RTAPIManagerRequestTypeGet;
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
