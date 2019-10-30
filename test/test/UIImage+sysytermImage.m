//
//  UIImage+sysytermImage.m
//  test
//
//  Created by allsale on 2019/8/9.
//  Copyright © 2019 allsale. All rights reserved.
//

#import "UIImage+sysytermImage.h"
#import <objc/runtime.h>
char alexNameKey;
@implementation UIImage (sysytermImage)

//+ (UIImage *)xh_imageNamed:(NSString *)name{
//    double version = [[UIDevice currentDevice].systemVersion doubleValue];
//    if (version >= 7.0) {
//        // 如果系统版本是7.0以上，使用另外一套文件名结尾是‘_os7’的扁平化图片
//        name = [name stringByAppendingString:@"_os7"];
//    }
//        return [UIImage xh_imageNamed:name];
    /**
     注意：自定义方法中最后一定要再调用一下系统的方法，让其有加载图片的功能，但是由于方法交换，系统的方法名已经变成了我们自定义的方法名（有点绕，就是用我们的名字能调用系统的方法，用系统的名字能调用我们的方法），这就实现了系统方法的拦截
     
     */
//}
+ (void)load
{
//    Method  m1 = class_getClassMethod([UIImage class], @selector(imageNamed:));
//    Method  m2 = class_getClassMethod([UIImage class], @selector(xh_imageNamed:));
//    method_exchangeImplementations(m1, m2) ;

}

- (void)setAlexName:(NSString *)name {
    // 将某个值跟某个对象关联起来，将某个值存储到某个对象中
/*
 参数 object：给哪个对象设置属性
 参数 key：一个属性对应一个Key，将来可以通过key取出这个存储的值，key 可以是任何类型：double、int 等，建议用char 可以节省字节
 参数 value：给属性设置的值
 参数policy：存储策略 （assign 、copy 、 retain就是strong）
 
 
 */
    objc_setAssociatedObject(self, &alexNameKey, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
/*
 但是全局变量程序整个执行过程中内存中只有一份，我们创建多个对象修改其属性值都会修改同一个变量，这样就无法保证像属性一样每个对象都拥有其自己的属性值。这时我们就需要借助runtime为分类增加属性的功能了
 
 */
- (NSString *)alexName {
    return objc_getAssociatedObject(self, &alexNameKey);
}
@end
