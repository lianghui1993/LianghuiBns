//
//  HeroTableViewCell.h
//  LOLBox
//
//  Created by 梁辉 on 16-5-18.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeroModel.h"

@interface HeroTableViewCell : UITableViewCell

- (void)loadDataFromModel:(HeroModel *)model;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagsLabel;
@property (weak, nonatomic) IBOutlet UILabel *realnameLabel;

@end
