//
//  SharkApiSearchAreas.h
//  customer-ios
//
//  Created by liuweiqing on 15/12/4.
//  Copyright (c) 2015年 Leoc O'Cear. All rights reserved.
//

#import "RTApiBaseManager.h"

extern NSString * const kSharkApiSearchAreasManagerRequestPramsName;
extern NSString * const kSharkApiSearchAreasManagerRequestPramsCity;

@interface SharkApiSearchAreasManager : RTApiBaseManager<RTAPIManagerValidator,RTAPIManager>

@end
