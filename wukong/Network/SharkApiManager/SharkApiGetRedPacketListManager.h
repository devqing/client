//
//  SharkApiGetRedPacketListManager.h
//  customer-ios
//
//  Created by liuweiqing on 15/12/2.
//  Copyright (c) 2015年 Leoc O'Cear. All rights reserved.
//

#import "RTApiBaseManager.h"

@interface SharkApiGetRedPacketListManager : RTApiBaseManager<RTAPIManager,RTAPIManagerValidator>

- (void)loadNextPage;

@end
