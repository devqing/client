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
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        [self setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        [self setTitleColor:[UIColor orangeColor] forState:(UIControlStateSelected)];
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
    return  CGRectMake(0, 0, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleW = self.frame.size.width;
    CGFloat titleH = self.frame.size.height * (1 - lwqImagePercent);
    return  CGRectMake(0, self.frame.size.height * lwqImagePercent, titleW, titleH);
}
@end
