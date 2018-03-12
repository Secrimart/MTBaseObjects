//
//  MTUploadFile.m
//  AFNetworking
//
//  Created by Jason Li on 2018/3/12.
//

#import "MTUploadFile.h"

@implementation MTUploadFile

- (NSString *)fileName {
    if (_fileName) {
        return _fileName;
    }
    return @"fileName.jpg";
}

- (NSString *)fileType {
    if (_fileType) {
        return _fileType;
    }
    return @"image/pjpeg";
}

- (NSString *)uploadKey {
    if (_uploadKey) {
        return _uploadKey;
    }
    return @"img";
}

@end
