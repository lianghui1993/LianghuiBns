//
//  SkillTableViewCell.h
//  LOLBox
//
//  Created by 梁辉 on 16-5-19.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SkillTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *skillView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *cdLabel;
@property (weak, nonatomic) IBOutlet UILabel *costLabel;

- (void)loadDataFromSkillArr:(NSArray *)skillArr;


@end
