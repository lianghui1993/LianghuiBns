//
//  SqliteManager.h
//  LOLBox
//
//  Created by 梁辉 on 16-5-19.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface SqliteManager : NSObject

//外漏方法
//增加
- (BOOL)buyHeroWithID:(NSString *)heroID;

//判断是否已收藏
- (BOOL)isExsitHeroWithID:(NSString *)heroID;

+ (instancetype)defaultSqliteManager;



@end
