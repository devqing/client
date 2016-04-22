//
//  FriendViewCell.m
//  wukong
//
//  Created by liuweiqing on 16/4/15.
//  Copyright © 2016年 RT. All rights reserved.
//

#import "FriendViewCell.h"
#import <UIImageView+WebCache.h>

@interface FriendViewCell()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLabel;


@end

@implementation FriendViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.iconView];
        [self addSubview:self.nameLabel];
    }
    return self;
}

- (void)configWithData:(NSDictionary *)data
{
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:data[@"avatar"]]];
    self.nameLabel.text = data[@"nike_name"];
}

#pragma mark --getter&setter
- (UIImageView *)iconView
{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 34, 34)];
        _iconView.layer.cornerRadius = 2.0;
        _iconView.layer.masksToBounds = YES;
        _iconView.layer.borderWidth = 0.5;
        _iconView.layer.borderColor = [UIColor grayColor].CGColor;
        _iconView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconView;
}
- (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(54, 15, 200, 20)];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont systemFontOfSize:17];
        
    }
    return _nameLabel;
}

@end
