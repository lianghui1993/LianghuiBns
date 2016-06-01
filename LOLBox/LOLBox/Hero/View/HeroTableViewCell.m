//
//  HeroTableViewCell.m
//  LOLBox
//
//  Created by 梁辉 on 16-5-18.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "HeroTableViewCell.h"

@implementation HeroTableViewCell

- (void)loadDataFromModel:(HeroModel *)model{
    
    [_iconImageView setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"stage_6"]];
    _nameLabel.text = model.name_c;
    _realnameLabel.text = model.title;
    _tagsLabel.text = model.tags;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
