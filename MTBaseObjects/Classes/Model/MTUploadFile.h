//
//  MTUploadFile.h
//  AFNetworking
//
//  Created by Jason Li on 2018/3/12.
//

#import <Foundation/Foundation.h>

@interface MTUploadFile : NSObject
@property (nonatomic, strong) NSString *fileName; // 文件名称
@property (nonatomic, strong) NSString *fileType; // 文件类型
@property (nonatomic, strong) NSString *uploadKey; // 上传关键字
@property (nonatomic, strong) NSData *fileData; // 文件数据


@end
