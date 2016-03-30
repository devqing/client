//
//  SharkApiPresubmitOrderManager.h
//  customer-ios
//
//  Created by liuweiqing on 15/12/4.
//  Copyright (c) 2015年 Leoc O'Cear. All rights reserved.
//

#import "RTApiBaseManager.h"

extern NSString * const kSharkApiPresubmitOrderManagerRequestPramsUserToken;
extern NSString * const kSharkApiPresubmitOrderManagerRequestPramsUid;
extern NSString * const kSharkApiPresubmitOrderManagerRequestPramsServerToken;
extern NSString * const kSharkApiPresubmitOrderManagerRequestPramsSid;
extern NSString * const kSharkApiPresubmitOrderManagerRequestPramsGoods;

@interface SharkApiPresubmitOrderManager : RTApiBaseManager<RTAPIManager,RTAPIManagerValidator>

@end
