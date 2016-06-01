//
//  MainTabBarViewController.m
//  LOLBox
//
//  Created by 梁辉 on 16-5-16.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "NewsViewController.h"
#import "HeroViewController.h"
#import "FindViewController.h"
#import "MeViewController.h"



@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     搭建TabBar
     
     
     */

    [self createTabBar];

   // self.selectedIndex = 1;


}

- (void)createTabBar{
    
    //新闻
    NewsViewController *news = [[NewsViewController alloc]init];
    
    //英雄
    HeroViewController *hero = [[HeroViewController alloc]init];
    
    //发现
    FindViewController *find = [[FindViewController alloc]init];
    
    //我的
    MeViewController *me = [[MeViewController alloc]init];
    
    //vcArr
    NSMutableArray *array = [NSMutableArray arrayWithObjects:news,hero,find,me, nil];
    
    //标题
    NSArray *titleArr = @[@"新闻",@"英雄",@"发现",@"我"];
    
    //普通状态图片,
    NSArray *normalArr = @[@"tab_icon_news_normal",@"tab_icon_friend_normal",@"tab_icon_quiz_normal",@"tab_icon_more_normal"];
    
    //和选中图片
    NSArray *selectedArr = @[@"tab_icon_news_press",@"tab_icon_friend_press",@"tab_icon_quiz_press",@"tab_icon_more_press"];
    
    //for循环创建
    for (int i = 0; i<array.count; i++) {
        //依次得到每个视图控制器
        UIViewController *vc = array[i];
        //vc转换成navigation
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        //替换  将array数组中的vc->nav
        [array replaceObjectAtIndex:i withObject:nav];
        
        //设置标题
        vc.title = titleArr[i];
        
        //渲染模式(保证图片样式不更改)
        UIImage *normalImage = [UIImage imageNamed:normalArr[i]];
        UIImage *selectedImage = [UIImage imageNamed:selectedArr[i]];
        //设置状态图片
        nav.tabBarItem.image = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        nav.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    }
    //管理
    self.viewControllers =array;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
