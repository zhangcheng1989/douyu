//
//  ZCHttpTool.h
//  douyu
//
//  Created by zhangcheng on 16/2/21.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ApiCompletion)(NSURLSessionDataTask *task,id responseObject,NSError *error);

typedef void (^DownCompletion)(NSURL *url,NSError *error);

typedef void (^Progress)(long long bytesRead, long long totalBytesRead);

@interface ZCHttpTool : NSObject

+ (NSURLSessionDataTask *)postWithPath:(NSString *)path params:(NSDictionary *)params completion:(ApiCompletion)completion;

+ (NSURLSessionDataTask *)getWithPath:(NSString *)path params:(NSDictionary *)params completion:(ApiCompletion)completion;


+ (NSURLSessionDataTask *)uploadWithPath:(NSString *)path params:(NSDictionary *)params data:(UIImage *)image upName:(NSString *)upName fileName:(NSString *)fileName mimeType:(NSString *)mimeType completion:(ApiCompletion)completion uploadProgress:(Progress)progress;

+ (NSURLSessionDataTask *)multipartUploadWithPath:(NSString *)path params:(NSDictionary *)params imageUrls:(NSArray *)imageUrls completion:(ApiCompletion)completion uploadProgress:(Progress)progress;

+ (NSURLSessionDownloadTask *)downloadWithPath:(NSString *)path saveToPath:(NSString *)saveToPath completion:(DownCompletion)completion progress:(Progress)progressBlock;

@end
