//
//  NetworkingConfig.h
//  customer-ios
//
//  Created by liuweiqing on 15/12/4.
//  Copyright (c) 2015年 Leoc O'Cear. All rights reserved.
//

#ifndef customer_ios_AIFNetworkingConfig_h
#define customer_ios_AIFNetworkingConfig_h

typedef NS_ENUM(NSInteger, AIFAppType) {
    AIFAppTypeAnjuke,
    AIFAppTypeBroker,
    AIFAppTypeAifang,
    AIFAppTypeErShouFang,
    AIFAppTypeHaozu
};

//typedef NS_ENUM(BOOL,kAIFShouldCache) {
//    kAIFShouldCacheYES = YES,
//    kAIFShouldCacheNO = NO
//};

typedef NS_ENUM(NSUInteger, AIFURLResponseStatus)
{
    AIFURLResponseStatusSuccess,       // 作为底层，请求是否成功只考虑是否成功收到服务器反馈。至于签名是否正确，返回的数据是否完整，由上层的RTApiBaseManager来决定。
    AIFURLResponseStatusErrorTimeout,  // 请求超时
    AIFURLResponseStatusErrorNoNetwork // 默认除了超时以外的错误都是无网络错误。
};
static NSTimeInterval kAIFNetworkingTimeoutSeconds = 20.0f;

static NSString *AIFKeychainServiceName = @"com.anjukeApps";
static NSString *AIFUDIDName = @"anjukeAppsUDID";
static NSString *AIFPasteboardType = @"anjukeAppsContent";

static BOOL kAIFShouldCache = NO;

static NSTimeInterval kAIFCacheOutdateTimeSeconds = 300; // 5分钟的cache过期时间
static NSUInteger kAIFCacheCountLimit = 1000; // 最多1000条cache

//shark
extern NSString * const kAIFServiceShark;



#endif
