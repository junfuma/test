//
//  UUIView+ZXLayout.h
//  Pods
//
//  Created by zhouXian on 2017/7/21.
//
//

#import <UIKit/UIKit.h>

@interface UIView (ZXLayout)
@property (nonatomic, assign) CGFloat zx_x;
@property (nonatomic, assign) CGFloat zx_y;
@property (nonatomic, assign) CGFloat zx_width;
@property (nonatomic, assign) CGFloat zx_height;

@property (nonatomic, assign) CGPoint zx_origin;
@property (nonatomic, assign) CGSize  zx_size;

@property(nonatomic, assign) CGFloat zx_centerX;
@property(nonatomic, assign) CGFloat zx_centerY;

@property (assign, nonatomic) CGFloat zx_bottom;
@property (assign, nonatomic) CGFloat zx_right;
@end
