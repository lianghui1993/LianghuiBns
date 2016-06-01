//
//  BaseViewController.m
//  LOLBox
//
//  Created by 梁辉 on 16-5-16.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseTableViewCell.h"
#import "BaseModel.h"
#import "DetailViewController.h"
#import "RecommModel.h"
#import "TopAdScrollView.h"

@interface BaseViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化数据
    [self initData];
    
    //设置网址
    [self setMyUrl];
    
    //加载数据
    [self loadData];
    
    //创建列表
    [self createTableView];

}

#pragma mark -- 初始化
- (void)initData{
    _dataArr = [[NSMutableArray alloc]init];
    _page = 1;
    _recommArr = [[NSMutableArray alloc]init];
    
    
}

#pragma mark -- 设置网址
- (void)setMyUrl{
    
    self.url = [NSString stringWithFormat:kLatestNewsUrlString,_page];

    
}

#pragma mark -- 加载数据
- (void)loadData{
    if (_page == 1) {
        
        //添加加载栏
        [MMProgressHUD showWithTitle:nil status:@"loading..."];
        //加载栏样式
        [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleExpand];
    }
    

    [HttpRequest startRequestWithUrl:self.url andParameter:nil andReturnBlock:^(NSData *data, NSError *error) {
        if (!error) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *resultArr = dic[@"result"];
            for (NSDictionary *resultDic in resultArr) {
                //建立数据模型存储数据
                BaseModel *model = [[BaseModel alloc]init];
                [model setValuesForKeysWithDictionary:resultDic];
                
                //添加数据源
                [_dataArr addObject:model];
            }
            
#pragma mark -- 解析广告滚动视图数据
            NSArray *recommArr = dic[@"recomm"];
            for (NSDictionary *recommDic in recommArr) {
                //建立数据模型
                RecommModel *model = [[RecommModel alloc]init];
                [model setValuesForKeysWithDictionary:recommDic];
                [_recommArr addObject:model];
            }
#pragma mark -- 广告滚动视图View
            TopAdScrollView *adScroll = [[TopAdScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200) andPicArr:_recommArr];
            _tableView.tableHeaderView = adScroll;
            //接收block传值
            adScroll.block = ^(NSString *ID){
                DetailViewController *detail = [[DetailViewController alloc]init];
                detail.hidesBottomBarWhenPushed = YES;
                detail.newsID = ID;
                [self.navigationController pushViewController:detail animated:YES];
            
            };
            
            
         //属性tableView
            [_tableView reloadData];
            
            //去除下拉刷新控件
            [_tableView.header endRefreshing];
            [_tableView.footer endRefreshing];
            
            //去除加载栏
            [MMProgressHUD dismissWithSuccess:@"加载成功"];
            
        }else{
            NSLog(@"错误信息:%@",error.localizedDescription);
            
            [_tableView.header endRefreshing];
            [_tableView.footer endRefreshing];
            [MMProgressHUD dismissWithError:error.localizedDescription];
        }
        
        
    }];
    
    
}

#pragma mark -- 创建列表
- (void)createTableView{
    

    
    
    //关闭自动布局
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, SCREEN_HEIGHT - 49 - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    //去除默认行条
    _tableView.tableFooterView = [[UIView alloc]init];
    //添加默认加载视图
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    bgImageView.image = [UIImage imageNamed:@"notice_pic_background_defualt"];
    _tableView.backgroundView =bgImageView;
    
    
    //注册cell
    //[_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ID"];
    [_tableView registerNib:[UINib nibWithNibName:@"BaseTableViewCell" bundle:nil] forCellReuseIdentifier:@"BASE"];
    
    
    //添加下拉刷新
    [self addDropDownRefresh];
    
    
    //上拉加载
    [self addDropUpRefresh];
    
    
    
}

#pragma mark -- 下拉刷新
- (void)addDropDownRefresh{
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
       //下拉刷新的操作
        _page = 1;//页数归一
        
        [self setMyUrl];
        
        //清空数据源重新发送网络请求
        [_dataArr removeAllObjects];
        [_recommArr removeAllObjects];
        [self loadData];
        
    }];
    
    //设置刷新中的动画
    NSArray *imagesArr = @[[UIImage imageNamed:@"loading_teemo_1"],[UIImage imageNamed:@"loading_teemo_2"]];
    [header setImages:imagesArr forState:MJRefreshStateRefreshing];
    
    self.tableView.header = header;
    
    
    
    
}

#pragma mark -- 上拉加载
- (void)addDropUpRefresh{
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        _page++;
        [self setMyUrl];
        [self loadData];
        
        
    }];
    NSArray *imagesArr = @[[UIImage imageNamed:@"loading_teemo_1"],[UIImage imageNamed:@"loading_teemo_2"]];
    [footer setImages:imagesArr forState:MJRefreshStateRefreshing];
    
    self.tableView.footer = footer;

    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //接收注册
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BASE" forIndexPath:indexPath];
    
    //加入放置下拉刷新崩溃的限制
    if (_dataArr.count <= 0) {
        return cell;
    }
    
    //数据与视图进行联系
    //得到该行数据源
    BaseModel *model = _dataArr[indexPath.row];
    [cell loadDataFromModel:model];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //去除默认停留效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailViewController *detail = [[DetailViewController alloc]init];
    //隐藏下方的标签了控制器
    detail.hidesBottomBarWhenPushed = YES;
    
    //获取到所点击行的新闻ID
    BaseModel *model = _dataArr[indexPath.row];
    detail.newsID = model.ID;
    
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
