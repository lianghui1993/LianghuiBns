//
//  DetailViewController.m
//  LOLBox
//
//  Created by 梁辉 on 16-5-16.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "DetailViewController.h"
#import "UMSocial.h"

@interface DetailViewController ()

//网页视图
@property (nonatomic,strong)UIWebView *webView;

@end

@implementation DetailViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self createWebView];

    
    [self createShareButton];
}

- (void)createShareButton{
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setImage:[UIImage imageNamed:@"share_normal"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"share_pressed"] forState:UIControlStateHighlighted];
    shareBtn.frame = CGRectMake(0, 0, 40, 40);
    [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:shareBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
}

#pragma mark -- 分享点击方法
- (void)shareClick:(UIButton *)btn{
    
    NSString *url = [NSString stringWithFormat:kNewsDetailUrlString,_newsID];
    //设置分享后点击链接内容
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"分享微信朋友圈标题";
    
    //设置纯图片分享(图文,纯图片,文字)
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeImage;
    
    //设置qq分享后的链接
    [UMSocialData defaultData].extConfig.qzoneData.url = url;
    [UMSocialData defaultData].extConfig.qzoneData.title = @"lolbox";
    
    
    //弹出分享列表
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"573ab6ace0f55ae89b0022cf" shareText:@"我是周青,哦也!很帅!!!" shareImage:[UIImage imageNamed:@"stage_5"] shareToSnsNames:@[UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToQQ,UMShareToQzone] delegate:nil];
    
    
    
    
}


- (void)createWebView{
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    //创建网页视图
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    //1.网址
    NSString *url = [NSString stringWithFormat:kNewsDetailUrlString,_newsID];
    //2.通过网址生成请求体
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    //3.网页视图加载请求体
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
    
    
    
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
