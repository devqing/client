//
//  SharkApiGetNotificationListManager.m
//  customer-ios
//
//  Created by liuweiqing on 16/3/21.
//  Copyright © 2016年 Leoc O'Cear. All rights reserved.
//

#import "SharkApiGetNotificationListManager.h"

@implementation SharkApiGetNotificationListManager

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
    return @"api.notification";
}

- (NSString *)serviceType
{
    return @"kAXServiceShark";
}

- (RTAPIManagerRequestType)requestType
{
    return RTAPIManagerRequestTypeGet;
}

- (void)loadNextPage
{
    if (self.isLoading) {
        return;
    }
    [self loadData];
}

//- (NSDictionary *)reformParams:(NSDictionary *)params
//{
//    return nil;
//}

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
