//
//  BaseTableViewCell.m
//  LOLBox
//
//  Created by 梁辉 on 16-5-16.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "BaseTableViewCell.h"


@implementation BaseTableViewCell

- (void)loadDataFromModel:(BaseModel *)model{
    
    //标题
    _titleLabel.text = model.title;
    
    //详情
    _infoLabel.text = model.shortStr;
    
    //图标
    [_iconImageView setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:[UIImage imageNamed:@"top_page_view_default"]];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
