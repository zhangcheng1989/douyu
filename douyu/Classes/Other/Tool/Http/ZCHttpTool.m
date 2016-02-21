//
//  ZCHttpTool.m
//  douyu
//
//  Created by zhangcheng on 16/2/21.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCHttpTool.h"
#import "AFNetworking.h"
#import <AFNetworkActivityIndicatorManager.h>
#import "NSString+ZCNowDate.h"
@implementation ZCHttpTool


+ (AFHTTPSessionManager *)manager{
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain",@"application/atom+xml",@"application/xml",@"text/xml", nil];
    return manager;
}

/**
 *  POST方法
 *
 *  @param url        url路径
 *  @param params     参数
 *  @param completion 完成回调
 *
 *  @return
 */
+ (NSURLSessionDataTask *)postWithPath:(NSString *)path params:(NSDictionary *)params completion:(ApiCompletion)completion{
    return [self requestWithUrl:path httpMedth:2 params:params completion:completion];
}

/**
 *  GET方法
 *
 *  @param url        url路径
 *  @param params     参数
 *  @param completion 完成回调
 *
 *  @return
 */
+ (NSURLSessionDataTask *)getWithPath:(NSString *)path params:(NSDictionary *)params completion:(ApiCompletion)completion{
    return [self requestWithUrl:path httpMedth:1 params:params completion:completion];
}

+ (NSURLSessionDataTask *)requestWithUrl:(NSString *)url httpMedth:(NSInteger)httpMethod params:(NSDictionary *)params completion:(ApiCompletion)completion{
    AFHTTPSessionManager *manager = [self manager];
    NSURLSessionDataTask *task = nil;
    if (httpMethod==1) {
        task = [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (completion) {
                completion(task,responseObject,nil);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (completion) {
                completion(task,nil,error);
            }
        }];
    }else{
        task = [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (completion) {
                if (responseObject) {
                    completion(task,responseObject,nil);
                }else{
                    NSError *error = [[NSError alloc] initWithDomain:@"" code:-1 userInfo:responseObject];
                    completion(task,nil,error);
                }
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (completion) {
                completion(task,nil,error);
            }
        }];
    }
    return task;
}

/**
 *  单张图片上传
 *
 *  @param path           路径
 *  @param params         参数
 *  @param iamge          上传的图片
 *  @param upName         图片名称
 *  @param fileName       文件名称
 *  @param mimeType       文件类型
 *  @param completion     完成回调
 *  @param uploadProgress
 *
 *  @return
 */
+ (NSURLSessionDataTask *)uploadWithPath:(NSString *)path params:(NSDictionary *)params data:(UIImage *)image upName:(NSString *)upName fileName:(NSString *)fileName mimeType:(NSString *)mimeType completion:(ApiCompletion)completion uploadProgress:(Progress)progress{
    
    AFHTTPSessionManager *manager = [self manager];
    NSURLSessionDataTask *task = [manager POST:path parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //压缩图片
        NSData *imageData = UIImageJPEGRepresentation(image, 1);
        [formData appendPartWithFileData:imageData name:upName fileName:fileName mimeType:mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completion) {
            if (responseObject) {
                completion(task,responseObject,nil);
            }else{
                NSError *anError = [NSError errorWithDomain:@"" code:-1 userInfo:responseObject];
                completion(task,nil,anError);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completion) {
            completion(task,nil,error);
        }
    }];
    return task;
}

/**
 *  多张图片上传
 *
 *  @param path       地址
 *  @param params     参数
 *  @param imageUrls  图片数组
 *  @param completion 完成回调
 *
 *  @return
 */
+ (NSURLSessionDataTask *)multipartUploadWithPath:(NSString *)path params:(NSDictionary *)params imageUrls:(NSArray *)imageUrls completion:(ApiCompletion)completion uploadProgress:(Progress)progress{
    
    AFHTTPSessionManager *manager = [self manager];
    return [manager POST:path parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (imageUrls &&imageUrls.count!=0) {
            for (NSInteger i=0; i<[imageUrls count]; i++) {
                NSData *imageData = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:[imageUrls objectAtIndex:i]]];
                NSString *upName = [[imageUrls objectAtIndex:i]lastPathComponent];
                NSString *fileName = [[imageUrls objectAtIndex:i]lastPathComponent];
                [formData appendPartWithFileData:imageData name:upName fileName:fileName mimeType:@"image/jpeg"];
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completion) {
            completion(task,responseObject,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completion) {
            completion(task,nil,error);
        }
    }];
}


/**
 *  文件下载
 *
 *  @param path          路径
 *  @param saveToPath    文件保存路径
 *  @param completion    完成回调
 *  @param progressBlock
 *
 *  @return 
 */
+ (NSURLSessionDownloadTask *)downloadWithPath:(NSString *)path saveToPath:(NSString *)saveToPath completion:(DownCompletion)completion progress:(Progress)progressBlock{
    AFHTTPSessionManager *manager = [self manager];
    
     NSURLRequest *downloadRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:path]];
    
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:downloadRequest progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progressBlock) {
            progressBlock(downloadProgress.completedUnitCount,downloadProgress.totalUnitCount);
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *cacheDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
        NSString *path = [cacheDir stringByAppendingPathExtension:response.suggestedFilename];
        NSURL *fileUrl = [NSURL fileURLWithPath:path];
        if (completion) {
            completion(fileUrl,nil);
        }
        return fileUrl;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (completion) {
            completion(nil,error);
        }
    }];
    return task;
}

+ (NSString *)jsonStringWithObject:(id)object{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:kNilOptions error:&error];
    NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}



@end
