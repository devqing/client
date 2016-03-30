//
//  SharkApiGetPreorderSchedulesManager.m
//  customer-ios
//
//  Created by liuweiqing on 16/1/14.
//  Copyright © 2016年 Leoc O'Cear. All rights reserved.
//

#import "SharkApiGetPreorderSchedulesManager.h"

@implementation SharkApiGetPreorderSchedulesManager

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
    return @"api.preorder.schedule";
}

- (NSString *)serviceType
{
    return @"kAXServiceShark";
}

- (RTAPIManagerRequestType)requestType
{
    return RTAPIManagerRequestTypeGet;
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
