//
//  NSURLRequest+SharkNetworkingMethods.m
//  customer-ios
//
//  Created by liuweiqing on 15/12/2.
//  Copyright (c) 2015年 Leoc O'Cear. All rights reserved.
//

#import "NSURLRequest+AIFNetworkingMethods.h"
#import <objc/runtime.h>

static void *AIFNetworkingRequestParams;

@implementation NSURLRequest (AIFNetworkingMethods)

- (void)setRequestParams:(NSDictionary *)requestParams
{
    objc_setAssociatedObject(self, &AIFNetworkingRequestParams, requestParams, OBJC_ASSOCIATION_COPY);
}

- (NSDictionary *)requestParams
{
    return objc_getAssociatedObject(self, &AIFNetworkingRequestParams);
}


@end
