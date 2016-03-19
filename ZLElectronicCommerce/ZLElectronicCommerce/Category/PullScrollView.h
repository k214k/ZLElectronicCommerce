//
//  PullScrollView.h
//  testAuty
//
//  Created by jumploo on 16/3/11.
//  Copyright © 2016年 zl. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^BeginRfreshBlock)(void);
@interface PullScrollView : NSObject
@property(nonatomic,strong)UIScrollView* scrollView;
@property(nonatomic,copy)BeginRfreshBlock refreshBlock;
- (void)header;
- (void)beginRefresh;
- (void)endRefresh;
@end
