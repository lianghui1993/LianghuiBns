//
//  BaseViewController.h
//  LOLBox
//
//  Created by 梁辉 on 16-5-16.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController


//列表
@property (nonatomic,strong)UITableView *tableView;

//数据源
@property (nonatomic,strong)NSMutableArray *dataArr;

//广告
@property (nonatomic,strong)NSMutableArray *recommArr;


//网址
@property (nonatomic,copy)NSString *url;

//页数
@property (nonatomic,assign)int page;

//设置网址
- (void)setMyUrl;

//请求数据
- (void)loadData;


@end
