//
//  SharkApiGetGoodsInfoManager.h
//  customer-ios
//
//  Created by liuweiqing on 15/12/4.
//  Copyright (c) 2015年 Leoc O'Cear. All rights reserved.
//

#import "RTApiBaseManager.h"

extern NSString * const kSharkApiGetGoodsInfoManagerRequestPramsSid;
extern NSString * const kSharkApiGetGoodsInfoManagerRequestPramsGoodsIds;

@interface SharkApiGetGoodsInfoManager : RTApiBaseManager<RTAPIManager,RTAPIManagerValidator>

@end
