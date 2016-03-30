//
//  NSDictionary+SharkNetworkingMethods.h
//  customer-ios
//
//  Created by liuweiqing on 15/12/2.
//  Copyright (c) 2015年 Leoc O'Cear. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (AIFNetworkingMethods)

- (NSString *)AIF_urlParamsStringSignature:(BOOL)isForSignature;
- (NSString *)AIF_jsonString;
- (NSArray *)AIF_transformedUrlParamsArraySignature:(BOOL)isForSignature;

@end
