//
//  XYTimer.m
//  Jumploo2
//
//  Created by jumploo on 16/3/4.
//  Copyright © 2016年 吴荆东. All rights reserved.
//

#import "XYTimer.h"
@interface XYTimer()
@property(nonatomic,weak)NSTimer* timer;
@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;
@end
@implementation XYTimer
+ (NSTimer *) scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      target:(id)aTarget
                                    selector:(SEL)aSelector
                                    userInfo:(id)userInfo
                                     repeats:(BOOL)repeats
{
    XYTimer* xYTimer = [XYTimer new];
    xYTimer.target = aTarget;
    xYTimer.selector = aSelector;
    [xYTimer invalidate];
    xYTimer.timer = [NSTimer scheduledTimerWithTimeInterval:interval target:xYTimer selector:@selector(fire:) userInfo:userInfo repeats:repeats];
    return xYTimer.timer;
}

- (void)invalidate
{
    if (self.timer)
    {
        [self.timer invalidate];
        self.timer = nil;
    }
}

-(void)fire:(NSTimer *)timer
{
    if ([self.target respondsToSelector:self.selector])
    {
        [self.target performSelectorOnMainThread:self.selector withObject:timer.userInfo waitUntilDone:NO];
    }
}

@end
