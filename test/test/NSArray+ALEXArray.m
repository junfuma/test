//
//  NSMutableArray+ALEXArray.m
//  test
//
//  Created by allsale on 2019/10/10.
//  Copyright © 2019 allsale. All rights reserved.
//

#import "NSArray+ALEXArray.h"
#import "objc/runtime.h"



@implementation NSArray (ALEXArray)
+(void)load{

  static dispatch_once_t onceToken;
      dispatch_once(&onceToken, ^{
      SEL safeSel=@selector(safeObjectAtIndex:);
      SEL unsafeSel=@selector(objectAtIndex:);
    
      Class myClass = NSClassFromString(@"__NSArrayI");
      Method safeMethod=class_getInstanceMethod (myClass, safeSel);
      Method unsafeMethod=class_getInstanceMethod (myClass, unsafeSel);
    
      method_exchangeImplementations(unsafeMethod, safeMethod);

 });
}

-(id)safeObjectAtIndex:(NSUInteger)index{
    
    if (index>(self.count-1)) {
        NSAssert(NO, @"beyond the boundary");
        
        return nil;
    }
    else{
        return [self safeObjectAtIndex:index];
    }
}
@end
