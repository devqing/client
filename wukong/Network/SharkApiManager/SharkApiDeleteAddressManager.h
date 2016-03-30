//
//  SharkApiDeleteAddressManager.h
//  customer-ios
//
//  Created by liuweiqing on 16/1/13.
//  Copyright © 2016年 Leoc O'Cear. All rights reserved.
//

#import "RTApiBaseManager.h"

extern NSString * const kSharkApiDeleteAddressManagerRequestPramsUserToken;
extern NSString * const kSharkApiDeleteAddressManagerRequestPramsUid;
extern NSString * const kSharkApiDeleteAddressManagerRequestPramsServerToken;
extern NSString * const kSharkApiDeleteAddressManagerRequestPramsId;

@interface SharkApiDeleteAddressManager : RTApiBaseManager<RTAPIManager,RTAPIManagerValidator>

@end
