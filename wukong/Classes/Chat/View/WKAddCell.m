//
//  WKAddCell.m
//  wukong
//
//  Created by liuweiqing on 16/4/8.
//  Copyright © 2016年 RT. All rights reserved.
//

#import "WKAddCell.h"

@interface WKAddCell()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation WKAddCell

#pragma mark --life cycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 130, 40)];
        view.backgroundColor = [UIColor blackColor];
        self.selectedBackgroundView = view;
        [self configCell];
    }
    return self;
}

#pragma mark --private method
- (void)configCell
{
    [self addSubview:self.iconView];
    [self addSubview:self.titleLabel];
    //    [self addSubview:self.bottomLine];
}

- (void)configWithIcon:(NSString *)icon title:(NSString *)title
{
    self.iconView.image = [UIImage imageNamed:icon];
    self.titleLabel.text = title;
}

#pragma mark --getter&setter
- (UIImageView *)iconView
{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 28, 30)];
    }
    return _iconView;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 80, 40)];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (UIView *)bottomLine
{
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(15, 39.7, 10, 0.3)];
        _bottomLine.backgroundColor = [UIColor whiteColor];
    }
    return _bottomLine;
}

@end
