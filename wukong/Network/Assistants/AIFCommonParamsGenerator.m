//
//  SharkCommonParamsGenerator.m
//  customer-ios
//
//  Created by liuweiqing on 15/12/2.
//  Copyright (c) 2015年 Leoc O'Cear. All rights reserved.
//

#import "AIFCommonParamsGenerator.h"
#import "AIFAPPContext.h"

@implementation AIFCommonParamsGenerator

+ (NSDictionary *)commonParamsDictionary
{
    AIFAPPContext *context = [AIFAPPContext sharedInstance];
    return @{
             @"version":API_VERSION,
             @"distribution":@"nightly",
             @"platform":@"ios"
             };
}

+ (NSDictionary *)commonParamsDictionaryForLog
{
    AIFAPPContext *context = [AIFAPPContext sharedInstance];
    return @{
             @"guid":context.guid,
             @"dvid":context.dvid,
             @"net":context.net,
             @"ver":context.ver,
             @"ip":context.ip,
             @"mac":context.mac,
             @"geo":context.geo,
             @"uid":context.uid,
             @"chat_id":context.chatid,
             @"ccid":context.ccid,
             @"gcid":context.gcid,
             @"p":context.p,
             @"os":context.os,
             @"v":context.v,
             @"app":context.app,
             @"ch":context.channelID,
             @"ct":context.ct,
             @"pmodel":context.pmodel
             };
}

@end
