//
//  NSString+String.m
//  Jumploo2
//
//  Created by jumploo on 16/3/4.
//  Copyright © 2016年 吴荆东. All rights reserved.
//

#import "NSString+String.h"

@implementation NSString (String)
-(NSString*)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

-(NSString*)objectStringIndex:(NSUInteger)aIndex
{
    if (aIndex >= self.length)
    {
        return nil;
    }
    return [self substringWithRange:NSMakeRange(aIndex,1)];
}

-(NSUInteger)byteCal:(NSUInteger)alength
{
    const char * ch = [self UTF8String];
    if (strlen(ch) == alength)
    {
        return alength;
    }
    else
    {
        int sum = 0;
        for(int i = 0;i < self.length;++i)
        {
            NSString* str = [self substringWithRange:NSMakeRange(i,1)];
            sum += strlen([str UTF8String]);
            if (sum >= alength)
            {
                break;
            }
        }
        return sum;
    }
}

@end
