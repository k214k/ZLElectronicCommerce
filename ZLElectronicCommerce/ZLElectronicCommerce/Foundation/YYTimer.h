//
//  YYTimer.h
//  Jumploo2
//
//  Created by zl on 16/3/4.
//  Copyright © 2016年 zl. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface YYTimer : NSObject
+(nullable YYTimer*)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(nullable id)aTarget selector:(nullable SEL)aSelector userInfo:(nullable id)userInfo;
+(nullable YYTimer*)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(nullable id)aTarget selector:(nullable SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo;
-(void)invalidate;
-(void)start;
@property(readonly,retain)id userInfo;
@end
NS_ASSUME_NONNULL_END