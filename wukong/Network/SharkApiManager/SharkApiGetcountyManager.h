//
//  SharkApiGetcountyManager.h
//  customer-ios
//
//  Created by liuweiqing on 16/1/15.
//  Copyright © 2016年 Leoc O'Cear. All rights reserved.
//

#import "RTApiBaseManager.h"

extern NSString * const kSharkApiGetcountyManagerRequestPramsLevel;
extern NSString * const kSharkApiGetcountyManagerRequestPramsDivisionName;

@interface SharkApiGetcountyManager : RTApiBaseManager<RTAPIManager,RTAPIManagerValidator>

@end
