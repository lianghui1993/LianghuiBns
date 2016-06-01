//
//  HttpRequest.m
//  LOLBox
//
//  Created by 梁辉 on 16-5-16.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "HttpRequest.h"

@implementation HttpRequest

+ (void)startRequestWithUrl:(NSString *)url andParameter:(NSDictionary *)parameter andReturnBlock:(void(^)(NSData *data,NSError *error))block{
    
    //请求队列管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //设置返回数据类型  NSData
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //GET请求
    [manager GET:url parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //成功
        block(responseObject,nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //失败
        
        block(nil,error);
        
        
    }];
    
    
    
}



@end
