//
//  SharkServiceFactory.h
//  customer-ios
//
//  Created by liuweiqing on 15/12/2.
//  Copyright (c) 2015年 Leoc O'Cear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AIFService.h"

@interface AIFServiceFactory : NSObject

+ (instancetype)sharedInstance;
- (AIFService<AIFServiceProtocal> *)serviceWithIdentifier:(NSString *)identifier;

@end
