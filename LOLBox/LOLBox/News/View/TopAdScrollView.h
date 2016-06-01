//
//  TopAdScrollView.h
//  LOLBox
//
//  Created by 梁辉 on 16-5-17.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopAdScrollView : UIView

@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UIPageControl *pageControl;

- (instancetype)initWithFrame:(CGRect)frame andPicArr:(NSArray *)picArr;

//block声明
@property (nonatomic,copy) void(^block)(NSString *);



@end
