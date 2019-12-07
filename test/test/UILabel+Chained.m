//
//  UILabel+Chained.m
//  test
//
//  Created by allsale on 2019/11/2.
//  Copyright © 2019 allsale. All rights reserved.
//

#import "UILabel+Chained.h"
#import <UIKit/UIKit.h>
@implementation UILabel (Chained)

+ (UILabel *)createLabel{
    return [[UILabel alloc] init];
}

- (ChainedLabelFrameBlock)frameEqualTo{
    ChainedLabelFrameBlock block = ^UILabel *(CGRect frame){
        self.frame = frame;
        return self;
    };
    return block;
}

- (ChainedLabelBlock)textEqualTo{
    ChainedLabelBlock block = ^UILabel *(id text){
        self.text = text;
        return self;
    };
    return block;
}

- (ChainedLabelBlock)textColorEqualTo{
    ChainedLabelBlock block = ^UILabel *(id color){
        self.textColor = color;
        return self;
    };
    return block;
}

- (ChainedLabelBlock)bgColorEqualTo{
    ChainedLabelBlock block = ^UILabel *(id color){
        self.backgroundColor = (UIColor *)color;
        return self;
    };
    return block;
}
- (ChainedLabelBlock)textFontEqualTo{
    ChainedLabelBlock block = ^UILabel *(id color){
        self.font = (UIFont*)color;
        return self;
    };
    return block;
}
- (void)dealloc{
    NSLog(@"ChainedLabel dealloc");
}

@end



