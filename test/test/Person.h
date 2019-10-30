//
//  Person.h
//  test
//
//  Created by allsale on 2019/8/9.
//  Copyright © 2019 allsale. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
@property (nonatomic ,copy)NSString *name;
@property (nonatomic ,copy)NSString *alex;

+ (void)run ;
+ (void)eat ;

@end

NS_ASSUME_NONNULL_END
