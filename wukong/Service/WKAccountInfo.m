//
//  WKAccountInfo.m
//  wukong
//
//  Created by liuweiqing on 16/4/7.
//  Copyright © 2016年 RT. All rights reserved.
//

#import "WKAccountInfo.h"

@implementation WKAccountInfo

+ (WKAccountInfo *)sharedInstance {
    static WKAccountInfo *sharedInstance = nil;
    static dispatch_once_t onePredicate;
    dispatch_once(&onePredicate, ^{
        sharedInstance = [self alloc];
        sharedInstance = [sharedInstance init];
    });
    return sharedInstance;
}

- (instancetype)init {
    if (nil == self) {
        self = [self init];
    }
    return self;
}
- (void)setAccount:(NSDictionary *)account
{
    self.rongyunToken = account[@"token"];
    self.serverToken = account[@"server_token"];
    self.uid = account[@"_id"];
    self.nikeName = account[@"nike_name"];
    [[NSUserDefaults standardUserDefaults] setObject:account forKey:@"Account"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)uid
{
    NSDictionary *account = [[NSUserDefaults standardUserDefaults] objectForKey:@"Account"];
    return account[@"_id"];
}

- (NSString *)nikeName
{
    NSDictionary *account = [[NSUserDefaults standardUserDefaults] objectForKey:@"Account"];
    return account[@"nike_name"];
}

- (NSString *)serverToken
{
    NSDictionary *account = [[NSUserDefaults standardUserDefaults] objectForKey:@"Account"];
    return account[@"server_token"];
}

- (NSString *)rongyunToken
{
    NSDictionary *account = [[NSUserDefaults standardUserDefaults] objectForKey:@"Account"];
    return account[@"token"];
}

- (BOOL)isLoginToLocal
{
    NSDictionary *account = [[NSUserDefaults standardUserDefaults] objectForKey:@"Account"];
    if (account) {
        return YES;
    }
    return NO;
}

- (void)loginOut
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Account"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
