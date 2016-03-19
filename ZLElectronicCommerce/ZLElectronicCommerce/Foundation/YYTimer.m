//
//  YYTimer.m
//  Jumploo2
//
//  Created by zl on 16/3/4.
//  Copyright © 2016年 zl. All rights reserved.
//

#import "YYTimer.h"

@interface YYTimer()
@property(nonatomic,assign)NSTimeInterval ti;
@property(nonatomic,weak)id aTarget;
@property(nonatomic,assign)SEL aSelector;
@property(nonatomic,assign)BOOL yesOrNo;
@end
@implementation YYTimer
+(nullable YYTimer*)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(nullable id)aTarget selector:(nullable SEL)aSelector userInfo:(nullable id)userInfo
{
    YYTimer* __singleton = [YYTimer new];
    __singleton.ti = ti;
    __singleton.aTarget = aTarget;
    __singleton.aSelector = aSelector;
    __singleton.userInfo = userInfo;
    __singleton.yesOrNo = NO;
    return __singleton;
}

+(nullable YYTimer*)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(nullable id)aTarget selector:(nullable SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo
{
    YYTimer* __singleton = [YYTimer new];
    __singleton.ti = ti;
    __singleton.aTarget = aTarget;
    __singleton.aSelector = aSelector;
    __singleton.userInfo = userInfo;
    __singleton.yesOrNo = yesOrNo;
    [__singleton repeatFunction];
    return __singleton;
}

-(void)setUserInfo:(id _Nullable)userInfo
{
    _userInfo = userInfo;
}

-(void)repeatFunction
{
    WEAKSELF
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.ti * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        if ([weakSelf.aTarget respondsToSelector:weakSelf.aSelector])
        {
            [weakSelf.aTarget performSelectorOnMainThread:weakSelf.aSelector withObject:weakSelf.userInfo waitUntilDone:NO];
            if (weakSelf.yesOrNo)
            {
                [weakSelf repeatFunction];
            }

        }
    });
}

-(void)invalidate
{
    _yesOrNo = NO;
}

-(void)start
{
    _yesOrNo = YES;
    [self repeatFunction];
}

@end
