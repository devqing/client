//
//  SharkLogger.h
//  customer-ios
//
//  Created by liuweiqing on 15/12/2.
//  Copyright (c) 2015年 Leoc O'Cear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AIFLoggerConfiguration.h"
#import "AIFURLResponse.h"
#import "AIFService.h"

@interface AIFLogger : NSObject

@property (nonatomic, strong, readonly) AIFLoggerConfiguration *configParams;

+ (void)logDebugInfoWithRequest:(NSURLRequest *)request apiName:(NSString *)apiName service:(AIFService *)service requestParams:(id)requestParams httpMethod:(NSString *)httpMethod;
+ (void)logDebugInfoWithResponse:(NSHTTPURLResponse *)response resposeString:(NSString *)responseString request:(NSURLRequest *)request error:(NSError *)error;
+ (void)logDebugInfoWithCachedResponse:(AIFURLResponse *)response methodName:(NSString *)methodName serviceIdentifier:(AIFService *)service;

+ (instancetype)sharedInstance;
- (void)logWithActionCode:(NSString *)actionCode params:(NSDictionary *)params;

@end
