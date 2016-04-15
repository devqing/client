//
//  SearchFriendsCell.m
//  wukong
//
//  Created by liuweiqing on 16/4/12.
//  Copyright © 2016年 RT. All rights reserved.
//

#import "WKSearchFriendsCell.h"

@interface WKSearchFriendsCell()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel  *nameLabel;
@property (nonatomic, strong) UILabel  *mobileLabel;

@end

@implementation WKSearchFriendsCell

#pragma mark --life cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configCell];
    }
    return self;
}

- (void)configCell
{
    [self addSubview:self.iconView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.mobileLabel];
}

- (void)configWithData:(NSDictionary *)data
{
    self.nameLabel.text = data[@"nike_name"];
    self.mobileLabel.text = [NSString stringWithFormat:@"手机号:%@",data[@"mobile"]] ;
}

#pragma mark --getter&setter
- (UIImageView *)iconView
{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 55, 55)];
        _iconView.image = [UIImage imageNamed:@"fts_default_headimage"];
    }
    return _iconView;
}

- (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 8, UI_SCREEN_WIDTH-70-20, 20)];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textColor = [UIColor blackColor];
    }
    return _nameLabel;
}

- (UILabel *)mobileLabel
{
    if (_mobileLabel == nil) {
        _mobileLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 35, UI_SCREEN_WIDTH-70-20, 18)];
        _mobileLabel.font = [UIFont systemFontOfSize:13];
        _mobileLabel.textColor = UIColorFromRGB(UI_COLOR_TABBAR_TEXT_HL);
    }
    return _mobileLabel;
}

@end
