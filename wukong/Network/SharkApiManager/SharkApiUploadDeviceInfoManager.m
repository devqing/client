//
//  SharkApiUploadDeviceInfoManager.m
//  customer-ios
//
//  Created by liuweiqing on 16/1/14.
//  Copyright © 2016年 Leoc O'Cear. All rights reserved.
//

#import "SharkApiUploadDeviceInfoManager.h"

@implementation SharkApiUploadDeviceInfoManager

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
    return @"api.device";
}

- (NSString *)serviceType
{
    return @"kAXServiceShark";
}

- (RTAPIManagerRequestType)requestType
{
    return RTAPIManagerRequestTypePost;
}

#pragma mark --public method
- (void)loadNextPage
{
    if (self.isLoading) {
        return;
    }
    [self loadData];
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
