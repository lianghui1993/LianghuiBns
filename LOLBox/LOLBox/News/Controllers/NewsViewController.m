//
//  NewsViewController.m
//  LOLBox
//
//  Created by 梁辉 on 16-5-16.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "NewsViewController.h"
#import "LatestViewController.h"
#import "ActivityViewController.h"
#import "GameViewController.h"
#import "TopicViewController.h"
#import "PicViewController.h"
#import "OfficalViewController.h"
#import "GirlViewController.h"
#import "TacticViewController.h"

#import "SCNavTabBarController.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createControllers];

}

- (void)createControllers{
    
    LatestViewController *latest = [[LatestViewController alloc]init];
    latest.title = @"最新";
    
    ActivityViewController *activity = [[ActivityViewController alloc]init];
    activity.title = @"活动";
    
    GameViewController *game = [[GameViewController alloc]init];
    game.title = @"赛事";
    
    TopicViewController *topic = [[TopicViewController alloc]init];
    topic.title = @"神贴";
    
    PicViewController *pic = [[PicViewController alloc]init];
    pic.title = @"囧图";
    
    OfficalViewController *office = [[OfficalViewController alloc]init];
    office.title = @"官方";
    
    GirlViewController *girl = [[GirlViewController alloc]init];
    girl.title = @"美女";
    
    TacticViewController *tactic = [[TacticViewController alloc]init];
    tactic.title = @"攻略";
    
    //1.创建管理工具
    SCNavTabBarController *scNav = [[SCNavTabBarController alloc]init];
    //2,管理视图控制器
    scNav.subViewControllers = @[latest,activity,game,topic,pic,office,girl,tactic];
    
    //颜色
    scNav.navTabBarColor = [UIColor colorWithRed:35/255.0 green:43/255.0 blue:60/255.0 alpha:0.5];
    //底色
    self.view.backgroundColor = [UIColor colorWithRed:50/255.0 green:63/255.0 blue:80/255.0 alpha:1];
    
    //3.执行管理
    [scNav addParentController:self];
    
    
    
}

//隐藏导航栏
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
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
