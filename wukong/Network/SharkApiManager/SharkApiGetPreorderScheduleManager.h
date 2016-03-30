//
//  SharkApiGetPreorderScheduleManager.h
//  customer-ios
//
//  Created by liuweiqing on 16/1/19.
//  Copyright © 2016年 Leoc O'Cear. All rights reserved.
//

#import "RTApiBaseManager.h"

extern NSString * const kSharkApiGetPreorderScheduleManagerRequestPramsUserToken;
extern NSString * const kSharkApiGetPreorderScheduleManagerRequestPramsUid;
extern NSString * const kSharkApiGetPreorderScheduleManagerRequestPramsServerToken;
extern NSString * const kSharkApiGetPreorderScheduleManagerRequestPramsSid;

@interface SharkApiGetPreorderScheduleManager : RTApiBaseManager<RTAPIManager,RTAPIManagerValidator>

@end
