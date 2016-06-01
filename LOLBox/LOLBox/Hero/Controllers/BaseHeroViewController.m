//
//  BaseHeroViewController.m
//  LOLBox
//
//  Created by 梁辉 on 16-5-18.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "BaseHeroViewController.h"
#import "HeroTableViewCell.h"
#import "HeroModel.h"
#import "PinYinForObjc.h"
#import "HeroDetailViewController.h"

@interface BaseHeroViewController ()<UITableViewDataSource,UITableViewDelegate>

//系统原生刷新控件
@property (nonatomic,strong)UIRefreshControl *refresh;


@end

@implementation BaseHeroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化数据
    [self initData];
    //设置网址
    [self setMyUrl];
    //加载数据
    [self loadData];
    
    
    [self createTableView];




}

- (void)initData{
    _dataArr = [[NSMutableArray alloc]init];
    
    
}

- (void)setMyUrl{
    self.url = kAllHeroUrlString;
    
}

- (void)loadData{
    [HttpRequest startRequestWithUrl:self.url andParameter:nil andReturnBlock:^(NSData *data, NSError *error) {
        if (!error) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *resultArr = dic[@"result"];
            for (NSDictionary *heroDic in resultArr) {
                //建立数据模型
                HeroModel *model = [[HeroModel alloc]init];
                [model setValuesForKeysWithDictionary:heroDic];
                [_dataArr addObject:model];
                
            }
            //获取英雄汉语首字母-->排序
            [self chineseToPinYin];
            
            
            //刷新tableView
            [_tableView reloadData];
            
            //去除下拉刷新控件
            [_refresh endRefreshing];
            
        }else{
            
            NSLog(@"%@",error.localizedDescription);
        }
        
        
        
    }];
    
}

- (void)chineseToPinYin{
    /*
     数据结构
     26组(大数组套小数组)
     @(
        @(阿狸,阿卡丽),
        @(波比,巴德),
        @(),
        ...
     )
     索引:0~25
     首字母:a~z
     
     */
    _heroArr = [[NSMutableArray alloc]init];
    for (int i = 0; i< 26; i++) {
        //创建小数组
        NSMutableArray *array = [NSMutableArray array];
        //小数组依次存入大数组
        [_heroArr addObject:array];
    }
    
    
    for (int i = 0; i<_dataArr.count; i++) {
        //获取每个英雄数据模型
        HeroModel *model = _dataArr[i];
        //获取中文姓名
        NSString *chineseName = model.name_c;
        //获取英文名首字母
        NSString *englishName = [PinYinForObjc chineseConvertToPinYinHead:chineseName];
        //获取首字符
        char firstChar = [englishName characterAtIndex:0];
        
        
        //NSLog(@"%c",firstChar);
        
        int index = firstChar - 'a';
        //NSLog(@"%d",index);
        
        //将遍历得到的英雄存入对应的小数组中
        [_heroArr[index] addObject:model];
    }
    
    //移除空数组
    [_heroArr removeObject:@[]];
    
    //标题数组
    _titleArr = [[NSMutableArray alloc]init];
    
    for (int i = 0; i< _heroArr.count; i++) {
        //遍历得到小数组中第一个英雄模型
        HeroModel *model = [_heroArr[i]firstObject];
        NSString *chineseName = model.name_c;
        NSString *englishName = [PinYinForObjc chineseConvertToPinYinHead:chineseName];
        char firstChar = [englishName characterAtIndex:0];
        //添加对应标题
        [_titleArr addObject:[NSString stringWithFormat:@"%c",firstChar]];
    
    }
    
}

- (void)createTableView{
    //关闭自动布局
    self.automaticallyAdjustsScrollViewInsets = NO;
    //PCH  预编译文件
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT- 49 - 64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    //注册tableViewCell
    //代码形式或者系统原生
    [self.tableView registerNib:[UINib nibWithNibName:@"HeroTableViewCell" bundle:nil] forCellReuseIdentifier:@"HERO"];

    
    //创建下拉刷新控件
    _refresh = [[UIRefreshControl alloc]init];
    [_refresh addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [_refresh setTintColor:[UIColor cyanColor]];
    //设置文字
    NSAttributedString *str = [[NSAttributedString alloc]initWithString:@"松开即刷新"];
    
    [_refresh setAttributedTitle:str];
    [_tableView addSubview:_refresh];
    
    //开始刷新
    [_refresh beginRefreshing];
    
    
}

- (void)refresh:(UIRefreshControl *)refresh{
    
    //设置文字
    NSAttributedString *str = [[NSAttributedString alloc]initWithString:@"刷新中..."];
    [_refresh setAttributedTitle:str];
    [_dataArr removeAllObjects];
    [self setMyUrl];
    [self loadData];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _heroArr.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_heroArr[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HeroTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HERO" forIndexPath:indexPath];
   
    //反之下拉刷新崩溃判断
    if (_dataArr.count <= 0) {
        return cell;
    }
    
    //得到某行数据
    HeroModel *model = _heroArr[indexPath.section][indexPath.row];
    [cell loadDataFromModel:model];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80.0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    
    return _titleArr[section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    
    return _titleArr;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 22.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}

#pragma mark -- tableView点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //跳转详情界面
    
    HeroDetailViewController *detail = [[HeroDetailViewController alloc]init];
    detail.hidesBottomBarWhenPushed = YES;
    //传递英雄ID
    HeroModel *model = _heroArr[indexPath.section][indexPath.row];
    detail.heroID = model.ID;
    
    [self.navigationController pushViewController:detail animated:YES];
    
    
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
