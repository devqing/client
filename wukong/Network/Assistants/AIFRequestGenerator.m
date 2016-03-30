//
//  AIFRequestGenerator.m
//  customer-ios
//
//  Created by liuweiqing on 15/12/2.
//  Copyright (c) 2015年 Leoc O'Cear. All rights reserved.
//

#import "AIFRequestGenerator.h"
#import <AFNetworking.h>
#import "AIFLogger.h"
#import "AIFService.h"
#import "AIFServiceFactory.h"
#import "AIFSignatureGenerator.h"
#import "AIFCommonParamsGenerator.h"
#import "NSDictionary+AIFNetworkingMethods.h"
#import "NSURLRequest+AIFNetworkingMethods.h"
#import "NSObject+AIFNetworkingMethods.h"

@interface AIFRequestGenerator()

@property (nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;

@end

@implementation AIFRequestGenerator

#pragma mark - getters and setters
- (AFHTTPRequestSerializer *)httpRequestSerializer
{
    if (_httpRequestSerializer == nil) {
        _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
        _httpRequestSerializer.timeoutInterval = kAIFNetworkingTimeoutSeconds;
        _httpRequestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    }
    return _httpRequestSerializer;
}

#pragma mark - public methods
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static AIFRequestGenerator *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AIFRequestGenerator alloc] init];
    });
    return sharedInstance;
}

- (NSURLRequest *)generateGETRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName
{
    AIFService *service = [[AIFServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    NSMutableDictionary *allParams = [NSMutableDictionary dictionaryWithDictionary:[AIFCommonParamsGenerator commonParamsDictionary]];
    [allParams addEntriesFromDictionary:requestParams];
    NSString *urlString = [NSString stringWithFormat:@"%@%@", service.apiBaseUrl, methodName];
    
    NSURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"GET" URLString:urlString parameters:allParams error:NULL];
    request.requestParams = allParams;
    [AIFLogger logDebugInfoWithRequest:request apiName:methodName service:service requestParams:allParams httpMethod:@"GET"];
    return request;
}

- (NSURLRequest *)generatePOSTRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName
{
    AIFService *service = [[AIFServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    NSMutableDictionary *allParams = [NSMutableDictionary dictionaryWithDictionary:[AIFCommonParamsGenerator commonParamsDictionary]];
    [allParams addEntriesFromDictionary:requestParams];
    NSString *urlString = [NSString stringWithFormat:@"%@%@", service.apiBaseUrl, methodName];
    
    NSURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"POST" URLString:urlString parameters:allParams error:NULL];
    request.requestParams = allParams;
    [AIFLogger logDebugInfoWithRequest:request apiName:methodName service:service requestParams:requestParams httpMethod:@"POST"];
    return request;
}

- (NSURLRequest *)generateDELETERequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName
{
    AIFService *service = [[AIFServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    NSMutableDictionary *allParams = [NSMutableDictionary dictionaryWithDictionary:[AIFCommonParamsGenerator commonParamsDictionary]];
    [allParams addEntriesFromDictionary:requestParams];
    NSString *urlString = [NSString stringWithFormat:@"%@%@", service.apiBaseUrl, methodName];
    
    NSURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"DELETE" URLString:urlString parameters:allParams error:NULL];
    request.requestParams = allParams;
    [AIFLogger logDebugInfoWithRequest:request apiName:methodName service:service requestParams:requestParams httpMethod:@"DELETE"];
    return request;
}

- (NSURLRequest *)generatePUTRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName
{
    AIFService *service = [[AIFServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    NSMutableDictionary *allParams = [NSMutableDictionary dictionaryWithDictionary:[AIFCommonParamsGenerator commonParamsDictionary]];
    [allParams addEntriesFromDictionary:requestParams];
    NSString *urlString = [NSString stringWithFormat:@"%@%@", service.apiBaseUrl, methodName];
    
    NSURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"PUT" URLString:urlString parameters:allParams error:NULL];
    request.requestParams = allParams;
    [AIFLogger logDebugInfoWithRequest:request apiName:methodName service:service requestParams:requestParams httpMethod:@"PUT"];
    return request;
}

@end
