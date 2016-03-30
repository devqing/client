//
//  SharkServiceShark.m
//  customer-ios
//
//  Created by liuweiqing on 15/12/3.
//  Copyright (c) 2015年 Leoc O'Cear. All rights reserved.
//

#import "AIFServiceShark.h"

@implementation AIFServiceShark

- (BOOL)isOnline
{
    return YES;
}

- (NSString *)onlineApiBaseUrl
{
    return SERVER_URL;
}

- (NSString *)offlineApiBaseUrl
{
    return SERVER_URL;
}

- (NSString *)onlineApiVersion
{
    return API_VERSION;
}

- (NSString *)offlineApiVersion
{
    return API_VERSION;
}

- (NSString *)onlinePrivateKey
{
    return @"无";
}

- (NSString *)onlinePublicKey
{
    return @"无";
}

- (NSString *)offlinePrivateKey
{
    return @"无";
}

- (NSString *)offlinePublicKey
{
    return @"无";
}

@end
