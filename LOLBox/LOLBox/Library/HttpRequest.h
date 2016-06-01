//
//  HttpRequest.h
//  LOLBox
//
//  Created by 梁辉 on 16-5-16.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HttpRequest : NSObject

+ (void)startRequestWithUrl:(NSString *)url andParameter:(NSDictionary *)parameter andReturnBlock:(void(^)(NSData *data,NSError *error))block;






@end
