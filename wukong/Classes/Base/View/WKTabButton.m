//
//  WKTabButton.m
//  wukong
//
//  Created by liuweiqing on 16/4/1.
//  Copyright © 2016年 RT. All rights reserved.
//

#import "WKTabButton.h"

#define lwqImagePercent 0.6

@implementation WKTabButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        [self setTitleColor:UIColorFromRGB(UI_COLOR_TABBAR_TEXT) forState:(UIControlStateNormal)];
        [self setTitleColor:UIColorFromRGB(UI_COLOR_TABBAR_TEXT_HL) forState:(UIControlStateSelected)];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
    
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = self.frame.size.width;
    CGFloat imageH = self.frame.size.height * lwqImagePercent;
    return  CGRectMake(0, 2, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleW = self.frame.size.width;
    CGFloat titleH = self.frame.size.height * (1 - lwqImagePercent);
    return  CGRectMake(0, self.frame.size.height * lwqImagePercent+2, titleW, titleH-2);
}
@end
