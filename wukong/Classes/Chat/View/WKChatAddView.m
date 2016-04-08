//
//  WKChatAddView.m
//  wukong
//
//  Created by liuweiqing on 16/4/8.
//  Copyright © 2016年 RT. All rights reserved.
//

#import "WKChatAddView.h"
#import "WKAddCell.h"

@interface WKChatAddView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *formTableView;

@end

@implementation WKChatAddView


#pragma mark --life cycle
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIImage *image = [UIImage imageNamed:@"MoreFunctionFrame"];
        self.userInteractionEnabled = YES;
        NSInteger leftCapWidth = image.size.width * 0.5f;
        NSInteger topCapHeight = image.size.height * 0.5f;
        
        image = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
        self.image = image;
        
        [self addSubview:self.formTableView];
    }
    return self;
}

#pragma mark --UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WKAddCell *cell = [[WKAddCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.backgroundColor = [UIColor clearColor];
    if (indexPath.row == 0) {
        [cell configWithIcon:@"contacts_add_newmessage" title:@"发起群聊"];
        
    }else if(indexPath.row == 1)
    {
        [cell configWithIcon:@"contacts_add_friend" title:@"添加朋友"];
    }else if(indexPath.row == 2)
    {
        [cell configWithIcon:@"contacts_add_scan" title:@"扫一扫"];
    }else if(indexPath.row == 3)
    {
        [cell configWithIcon:@"contacts_add_money" title:@"收付款"];
    }
    return cell;
}

#pragma mark --UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark --getter&setter
- (UITableView *)formTableView
{
    if (_formTableView == nil) {
        _formTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 12, 130, 160)];
        _formTableView.delegate = self;
        _formTableView.dataSource = self;
        _formTableView.backgroundColor = [UIColor clearColor];
        _formTableView.bounces = NO;
        _formTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _formTableView;
}


@end
