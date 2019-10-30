//
//  UITapGestureRecognizer+JHExtension.m
//  test
//
//  Created by allsale on 2019/8/9.
//  Copyright © 2019 allsale. All rights reserved.
//

#import "UITapGestureRecognizer+JHExtension.h"
#import <objc/runtime.h>
@interface UITapGestureRecognizer ()<UIGestureRecognizerDelegate>
///时间间隔
@property (nonatomic ,assign)NSTimeInterval name;
@end
static const void *UITapGestureRecognizerduration = @"UITapGestureRecognizerduration";


@implementation UITapGestureRecognizer (JHExtension)

#pragma mark - Getter Setter

- (NSTimeInterval)duration{
    NSNumber *number = objc_getAssociatedObject(self, &UITapGestureRecognizerduration);
    return number.doubleValue;
}

- (void)setDuration:(NSTimeInterval)duration{
    NSNumber *number = [NSNumber numberWithDouble:duration];
    objc_setAssociatedObject(self, &UITapGestureRecognizerduration, number, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
/**
 添加点击事件
 
 @param target taeget
 @param action action
 @param duration 时间间隔
 */
- (instancetype)initWithTarget:(id)target action:(SEL)action withDuration:(NSTimeInterval)duration{
    
    self = [super init];
    if (self) {
        self.duration = duration;
        self.delegate = self;
        [self addTarget:target action:action];
    }
    return self;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    self.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.enabled = YES;
    });
    
    return YES;
}
@end
