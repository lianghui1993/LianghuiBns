//
//  HeroViewController.m
//  LOLBox
//
//  Created by 梁辉 on 16-5-16.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "HeroViewController.h"
#import "FreeViewController.h"
#import "AllViewController.h"
@interface HeroViewController ()

@property (nonatomic,strong)FreeViewController *freeVC;

@property (nonatomic,strong)AllViewController *allVC;


@end

@implementation HeroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     link  报错
     1/导入头文件误导入.m文件
     2.创建重名的类
     3.导入库文件,不支持模拟器版本

     
     */
    [self createControllers];

    [self createSegment];
    
}

- (void)createSegment{
    
    UISegmentedControl *seg = [[UISegmentedControl alloc]initWithItems:@[@"周免",@"全部"]];
    seg.frame = CGRectMake(0, 0, 200, 30);
    [seg addTarget:self action:@selector(segChange:) forControlEvents:UIControlEventValueChanged];
    
    //添加导航栏上
    self.navigationItem.titleView = seg;
    
    
}

- (void)segChange:(UISegmentedControl *)seg{
    if (seg.selectedSegmentIndex == 0) {
        //周免
        [self.view bringSubviewToFront:_freeVC.view];
        
    }else{
        //全部
        [self.view bringSubviewToFront:_allVC.view];
        
    }
    
}

- (void)createControllers{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _freeVC = [[FreeViewController alloc]init];
    [self.view addSubview:_freeVC.view];
    
    _allVC = [[AllViewController alloc]init];
    [self.view addSubview:_allVC.view];
    
    [self.view bringSubviewToFront:_freeVC.view];
    
    //重置坐标
    _freeVC.view.frame = self.view.frame;
    _allVC.view.frame = self.view.frame;
    
    //将freeVC/allVC作为当前视图控制器的子视图控制器
    [self addChildViewController:_freeVC];
    [self addChildViewController:_allVC];
    
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
