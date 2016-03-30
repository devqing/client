//
//  SharkApiModifyAddressManager.h
//  customer-ios
//
//  Created by liuweiqing on 16/1/13.
//  Copyright © 2016年 Leoc O'Cear. All rights reserved.
//

#import "RTApiBaseManager.h"

extern NSString * const kSharkApiModifyAddressManagerRequestPramsUserToken;
extern NSString * const kSharkApiModifyAddressManagerRequestPramsUid;
extern NSString * const kSharkApiModifyAddressManagerRequestPramsServerToken;
extern NSString * const kSharkApiModifyAddressManagerRequestPramsName;
extern NSString * const kSharkApiModifyAddressManagerRequestPramsMobile;
extern NSString * const kSharkApiModifyAddressManagerRequestPramsAddress;
extern NSString * const kSharkApiModifyAddressManagerRequestPramsBuildingId;
extern NSString * const kSharkApiModifyAddressManagerRequestPramsId;

@interface SharkApiModifyAddressManager : RTApiBaseManager<RTAPIManager,RTAPIManagerValidator>

@end
