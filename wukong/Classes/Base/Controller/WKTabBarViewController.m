//
//  WKTabBarViewController.m
//  wukong
//
//  Created by liuweiqing on 16/3/31.
//  Copyright © 2016年 RT. All rights reserved.
//

#import "WKTabBarViewController.h"
#import "WKMineViewController.h"
#import "WKFindViewController.h"
#import "WKChatListViewController.h"
#import "WKContactsViewController.h"
#import "WKNavigationViewController.h"
#import "WKTabbarView.h"
#import <RongIMKit/RongIMKit.h>
#import <RongIMLib/RongIMLib.h>
#import "WKAccountInfo.h"
#import <AFNetworking.h>

@interface WKTabBarViewController ()<WKTabbarViewDelegate,RCIMUserInfoDataSource>

@property (nonatomic, strong) WKTabbarView *tabView;

@end

@implementation WKTabBarViewController

#pragma mark --life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self connectRC];
    
    [self.tabBar addSubview:self.tabView];
    [self setupViewControllers];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    for (UIView *view in self.tabBar.subviews) {
        if ([view isKindOfClass:[UIControl class]]) {
            [view removeFromSuperview];
        }
    }
    
}

- (void)connectRC
{
    RCUserInfo *_currentUserInfo =
    [[RCUserInfo alloc] initWithUserId:[WKAccountInfo sharedInstance].uid
                                  name:[WKAccountInfo sharedInstance].nikeName
                              portrait:nil];
    [RCIMClient sharedRCIMClient].currentUserInfo = _currentUserInfo;
    [[RCIM sharedRCIM] connectWithToken:[WKAccountInfo sharedInstance].rongyunToken success:^(NSString *userId) {
        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
        [[RCIM sharedRCIM] setUserInfoDataSource:self];
    } error:^(RCConnectErrorCode status) {
        NSLog(@"登陆的错误码为:%d", status);
    } tokenIncorrect:^{
        
        NSLog(@"token错误");
    }];
}

- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *userInfo))completion
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url = [NSString stringWithFormat:@"%@%@",SERVER_URL,@"api.userinfo"];
    NSDictionary *params = @{
                             @"uid":userId
                             };
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject[@"flag"] isEqualToString:@"ok"]) {
            NSDictionary *response = responseObject[@"data"];
            RCUserInfo *userInfo = [[RCUserInfo alloc] init];
            userInfo.userId = response[@"_id"];
            userInfo.name = response[@"nike_name"];
            userInfo.portraitUri = response[@"avatar"];
            return completion(userInfo);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}

#pragma mark --private method
- (void)setupViewControllers
{
    WKChatListViewController *chat = [[WKChatListViewController alloc] init];
    [self addChildSubviews:chat title:@"微信" image:@"tabbar_mainframe" selectedImage:@"tabbar_mainframeHL"];
    
    WKContactsViewController *contacts = [[WKContactsViewController alloc] init];
    [self addChildSubviews:contacts title:@"通讯录" image:@"tabbar_contacts" selectedImage:@"tabbar_contactsHL"];
    
    WKFindViewController *find = [[WKFindViewController alloc] init];
    [self addChildSubviews:find title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discoverHL"];
    
    WKMineViewController *mine = [[WKMineViewController alloc] init];
    [self addChildSubviews:mine title:@"我的" image:@"tabbar_me" selectedImage:@"tabbar_meHL"];
    
}

- (void)addChildSubviews:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    WKNavigationViewController *nav = [[WKNavigationViewController alloc] initWithRootViewController:childVc];
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    
    childVc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    [self addChildViewController:nav];
    
    [self.tabView addsubviewWithItem:childVc.tabBarItem];
}

#pragma mark --WKTabbarViewDelegate
- (void)tabbarView:(WKTabbarView *)tabbarView didSelectIndex:(NSInteger)index
{
    self.selectedIndex = index;
}

#pragma mark --getter&setter
- (WKTabbarView *)tabView
{
    if (_tabView == nil) {
        _tabView = [[WKTabbarView alloc] initWithFrame:self.tabBar.bounds];
        _tabView.userInteractionEnabled = YES;
        _tabView.delegate = self;
    }
    return _tabView;
}

@end
