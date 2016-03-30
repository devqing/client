//
//  SharkApiCreatAddressManager.h
//  customer-ios
//
//  Created by liuweiqing on 16/1/13.
//  Copyright © 2016年 Leoc O'Cear. All rights reserved.
//

#import "RTApiBaseManager.h"

extern NSString * const kSharkApiCreatAddressManagerRequestPramsUserToken;
extern NSString * const kSharkApiCreatAddressManagerRequestPramsUid;
extern NSString * const kSharkApiCreatAddressManagerRequestPramsServerToken;
extern NSString * const kSharkApiCreatAddressManagerRequestPramsName;
extern NSString * const kSharkApiCreatAddressManagerRequestPramsMobile;
extern NSString * const kSharkApiCreatAddressManagerRequestPramsAddress;
extern NSString * const kSharkApiCreatAddressManagerRequestPramsAreaId;
extern NSString * const kSharkApiCreatAddressManagerRequestPramsBuildingId;


@interface SharkApiCreatAddressManager : RTApiBaseManager<RTAPIManagerValidator,RTAPIManager>

@end
