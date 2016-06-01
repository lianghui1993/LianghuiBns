//
//  HeroDetailModel.h
//  LOLBox
//
//  Created by 梁辉 on 16-5-19.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeroDetailModel : NSObject

//顶部图片
@property (nonatomic,copy)NSString *img_top;

//背景故事
@property (nonatomic,copy)NSString *background;

//对线技巧
@property (nonatomic,copy)NSString *analyse;

//使用技巧
@property (nonatomic,copy)NSString *talent_desc;

//英雄技能数组
@property (nonatomic,strong)NSArray *skill;

@end
