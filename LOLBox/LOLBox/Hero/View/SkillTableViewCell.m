//
//  SkillTableViewCell.m
//  LOLBox
//
//  Created by 梁辉 on 16-5-19.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "SkillTableViewCell.h"

@interface SkillTableViewCell ()

//用于接收技能数组
@property (nonatomic,strong)NSArray *arr;

@end

@implementation SkillTableViewCell

- (void)loadDataFromSkillArr:(NSArray *)skillArr{
    //全局数组
    _arr = skillArr;
    
    //英雄技能图片与按键
    for (int i = 0; i<skillArr.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(55*i, 0, 45, 45)];
        
        //添加手势
        imageView.userInteractionEnabled = YES;
        imageView.tag = 500 + i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSkillImage:)];
        [imageView addGestureRecognizer:tap];
        
        
        
        //获得对应技能的数据
        NSDictionary *dic = skillArr[i];
        [imageView setImageWithURL:[NSURL URLWithString:dic[@"img"]] placeholderImage:[UIImage imageNamed:@"default_hero_head"]];
        [_skillView addSubview:imageView];
        
        //按键
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(55 *i, 45, 45, 15)];
        label.font = [UIFont systemFontOfSize:8];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = dic[@"key"];
        [_skillView addSubview:label];
        
        
    }
    
    //默认显示以一个技能描述
    NSDictionary *firstDic = skillArr.firstObject;
    //技能名称
    _nameLabel.text = firstDic[@"name"];
    //技能描述
    _descLabel.text = firstDic[@"desc"];
    //cd
    _cdLabel.text = firstDic[@"cd"];
    //消耗
    _costLabel.text = firstDic[@"cost"];
    
    
}

- (void)tapSkillImage:(UITapGestureRecognizer *)tap{
    //切换技能
    UIImageView *tapImageView = (UIImageView *)tap.view;
    int index = (int)tapImageView.tag - 500;
    //重新赋值
    NSDictionary *dic = _arr[index];
    _nameLabel.text = dic[@"name"];
    _descLabel.text = dic[@"desc"];
    _cdLabel.text = dic[@"cd"];
    _costLabel.text = dic[@"cost"];
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
