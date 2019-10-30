//
//  UIButton+ButtonExpand.m
//  test
//
//  Created by allsale on 2019/7/26.
//  Copyright © 2019 allsale. All rights reserved.
//

#import "UIButton+ButtonExpand.h"

@implementation UIButton (ButtonExpand)
static char expandSizeKey;

- (void)expandSize:(CGFloat)size {
    
    //OBJC_EXPORT void objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy)
    //OBJC_EXPORT 打包lib时，用来说明该函数是暴露给外界调用的。
    //id object 表示关联者，是一个对象
    //id value 表示被关联者，可以理解这个value最后是关联到object上的
    //const void *key 被关联者也许有很多个，所以通过key可以找到指定的那个被关联者
    
    objc_setAssociatedObject(self, &expandSizeKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

//获取设置的扩大size，来扩大button的rect
//当前只是设置了一个扩大的size，当然也可以设置4个扩大的size，上下左右，具体扩大多少对应button的四个边传入对应的size
- (CGRect)expandRect {
    
    NSNumber *expandSize = objc_getAssociatedObject(self, &expandSizeKey);
    
    if (expandSize) {
        return CGRectMake(self.bounds.origin.x - expandSize.floatValue,
                          self.bounds.origin.y - expandSize.floatValue,
                          self.bounds.size.width + expandSize.floatValue + expandSize.floatValue,
                          self.bounds.size.height + expandSize.floatValue + expandSize.floatValue);
    } else {
        return self.bounds;
    }
}

//响应用户的点击事件
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
    CGRect buttonRect = [self expandRect];
    if (CGRectEqualToRect(buttonRect, self.bounds)) {
        return [super pointInside:point withEvent:event];
    }
    return CGRectContainsPoint(buttonRect, point) ? YES : NO;
}






+ (void)load{
    
    Method originalMethod = class_getInstanceMethod([self class], @selector(sendAction:to:forEvent:));
    Method swizzledMethod = class_getInstanceMethod([self class], @selector(JH_SendAction:to:forEvent:));
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

#pragma mark - 时间间隔 --
static const void *ButtonDurationTime = @"ButtonDurationTime";
- (NSTimeInterval)durationTime{
    NSNumber *number = objc_getAssociatedObject(self, &ButtonDurationTime);
    return number.doubleValue;
}
- (void)setDurationTime:(NSTimeInterval)durationTime{
    NSNumber *number = [NSNumber numberWithDouble:durationTime];
    objc_setAssociatedObject(self, &ButtonDurationTime, number, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)JH_SendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    
    self.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.durationTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.userInteractionEnabled = YES;
    });
    
    [self JH_SendAction:action to:target forEvent:event];
}


#pragma mark - 携带多参数 --
static const void *RunTimeButtonParam = @"RunTimeButtonParam";
- (NSDictionary*)ButtonParam{
    NSDictionary *param = objc_getAssociatedObject(self, &RunTimeButtonParam);
    return param;
}
- (void)setButtonParam:(NSDictionary *)ButtonParam{
    objc_setAssociatedObject(self, &RunTimeButtonParam, ButtonParam, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end
