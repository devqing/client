//
//  AppDelegate.m
//  wukong
//
//  Created by liuweiqing on 16/3/29.
//  Copyright © 2016年 RT. All rights reserved.
//

#import "AppDelegate.h"
#import <RongIMKit/RongIMKit.h>
#import <RongIMLib/RongIMLib.h>
#import "WKTabBarViewController.h"
#import "LoginViewController.h"
#import "WKNavigationViewController.h"
#import "WKAccountInfo.h"

@interface AppDelegate ()

@property (nonatomic, strong) WKTabBarViewController *tabbarController;
@property (nonatomic, strong) LoginViewController *loginViewController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [[RCIM sharedRCIM] initWithAppKey:RONGYUN_APP_KEY];
    
    [self initNotification];
    if ([[WKAccountInfo sharedInstance] isLoginToLocal]) {
        self.loginViewController = nil;
        self.window.rootViewController = self.tabbarController;
    }else
    {
        self.tabbarController = nil;
        self.window.rootViewController = self.loginViewController;
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)initNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(signupSuccuss) name:@"SIGNUP_SUCCUSS" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccuss) name:@"LOGIN_SUCCUSS" object:nil];
}

- (void)signupSuccuss
{
    RCUserInfo *_currentUserInfo =
    [[RCUserInfo alloc] initWithUserId:[WKAccountInfo sharedInstance].uid
                                  name:[WKAccountInfo sharedInstance].nikeName
                              portrait:nil];
    [RCIMClient sharedRCIMClient].currentUserInfo = _currentUserInfo;
    self.loginViewController = nil;
    self.window.rootViewController = self.tabbarController;
    [self.window makeKeyAndVisible];
    
}

- (void)loginSuccuss
{
    RCUserInfo *_currentUserInfo =
    [[RCUserInfo alloc] initWithUserId:[WKAccountInfo sharedInstance].uid
                                  name:[WKAccountInfo sharedInstance].nikeName
                              portrait:nil];
    [RCIMClient sharedRCIMClient].currentUserInfo = _currentUserInfo;
    self.loginViewController = nil;
    self.window.rootViewController = self.tabbarController;
    [self.window makeKeyAndVisible];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark --getter&setter
- (WKTabBarViewController *)tabbarController
{
    if (_tabbarController == nil) {
        _tabbarController = [[WKTabBarViewController alloc] init];
    }
    return _tabbarController;
}

- (LoginViewController *)loginViewController
{
    if (_loginViewController == nil) {
        _loginViewController = [[LoginViewController alloc] init];
    }
    return _loginViewController;
}

@end
