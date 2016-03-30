//
//  SharkApiGetCityManager.h
//  customer-ios
//
//  Created by liuweiqing on 16/1/15.
//  Copyright © 2016年 Leoc O'Cear. All rights reserved.
//

#import "RTApiBaseManager.h"

extern NSString * const kSharkApiGetCityManagerRequestPramsLevel;
extern NSString * const kSharkApiGetCityManagerRequestPramsDivisionName;

@interface SharkApiGetCityManager : RTApiBaseManager<RTAPIManager,RTAPIManagerValidator>

@end
