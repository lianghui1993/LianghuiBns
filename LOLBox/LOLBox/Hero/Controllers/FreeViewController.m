//
//  FreeViewController.m
//  LOLBox
//
//  Created by 梁辉 on 16-5-18.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "FreeViewController.h"

@interface FreeViewController ()

@end

@implementation FreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self setMyUrl];

}

- (void)setMyUrl{
    
    self.url = kFreeHeroUrlString;
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
