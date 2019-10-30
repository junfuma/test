//
//  NSObject+Extension.h
//  test
//
//  Created by allsale on 2019/8/9.
//  Copyright © 2019 allsale. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Extension)
- (NSArray *)ignoredNames;
- (void)encode:(NSCoder *)aCoder;
- (void)decode:(NSCoder *)aDecoder;
@end

NS_ASSUME_NONNULL_END
