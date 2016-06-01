//
//  TopAdScrollView.m
//  LOLBox
//
//  Created by 梁辉 on 16-5-17.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "TopAdScrollView.h"
#import "RecommModel.h"
#import "NSString+URLEncoding.h"
#import "DetailViewController.h"

@interface TopAdScrollView ()
//用于接收图片数组
@property (nonatomic,strong)NSArray *array;

//标示当前第几页
@property (nonatomic,assign)int page;

@end

@implementation TopAdScrollView

- (instancetype)initWithFrame:(CGRect)frame andPicArr:(NSArray *)picArr{
    
    if (self = [super initWithFrame:frame]) {
        //接收
        _array = picArr;
        
        float width = self.bounds.size.width;
        float height = self.bounds.size.height;
        
        //滚动视图
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.contentSize = CGSizeMake(width * picArr.count, height);
        
        //contenInset(预习)
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollView];
        
        for (int i = 0; i < picArr.count; i++) {
            RecommModel *model = picArr[i];
            
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(width * i, 0, width, height)];
            NSString *picUrl = model.ban_img;
            NSString *realUrl = [picUrl URLDecodedString];
            
            //imageView.backgroundColor = [UIColor redColor];
            [imageView setImageWithURL:[NSURL URLWithString:realUrl] placeholderImage:[UIImage imageNamed:@"top_page_view_default"]];
            
            [_scrollView addSubview:imageView];
            //添加点击事件
            //开启用户交互
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageView:)];
            [imageView addGestureRecognizer:tap];
            //添加tag值
            imageView.tag = 1000 + i;
            
            
            //LABEL
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(width *i, height - 30, SCREEN_WIDTH, 30)];
            label.text = model.name;
            label.font = [UIFont boldSystemFontOfSize:15.0];
            label.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:0.5];
            [_scrollView addSubview:label];
            
        }
        
        //小圆点
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(width - 100, height - 30, 100, 20)];
        _pageControl.currentPage = 0;
        _pageControl.numberOfPages = picArr.count;
        _pageControl.currentPageIndicatorTintColor = [UIColor cyanColor];
        [self addSubview:_pageControl];
        
        //加入定时器
        [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(timeRefresh:) userInfo:nil repeats:YES];
        
        
    }
    
    return self;
}

#pragma mark -- 定时器方法
- (void)timeRefresh:(NSTimer *)timer{
    _page++;// 0 1 2
    if (_page >= _array.count) {
        _page = 0;
    }
    //更改偏移量
    //_scrollView.contentOffset = CGPointMake(self.bounds.size.width * _page, 0);
    float width = self.bounds.size.width;
    float height = self.bounds.size.height;
    
    [_scrollView scrollRectToVisible:CGRectMake(width * _page, 0, width, height) animated:YES];
    
    
    //更新PageControl
    _pageControl.currentPage = _page;
    
    
}

#pragma mark -- 实现手势方法
- (void)tapImageView:(UITapGestureRecognizer *)tap{
    UIImageView *tapImageView = (UIImageView *)tap.view;
    NSLog(@"点击了索引为%ld的图片",tapImageView.tag - 1000);
    //跳转界面 反向传值 回视图控制器跳转详情
    //调用block
    RecommModel *model = _array[tapImageView.tag - 1000];
    _block(model.article_id);
    
    
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
