//
//  SharkServiceFactory.m
//  customer-ios
//
//  Created by liuweiqing on 15/12/2.
//  Copyright (c) 2015年 Leoc O'Cear. All rights reserved.
//

#import "AIFServiceFactory.h"
#import "AIFService.h"
#import "AIFServiceShark.h"

// shark
NSString * const kAIFServiceShark = @"kAXServiceWK";


@interface AIFServiceFactory()


@property (nonatomic, strong) NSMutableDictionary *serviceStorage;

@end
@implementation AIFServiceFactory


#pragma mark - getters and setters
- (NSMutableDictionary *)serviceStorage
{
    if (_serviceStorage == nil) {
        _serviceStorage = [[NSMutableDictionary alloc] init];
    }
    return _serviceStorage;
}

#pragma mark - life cycle
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static AIFServiceFactory *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AIFServiceFactory alloc] init];
    });
    return sharedInstance;
}

#pragma mark - public methods
- (AIFService<AIFServiceProtocal> *)serviceWithIdentifier:(NSString *)identifier
{
    if (self.serviceStorage[identifier] == nil) {
        self.serviceStorage[identifier] = [self newServiceWithIdentifier:identifier];
    }
    return self.serviceStorage[identifier];
}

#pragma mark - private methods
- (AIFService<AIFServiceProtocal> *)newServiceWithIdentifier:(NSString *)identifier
{
    // shark
    if ([identifier isEqualToString:kAIFServiceShark]) {
        return [[AIFServiceShark alloc] init];
    }
    
    return nil;
}

@end
