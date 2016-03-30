//
//  SharkApiGetAddressManager.h
//  customer-ios
//
//  Created by liuweiqing on 16/1/13.
//  Copyright © 2016年 Leoc O'Cear. All rights reserved.
//

#import "RTApiBaseManager.h"

extern NSString * const kSharkApiGetAddressManagerRequestPramsUserToken;
extern NSString * const kSharkApiGetAddressManagerRequestPramsUid;
extern NSString * const kSharkApiGetAddressManagerRequestPramsServerToken;
extern NSString * const kSharkApiGetAddressManagerRequestPramsLimit;
extern NSString * const kSharkApiGetAddressManagerRequestPramsSkip;

@interface SharkApiGetAddressManager : RTApiBaseManager<RTAPIManager,RTAPIManagerValidator>

@end
