//
//  NSMutableArray+MutableArray.h
//  Jumploo2
//
//  Created by zl on 16/3/4.
//  Copyright © 2016年 zl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (MutableArray)
-(id)objectSafeAtIndex:(int)index;
-(id)deepCopy;
-(id)deepMutableCopy;
-(void)removeFirstObject;
@end
