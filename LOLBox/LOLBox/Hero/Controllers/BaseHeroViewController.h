//
//  BaseHeroViewController.h
//  LOLBox
//
//  Created by 梁辉 on 16-5-18.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseHeroViewController : UIViewController

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *dataArr;

//存储排序后的大数组
@property (nonatomic,strong)NSMutableArray *heroArr;
//存储段标题的数组
@property (nonatomic,strong)NSMutableArray *titleArr;

@property (nonatomic,copy)NSString *url;



- (void)setMyUrl;//必须公开在.h

- (void)loadData;

@end
