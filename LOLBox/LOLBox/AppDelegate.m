//
//  AppDelegate.m
//  LOLBox
//
//  Created by 梁辉 on 16-5-16.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarViewController.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //设置友盟appKey
    [UMSocialData setAppKey:@"573ab6ace0f55ae89b0022cf"];
    
    //设置微信
//    [UMSocialWechatHandler setWXAppId:@"wx87a53db0526ec705" appSecret:@"304dc6f2b158e4d704af9682f451a496" url:@"http://www.1000phone.com"];
    
    //设置URL Shemes(涉及应用跳转相关)
    
    //ios9 适配相关:需要添加额外设置(添加应用白名单)
    
    //设置QQ
//    [UMSocialQQHandler setQQWithAppId:@"1104944589" appKey:@"oaraqjCJ2CWOjaxn" url:@"http://www.sure.com"];
    //QQ”+腾讯QQ互联应用appId转换成十六进制（     QQ41DC1DCD
    //tencent"+腾讯QQ互联应用appId   tencent1104944589
    
    //隐藏未安装客户端!!上线审核注意!!!!
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline]];
    
//    if ([application canOpenURL:[NSURL URLWithString:@"wechat"]]) {
//        NSLog(@"存在");
//    }
    
    
    //设置根视图
    MainTabBarViewController *mainTabBar = [[MainTabBarViewController alloc]init];
    
    self.window.rootViewController = mainTabBar;
    
    //更改状态栏颜色
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //统一设置某控件样式 /默认样式
    [[UINavigationBar appearance]setBarStyle:UIBarStyleBlack];
    [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];
   
    
    
    
    
    
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
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

@end
