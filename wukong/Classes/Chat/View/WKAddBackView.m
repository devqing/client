//
//  WKAddBackView.m
//  wukong
//
//  Created by liuweiqing on 16/4/8.
//  Copyright © 2016年 RT. All rights reserved.
//

#import "WKAddBackView.h"


@interface WKAddBackView()



@end

@implementation WKAddBackView

#pragma mark --life cycle
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.addView];
    }
    return self;
}

#pragma mark --getter&setter
- (WKChatAddView *)addView
{
    if (_addView == nil) {
        _addView = [[WKChatAddView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH-150, 0, 150, 184)];
    }
    return _addView;
}

@end
