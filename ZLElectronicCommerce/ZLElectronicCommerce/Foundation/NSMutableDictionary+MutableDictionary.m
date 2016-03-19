//
//  NSMutableDictionary+MutableDictionary.m
//  Jumploo2
//
//  Created by zl on 16/3/4.
//  Copyright © 2016年 zl. All rights reserved.
//

#import "NSMutableDictionary+MutableDictionary.h"

@implementation NSMutableDictionary (MutableDictionary)
-(NSDictionary*)deepDicCopy;
{
    return  [[NSDictionary alloc] initWithDictionary:self copyItems:YES];
}

-(NSMutableDictionary*)deepMutableDicCopy
{
    return [[NSMutableDictionary alloc] initWithDictionary:self copyItems:YES];
}

-(NSArray*)sortAllKey
{
    NSArray* array = [self allKeys];
    array = [array sortedArrayUsingSelector:@selector(compare:)];
    return array;
}

-(NSMutableDictionary*)GroupSection
{
    NSArray* array = [self allKeys];
    NSMutableSet* set = [NSMutableSet new];
    NSMutableDictionary* dic = [NSMutableDictionary new];
    for (NSString* temp in array)
    {
        //转成了可变字符串
        NSMutableString *str = [NSMutableString stringWithString:temp];
        //先转换为带声调的拼音
        CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
        //再转换为不带声调的拼音
        CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
        //转化为大写拼音
        NSString *pinYin = [str capitalizedString];
        //获取并返回首字母
        NSString* py =  [pinYin substringToIndex:1];
        NSMutableArray* tempArray = nil;
        if (![set containsObject:py])
        {
            [set addObject:py];
            tempArray = [NSMutableArray new];
            [tempArray addObject:[self objectForKey:temp]];
            
        }
        else
        {
            tempArray = dic[py];
            [tempArray addObject:[self objectForKey:temp]];
        }
        [dic setObject:tempArray forKey:py];
    }
    return dic;
}
@end
