//
//  UIDevice+IdentifierAddition.h
//  customer-ios
//
//  Created by liuweiqing on 15/12/2.
//  Copyright (c) 2015年 Leoc O'Cear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (IdentifierAddition)

/*
 * @method uuid
 * @description apple identifier support iOS6 and iOS5 below
 */

- (NSString *) AIF_uuid;
- (NSString *) AIF_udid;
- (NSString *) AIF_macaddress;
- (NSString *) AIF_macaddressMD5;
- (NSString *) AIF_machineType;
- (NSString *) AIF_ostype;//显示“ios6，ios5”，只显示大版本号
- (NSString *) AIF_createUUID;

//兼容旧版本
- (NSString *) uuid;
- (NSString *) udid;
- (NSString *) macaddress;
- (NSString *) macaddressMD5;
- (NSString *) machineType;
- (NSString *) ostype;//显示“ios6，ios5”，只显示大版本号
- (NSString *) createUUID;

@end
