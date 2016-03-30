//
//  SharkApiSubmitOrderManager.h
//  customer-ios
//
//  Created by liuweiqing on 15/12/4.
//  Copyright (c) 2015年 Leoc O'Cear. All rights reserved.
//

#import "RTApiBaseManager.h"

extern NSString * const kSharkApiSubmitOrderManagerRequestPramsUserToken;
extern NSString * const kSharkApiSubmitOrderManagerRequestPramsUid;
extern NSString * const kSharkApiSubmitOrderManagerRequestPramsServerToken;
extern NSString * const kSharkApiSubmitOrderManagerRequestPramsSid;
extern NSString * const kSharkApiSubmitOrderManagerRequestPramsGoods;

@interface SharkApiSubmitOrderManager : RTApiBaseManager<RTAPIManager,RTAPIManagerValidator>

@end
