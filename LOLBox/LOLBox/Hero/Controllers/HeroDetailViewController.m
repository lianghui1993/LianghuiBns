//
//  HeroDetailViewController.m
//  LOLBox
//
//  Created by 梁辉 on 16-5-18.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "HeroDetailViewController.h"
#import "SkillTableViewCell.h"
#import "StoryTableViewCell.h"
#import "FightTableViewCell.h"
#import "HeroDetailModel.h"
#import "SqliteManager.h"

@interface HeroDetailViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)UIImageView *topImageView;

//移动线条
@property (nonatomic,strong)UIView *line;

//控制下方显示内容的全局变量
@property (nonatomic,assign) int index;//0  1 2

@property (nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation HeroDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    _dataArr = [[NSMutableArray alloc]init];
    
    [self createTableView];
    
    [self createHeadView];
    
    [self loadData];
    
    [self createBuyButton];
    
}

- (void)createBuyButton{
    
    UIBarButtonItem *buyItem = [[UIBarButtonItem alloc]initWithTitle:@"购买" style:UIBarButtonItemStylePlain target:self action:@selector(buyClick:)];
    self.navigationItem.rightBarButtonItem = buyItem;
    
    
}

- (void)buyClick:(UIBarButtonItem *)item{
    
    //英雄购买
    SqliteManager *manager = [SqliteManager defaultSqliteManager];
    BOOL isSuc = [manager buyHeroWithID:_heroID];
    if (isSuc) {
        //更新界面效果
        self.navigationItem.rightBarButtonItem.title  = @"已购买";
        self.navigationItem.rightBarButtonItem.enabled = NO;
        
    }
    
    
}

#pragma mark -- 请求数据
- (void)loadData{
    
    NSString *url = [NSString stringWithFormat:kHeroDetailInfoUrlString,_heroID];
    [HttpRequest startRequestWithUrl:url andParameter:nil andReturnBlock:^(NSData *data, NSError *error) {
        if (!error) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *resultDic = dic[@"result"];
            //建立数据模型
            HeroDetailModel *model = [[HeroDetailModel alloc]init];
            [model setValuesForKeysWithDictionary:resultDic];
            [_dataArr addObject:model];
            
            //顶部图片赋值
            [_topImageView setImageWithURL:[NSURL URLWithString:model.img_top] placeholderImage:[UIImage imageNamed:@"heroDefaultBG"]];
            
            //刷新tableView
            [_tableView reloadData];
            
            
        }else{
            NSLog(@"%@",error.localizedDescription);
        }
        
        
    }];
    
    
    
}

#pragma mark -- 按钮切换视图
- (void)createHeadView{
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    
    headView.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
   
    NSArray *titleArr = @[@"英雄技能",@"背景故事",@"使用技巧"];
    
    for (int i = 0; i<titleArr.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame = CGRectMake(SCREEN_WIDTH/3 *i, 0, SCREEN_WIDTH/3, 48);
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 2000 + i;
        [headView addSubview:btn];
        
    }
    
    //线条
    _line = [[UIView alloc]initWithFrame:CGRectMake(0, 48, SCREEN_WIDTH /3, 2)];
    _line.backgroundColor = [UIColor orangeColor];
    [headView addSubview:_line];
    
    _tableView.tableHeaderView = headView;
}

- (void)btnClick:(UIButton *)btn{
    _index = (int)btn.tag - 2000;
    [UIView animateWithDuration:0.5 animations:^{
        _line.frame = CGRectMake(SCREEN_WIDTH / 3* _index, 48, SCREEN_WIDTH / 3, 2);
        
        
        
    }];
    
    //刷新
    [_tableView reloadData];
    
}

- (void)createTableView{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    //去除间隔线
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //设置尾视图
    _tableView.tableFooterView = [[UIView alloc]init];
    
    [self.view addSubview:_tableView];
   
    //注册自定义cell
    [_tableView registerNib:[UINib nibWithNibName:@"SkillTableViewCell" bundle:nil] forCellReuseIdentifier:@"SKILL"];
    [_tableView registerNib:[UINib nibWithNibName:@"StoryTableViewCell" bundle:nil] forCellReuseIdentifier:@"STORY"];
    [_tableView registerNib:[UINib nibWithNibName:@"FightTableViewCell" bundle:nil] forCellReuseIdentifier:@"FIGHT"];
    
    //增加允许行高根据label自适应设置
//    _tableView.rowHeight = UITableViewAutomaticDimension;
//    //预计行高
//    _tableView.estimatedRowHeight = 185.0;
//    
    
    //顶部视图
    _topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -200, SCREEN_WIDTH, 200)];
    
    //_topImageView.image = [UIImage imageNamed:@"heroDefaultBG"];
   
    //停靠模型 无论如何缩放,始终显示原有宽高比例
    _topImageView.contentMode = UIViewContentModeScaleAspectFill;
   //去除多余视图
    _topImageView.clipsToBounds = YES;
    
    
    //添加到tableView上
    [_tableView addSubview:_topImageView];
    
    //contentInset 额外滑动区域
    _tableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
    
}

#pragma mark -- tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取数据源
    HeroDetailModel *model = _dataArr[indexPath.row];
    
    if (_index == 0) {
        //英雄技能
        SkillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKILL" forIndexPath:indexPath];
        //获取技能数组,传递给自定义cell
        [cell loadDataFromSkillArr:model.skill];
        //按键
        
        
        return cell;
        
    }else if (_index == 1){
        //故事背景
        StoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"STORY" forIndexPath:indexPath];
        cell.StoryLabel.text = model.background;
        return cell;
    }else{
        //使用技巧
        FightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FIGHT" forIndexPath:indexPath];
        cell.useLabel.text = model.talent_desc;
        cell.ganKLabel.text = model.analyse;
        
        return cell;
    }
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    float offset = scrollView.contentOffset.y;
    NSLog(@"%f",offset);
    if (offset < -200) {
        //下拉
        //更新顶部视图效果
        //0  - 200  SCREEN_WIDTH  200
        CGRect rect = _topImageView.frame;
        
        //1.图片始终顶在屏幕最上方
       // rect.origin.y = -200 - (-offset -200);
        rect.origin.y = offset;
        
        
        //2.图片高度随下拉二增加
        //rect.size.height = (-offset - 200)+200;
        rect.size.height = -offset;
        
        //3.重置图片坐标
        _topImageView.frame = rect;
        
    }
    
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //判断英雄是否购买
    SqliteManager *manager = [SqliteManager defaultSqliteManager];
    BOOL isExist = [manager isExsitHeroWithID:_heroID];
    
    if (isExist) {
        //已经购买
        //更新界面效果
        self.navigationItem.rightBarButtonItem.title = @"已购买";
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    
    
    [self createNavi];
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    //将导航栏归回未设置图片状态
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
}

#pragma  mark -- 导航栏透明化
- (void)createNavi{
    
    //透明图片
    UIImage *image = [[UIImage alloc]init];
    //设置导航栏背景图片
    /*
     参数1:图片
     参数2:设备的朝向(默认为竖屏)
     */
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    //导航栏阴影图片
    [self.navigationController.navigationBar setShadowImage:image];
    
    
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
