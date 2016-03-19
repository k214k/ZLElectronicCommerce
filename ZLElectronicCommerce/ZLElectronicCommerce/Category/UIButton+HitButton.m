//
//  UIButton+HitButton.m
//  testAuty
//
//  Created by jumploo on 16/3/11.
//  Copyright © 2016年 zl. All rights reserved.
//

#import "UIButton+HitButton.h"
#import <objc/runtime.h>
#define fequal(a,b) (fabs((a) - (b)) < FLT_EPSILON)
#define fequalzero(a) (fabs(a) < FLT_EPSILON)
static char *kUIButtonKey;
static char *kUIButtonStartKey;
#define KTIME 5
@interface UIButton ()
@property(nonatomic,assign)BOOL isStart;
@end
@implementation UIButton (HitButton)
+(void)load
{
    Class class = [self class];
    
    SEL org = @selector(sendAction:to:forEvent:);
    SEL new = @selector(mySendAction:to:forEvent:);
    
    Method methodA = class_getInstanceMethod(class, org);
    Method methodB = class_getInstanceMethod(class, new);
    
    BOOL isAdd = class_addMethod(class, new,method_getImplementation(methodA) ,method_getTypeEncoding(methodA));
    if (isAdd)
    {
        class_replaceMethod(class,new,method_getImplementation(methodA),method_getTypeEncoding(methodA));
        
    }
    else
    {
        method_exchangeImplementations(methodA, methodB);
    }
}

- (void)mySendAction:(SEL)action to:(nullable id)target forEvent:(nullable UIEvent *)event
{
    if ([self isKindOfClass:[UIButton class]])
    {
        if (self.isStart)
        {
            return;
        }
        else
        {
            if (self.timeInterval < DBL_EPSILON)
            {
                self.timeInterval = KTIME;
            }
            self.isStart = YES;
            [self performSelector:@selector(setIsStart:) withObject:@(NO) afterDelay:self.timeInterval];
        }
    }
    [self mySendAction:action to:target forEvent:event];
}

-(NSTimeInterval)timeInterval
{
    return [objc_getAssociatedObject(self, &kUIButtonKey) doubleValue];
}

-(void)setTimeInterval:(NSTimeInterval)timeInterval
{
    objc_setAssociatedObject(self, &kUIButtonKey, @(timeInterval), OBJC_ASSOCIATION_RETAIN);
}

-(void)setIsStart:(BOOL)isStart
{
    objc_setAssociatedObject(self,&kUIButtonStartKey, @(isStart), OBJC_ASSOCIATION_ASSIGN);
}

-(BOOL)isStart
{
    return [objc_getAssociatedObject(self, &kUIButtonStartKey) boolValue];
}
@end
