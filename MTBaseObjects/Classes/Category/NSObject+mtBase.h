//
//  NSObject+mtBase.h
//  AFNetworking
//
//  Created py Jason Li on 2018/5/10.
//

#import <Foundation/Foundation.h>

@interface NSObject (mtBase)
- (UIEdgeInsets)pEdgeInsets;

- (CGFloat)pRowHeight;

- (CGFloat)pNavHeight;
- (CGFloat)pStatusBarHeight;
- (CGFloat)pTabBarHeight;

- (CGFloat)pControlInterval;
- (CGFloat)pControlHalfInterval;

- (CGFloat)pCornerRadius;

@end
