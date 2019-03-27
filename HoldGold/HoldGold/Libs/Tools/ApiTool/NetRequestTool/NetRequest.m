//
//  NetRequest.m
//  HoldGold
//
//  Created by 掌金 on 2019/3/18.
//  Copyright © 2019年 掌金. All rights reserved.
//

#import "NetRequest.h"

@implementation NetRequest

//GET请求
+(void)getWithUrlString:(NSString *)urlString success:(HttpSuccess)success failure:(HttpFailure)failure{
    //创建请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //内容类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
    //get请求
    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //数据请求的进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
}


//POST请求
+(void)postWithUrlString:(NSString *)urlString parameters:(id )parameters success:(HttpSuccess)success failure:(HttpFailure)failure{
    //创建请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //内容类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
    //post请求
    [manager POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //数据请求的进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

@end
