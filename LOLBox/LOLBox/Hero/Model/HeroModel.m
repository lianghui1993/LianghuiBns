//
//  HeroModel.m
//  LOLBox
//
//  Created by 梁辉 on 16-5-18.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "HeroModel.h"

@implementation HeroModel


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }
    
    
}



@end
