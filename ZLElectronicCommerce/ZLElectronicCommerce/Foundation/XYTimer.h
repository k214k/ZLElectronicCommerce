//
//  XYTimer.h
//  Jumploo2
//
//  Created by zl on 16/3/4.
//  Copyright © 2016年 zl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYTimer : NSObject
+ (NSTimer *) scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      target:(id)aTarget
                                    selector:(SEL)aSelector
                                    userInfo:(id)userInfo
                                     repeats:(BOOL)repeats;
- (void)invalidate;
@end
