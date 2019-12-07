//
//  UILabel+Chained.h
//  test
//
//  Created by allsale on 2019/11/2.
//  Copyright © 2019 allsale. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef UILabel *(^ChainedLabelBlock) (id);
typedef UILabel *(^ChainedLabelFrameBlock) (CGRect frame);

@interface UILabel (Chained)
+ (UILabel *)createLabel;
- (ChainedLabelFrameBlock)frameEqualTo;
- (ChainedLabelBlock)bgColorEqualTo;
- (ChainedLabelBlock)textColorEqualTo;
- (ChainedLabelBlock)textEqualTo;
- (ChainedLabelBlock)textFontEqualTo;
@end

NS_ASSUME_NONNULL_END
