//
//  UIFont+mtBase.m
//  AFNetworking
//
//  Created by Jason Li on 2018/3/12.
//

#import "UIFont+mtBase.h"
#import "MTBaseFactory.h"

@implementation UIFont (mtBase)

+ (UIFont *)titleFont {
    return [[MTBaseFactory sharedInstance] titleFont];
}

+ (UIFont *)contentFont {
    return [[MTBaseFactory sharedInstance] contentFont];
}

+ (UIFont *)descFont {
    return [[MTBaseFactory sharedInstance] descFont];
}

@end
