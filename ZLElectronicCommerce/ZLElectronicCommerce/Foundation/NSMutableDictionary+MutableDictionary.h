//
//  NSMutableDictionary+MutableDictionary.h
//  Jumploo2
//
//  Created by zl on 16/3/4.
//  Copyright © 2016年 zl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (MutableDictionary)
-(NSDictionary*)deepDicCopy;
-(NSMutableDictionary*)deepMutableDicCopy;
-(NSArray*)sortAllKey;
-(NSMutableDictionary*)GroupSection;
@end
