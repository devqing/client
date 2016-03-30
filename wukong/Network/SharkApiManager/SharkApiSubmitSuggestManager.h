//
//  SharkApiSubmitSuggestManager.h
//  customer-ios
//
//  Created by liuweiqing on 15/12/8.
//  Copyright (c) 2015年 Leoc O'Cear. All rights reserved.
//

#import "RTApiBaseManager.h"

extern NSString * const kSharkApiSubmitSuggestManagerRequestPramsLongitude;
extern NSString * const kSharkApiSubmitSuggestManagerRequestPramsLatitude;
extern NSString * const kSharkApiSubmitSuggestManagerRequestPramsUserToken;
extern NSString * const kSharkApiSubmitSuggestManagerRequestPramsServerToken;
extern NSString * const kSharkApiSubmitSuggestManagerRequestPramsUid;
extern NSString * const kSharkApiSubmitSuggestManagerRequestPramsFeedback;
extern NSString * const kSharkApiSubmitSuggestManagerRequestPramsContact;
extern NSString * const kSharkApiSubmitSuggestManagerRequestPramsAreaId;

@interface SharkApiSubmitSuggestManager : RTApiBaseManager<RTAPIManager,RTAPIManagerValidator>

@end
