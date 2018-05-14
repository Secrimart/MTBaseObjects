//
//  NSObject+mtBase.m
//  AFNetworking
//
//  Created by Jason Li on 2018/5/10.
//

#import "NSObject+mtBase.h"
#import "MTBaseFactory.h"

@implementation NSObject (mtBase)

- (UIEdgeInsets)pEdgeInsets {
    return [MTBaseFactory sharedInstance].edgeInsets;
}

- (CGFloat)pRowHeight {
    return [MTBaseFactory sharedInstance].rowHeight;
}

- (CGFloat)pNavHeight {
    return [MTBaseFactory sharedInstance].navHeight;
}

- (CGFloat)pStatusBarHeight {
    return [MTBaseFactory sharedInstance].statusBarHeight;
}

- (CGFloat)pTabBarHeight {
    return [MTBaseFactory sharedInstance].tabBarHeight;
}

- (CGFloat)pControlInterval {
    return [MTBaseFactory sharedInstance].controlInterval;
}

- (CGFloat)pControlHalfInterval {
    return self.pControlHalfInterval/2.f;
}

- (CGFloat)pCornerRadius {
    return [MTBaseFactory sharedInstance].cornerRadius;
}

@end

