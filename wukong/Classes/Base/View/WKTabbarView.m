//
//  WKTabbarView.m
//  wukong
//
//  Created by liuweiqing on 16/4/1.
//  Copyright © 2016年 RT. All rights reserved.
//

#import "WKTabbarView.h"
#import "WKTabButton.h"

@interface WKTabbarView()

@property (nonatomic, strong) WKTabButton *selectButton;

@end

@implementation WKTabbarView

#pragma mark --public method

- (void)addsubviewWithItem:(UITabBarItem *)item
{
    WKTabButton *button = [[WKTabButton alloc] init];
    [button setImage:item.image forState:UIControlStateNormal];
    [button setImage:item.selectedImage forState:UIControlStateSelected];
    [button setTitle:item.title forState:UIControlStateNormal];

    [self addSubview:button];
    
    if (self.subviews.count == 1) {
        button.selected = YES;
        self.selectButton = button;
    }
}

- (void)selectButton:(WKTabButton *)button
{
    self.selectButton.selected = NO;
    button.selected = YES;
    self.selectButton = button;
    
    [self.delegate tabbarView:self didSelectIndex:button.tag];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat btnWidth = self.frame.size.width/self.subviews.count;
    CGFloat btnHeigth = self.frame.size.height;
    
    for (int i = 0; i < self.subviews.count; i ++) {
        WKTabButton *button = self.subviews[i];
        button.tag = i;
        [button addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchDown];
        button.frame = CGRectMake(i*btnWidth, 0, btnWidth, btnHeigth);
    }
}


@end
