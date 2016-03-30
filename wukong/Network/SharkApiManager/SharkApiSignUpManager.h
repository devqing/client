//
//  SharkApiSignUpManager.h
//  customer-ios
//
//  Created by liuweiqing on 15/12/4.
//  Copyright (c) 2015年 Leoc O'Cear. All rights reserved.
//

#import "RTApiBaseManager.h"

extern NSString * const kSharkApiSignUpManagerRequestPramsMobile;
extern NSString * const kSharkApiSignUpManagerRequestPramsCode;
extern NSString * const kSharkApiSignUpManagerRequestPramsPassWord;
extern NSString * const kSharkApiSignUpManagerRequestPramsInviteCode;
extern NSString * const kSharkApiSignUpManagerRequestPramsRDID;

@interface SharkApiSignUpManager : RTApiBaseManager<RTAPIManager,RTAPIManagerValidator>

@end
