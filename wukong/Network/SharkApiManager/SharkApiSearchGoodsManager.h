//
//  SharkApiSearchGoodsManager.h
//  customer-ios
//
//  Created by liuweiqing on 15/12/29.
//  Copyright © 2015年 Leoc O'Cear. All rights reserved.
//

#import "RTApiBaseManager.h"

extern NSString * const kSharkApiSearchGoodsManagerRequestPramsShopId;
extern NSString * const kSharkApiSearchGoodsManagerRequestPramsSearchValue;

@interface SharkApiSearchGoodsManager : RTApiBaseManager<RTAPIManager,RTAPIManagerValidator>

@end
