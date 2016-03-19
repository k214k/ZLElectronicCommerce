//
//  NSMutableArray+MutableArray.m
//  Jumploo2
//
//  Created by zl on 16/3/4.
//  Copyright © 2016年 zl. All rights reserved.
//

#import "NSMutableArray+MutableArray.h"

@implementation NSMutableArray (MutableArray)
-(id)objectSafeAtIndex:(int)index
{
    if (index < 0||index > self.count)
    {
        return nil;
    }
    return [self objectAtIndex:index];
}
-(id)deepCopy
{
    return [[NSArray alloc] initWithArray:self copyItems:YES];
}

-(id)deepMutableCopy
{
    return [[NSMutableArray alloc] initWithArray:self copyItems:YES];
}

-(void)removeFirstObject
{
    id firstObject = self.firstObject;
    if (firstObject)
    {
        [self removeObject:firstObject];
    }
}
@end
