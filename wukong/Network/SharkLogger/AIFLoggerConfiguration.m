//
//  SharkLoggerConfiguration.m
//  customer-ios
//
//  Created by liuweiqing on 15/12/2.
//  Copyright (c) 2015年 Leoc O'Cear. All rights reserved.
//

#import "AIFLoggerConfiguration.h"
#import "AIFAPPContext.h"

@implementation AIFLoggerConfiguration

- (void)configWithAppType:(AIFAppType)appType
{
    switch (appType) {
        case AIFAppTypeAnjuke:
            self.channelID = [AIFAPPContext sharedInstance].channelID;
            self.appKey = @"appKey";
            self.logAppName = [AIFAPPContext sharedInstance].appName;
            self.serviceType = @"ahah";
            self.sendLogMethod = @"admin.writeAppLog";
            self.sendActionMethod = @"admin.recordaction";
            self.sendLogKey = @"data";
            self.sendActionKey = @"action_note";
            break;
            
        case AIFAppTypeBroker:
            self.channelID = [AIFAPPContext sharedInstance].channelID;
            self.appKey = @"appKey";
            self.logAppName = [AIFAPPContext sharedInstance].appName;
            self.serviceType = @"ahah";
            self.sendLogMethod = @"admin.writeAppLog";
            self.sendActionMethod = @"nlog/";
            self.sendLogKey = @"data";
            self.sendActionKey = @"log";
            break;
            
        default:
            self.channelID = [AIFAPPContext sharedInstance].channelID;
            self.appKey = @"appKey";
            self.logAppName = [AIFAPPContext sharedInstance].appName;
            self.serviceType = @"ahah";
            self.sendLogMethod = @"admin.writeAppLog";
            self.sendActionMethod = @"admin.recordaction";
            self.sendLogKey = @"data";
            self.sendActionKey = @"action_note";
            break;
    }
}

@end
