//
//  BaseModel.h
//  LOLBox
//
//  Created by 梁辉 on 16-5-16.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject


//id
@property (nonatomic,copy) NSString *ID;

//标题
@property (nonatomic,copy)NSString *title;

//详情
@property (nonatomic,copy)NSString *shortStr;

//图标
@property (nonatomic,copy)NSString *icon;




@end
