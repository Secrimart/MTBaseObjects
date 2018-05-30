//
//  MTBaseFactory.m
//  MTBaseObjects
//
//  Created by Jason Li on 2018/3/12.
//

#import "MTBaseFactory.h"

@implementation MTBaseFactory

+ (instancetype)sharedInstance {
    static MTBaseFactory *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (UIColor *)spotColor {
    if ([self.dataSource respondsToSelector:@selector(setupBaseSpotColor)]) {
        return [self.dataSource setupBaseSpotColor];
    }
    
    return [UIColor redColor];
}

- (UIColor *)dataColor {
    if ([self.dataSource respondsToSelector:@selector(setupBaseDataColor)]) {
        return [self.dataSource setupBaseDataColor];
    }
    
    return [UIColor colorWithWhite:0.2 alpha:1];
}

- (UIColor *)grayDataColor {
    if ([self.dataSource respondsToSelector:@selector(setupBaseGrayDataColor)]) {
        return [self.dataSource setupBaseGrayDataColor];
    }
    
    return [UIColor lightGrayColor];
}

- (UIFont *)titleFont {
    if ([self.dataSource respondsToSelector:@selector(setupBaseTitleFont)]) {
        return [self.dataSource setupBaseTitleFont];
    }
    
    return [UIFont systemFontOfSize:18.f];
}

- (UIFont *)contentFont {
    if ([self.dataSource respondsToSelector:@selector(setupBaseContentFont)]) {
        return [self.dataSource setupBaseContentFont];
    }
    
    return [UIFont systemFontOfSize:16.f];
}

- (UIFont *)descFont {
    if ([self.dataSource respondsToSelector:@selector(setupBaseDescFont)]) {
        return [self.dataSource setupBaseDescFont];
    }
    
    return [UIFont systemFontOfSize:14.f];
}

- (NSString *)networkProtocol {
    if (_networkProtocol) {
        return _networkProtocol;
    }
#ifdef HTTPS
    return @"https://";
#else
    return @"http://";
#endif
}

- (NSString *)baseURL {
    if (_baseURL) {
        return _baseURL;
    }
    return @"";
}

@end
