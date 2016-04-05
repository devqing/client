//
//  WKTabbarView.h
//  wukong
//
//  Created by liuweiqing on 16/4/1.
//  Copyright © 2016年 RT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WKTabbarView;
@protocol WKTabbarViewDelegate <NSObject>

- (void)tabbarView:(WKTabbarView *) tabbarView didSelectIndex:(NSInteger)index;

@end

@interface WKTabbarView : UIImageView


- (void)addsubviewWithItem:(UITabBarItem *)item;
@property (nonatomic, weak) id<WKTabbarViewDelegate> delegate;

@end
