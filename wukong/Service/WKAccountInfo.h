//
//  WKAccountInfo.h
//  wukong
//
//  Created by liuweiqing on 16/4/7.
//  Copyright © 2016年 RT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKAccountInfo : NSObject

@property (nonatomic, strong) NSString *rongyunToken;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *serverToken;
@property (nonatomic, strong) NSString *nikeName;

+ (WKAccountInfo *)sharedInstance;

- (void)setAccount:(NSDictionary *)account;

- (BOOL)isLoginToLocal;

- (void)loginOut;

@end
