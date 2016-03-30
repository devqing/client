//
//  SharkApiResetPasswordManager.h
//  customer-ios
//
//  Created by liuweiqing on 15/12/4.
//  Copyright (c) 2015年 Leoc O'Cear. All rights reserved.
//

#import "RTApiBaseManager.h"

extern NSString * const kSharkApiResetPasswordManagerRequestPramsMobile;
extern NSString * const kSharkApiResetPasswordManagerRequestPramsCode;
extern NSString * const kSharkApiResetPasswordManagerRequestPramsPassWord;

@interface SharkApiResetPasswordManager : RTApiBaseManager<RTAPIManager,RTAPIManagerValidator>

@end
