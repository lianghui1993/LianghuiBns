//
//  SqliteManager.m
//  LOLBox
//
//  Created by 梁辉 on 16-5-19.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "SqliteManager.h"

@interface SqliteManager ()

@property (nonatomic,strong)FMDatabase *dataBase;

@end

@implementation SqliteManager

+ (instancetype)defaultSqliteManager{
    static SqliteManager *manager;
//    if (manager == nil) {
//        manager = [[SqliteManager alloc]init];
//    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    manager = [[SqliteManager alloc]init];

    });
    return manager;
}

//创建数据库/表
- (instancetype)init{
    
    if (self = [super init]) {
     //1.路径
        NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/hero.rdb"];
     //2.创建数据库
        _dataBase = [[FMDatabase alloc]initWithPath:path];
       //判断数据库是否创建成功
        if ([_dataBase open]) {
            NSLog(@"数据库创建成功");
            
        }else{
            NSLog(@"数据库创建失败");
            
        }
        
        //4创建表
        NSString *createSql = @"create table if not exists HeroTable(heroID varchar(64))";
        //5.执行语句
        BOOL isSuc = [_dataBase executeUpdate:createSql];
        if (isSuc) {
            NSLog(@"表创建成功");
        }else{
            NSLog(@"表创建失败");
        }
        
        
    }
    
    return self;
}


//增加
- (BOOL)buyHeroWithID:(NSString *)heroID{
    //增加操作的语句
    NSString *insertSql = @"insert into HeroTable(heroID) values(?)";
    //执行
    BOOL isSuc = [_dataBase executeUpdate:insertSql,heroID];
    if (isSuc) {
        NSLog(@"购买成功");
        return YES;
    }else{
        NSLog(@"购买失败");
        return NO;
    }
    
}

//判断
- (BOOL)isExsitHeroWithID:(NSString *)heroID{
    //查询语句
    NSString *selectSql = @"select *from HeroTable where heroID = ?";
    //执行
    FMResultSet *set = [_dataBase executeQuery:selectSql,heroID];
    if ([set next]) {
        NSLog(@"已经购买");
        return YES;
    }else{
        NSLog(@"未购买");
        return NO;
    }
    
}

@end
