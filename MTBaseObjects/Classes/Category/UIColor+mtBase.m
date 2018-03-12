//
//  UIColor+mtBase.m
//  AFNetworking
//
//  Created by Jason Li on 2018/3/12.
//

#import "UIColor+mtBase.h"
#import "MTBaseFactory.h"

@implementation UIColor (mtBase)

+ (instancetype)spotColor {
    return [[MTBaseFactory sharedInstance] spotColor];
}

+ (instancetype)dataColor {
    return [[MTBaseFactory sharedInstance] dataColor];
}

+ (instancetype)grayDataColor {
    return [[MTBaseFactory sharedInstance] grayDataColor];
}

@end
