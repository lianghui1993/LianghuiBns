//
//  LatestViewController.m
//  LOLBox
//
//  Created by 刘硕 on 16/5/16.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import "LatestViewController.h"

@interface LatestViewController ()

@end

@implementation LatestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark -- 设置网址
- (void)setMyUrl{
    
    self.url = [NSString stringWithFormat:kLatestNewsUrlString,self.page];
    
    
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
