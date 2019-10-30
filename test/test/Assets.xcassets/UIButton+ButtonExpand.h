//
//  UIButton+ButtonExpand.h
//  test
//
//  Created by allsale on 2019/7/26.
//  Copyright © 2019 allsale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN



@interface UIButton (ButtonExpand)

- (void)expandSize:(CGFloat)size;
@property (nonatomic ,strong)NSDictionary *ButtonParam;
@end

NS_ASSUME_NONNULL_END
