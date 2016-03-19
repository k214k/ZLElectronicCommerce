//
//  PullScrollView.m
//  testAuty
//
//  Created by jumploo on 16/3/11.
//  Copyright © 2016年 zl. All rights reserved.
//

#import "PullScrollView.h"
@interface PullScrollView()
{
    UIView* headerView;
    NSString* titleWillPull;
    NSString* titlePulling;
    NSString* titlePulled;
    UIActivityIndicatorView* activity;
    UIImageView* arrowImageView;
    UILabel* tipLabel;
    BOOL isRefresh;
    CGFloat lastPointY;
    CGFloat headerHeight;
}
@end
@implementation PullScrollView
-(instancetype)init
{
    self = [super init];
    if (self)
    {
        titleWillPull = @"下拉可刷新";
        titlePulling  = @"松开立即刷新";
        titlePulled   = @"正在刷新中...";
        
    }
    return self;
}
- (void)header
{
    headerHeight = 34;
    CGRect frame = [UIScreen mainScreen].bounds;
    headerView = [[UIView alloc] initWithFrame:CGRectMake(0, -44, frame.size.width, 44)];
    headerView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:headerView];
    // [self addSubview:headerView];
    
    tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    tipLabel.text = titleWillPull;
    tipLabel.textColor = [UIColor blackColor];
    tipLabel.font = [UIFont systemFontOfSize:14];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.centerX = headerView.centerX;
    [headerView addSubview:tipLabel];
    
    arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(tipLabel.left-50, 2, 13, 35)];
    arrowImageView.image = [UIImage imageNamed:@"down"];
    arrowImageView.backgroundColor = [UIColor clearColor];
    [headerView addSubview:arrowImageView];
    
    activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activity.frame = CGRectMake(arrowImageView.left-20, 12, 20, 20);
    activity.backgroundColor = [UIColor clearColor];
    activity.hidesWhenStopped = YES;
    [headerView addSubview:activity];
    
    
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"])
    {
        if (_scrollView.isDragging)
        {
            if (!isRefresh)
            {
                CGFloat y = _scrollView.contentOffset.y;
                [UIView animateWithDuration:0.3 animations:^{
                    if (y < -1.5*headerHeight)
                    {
                        tipLabel.text = titlePulling;
                        arrowImageView.transform = CGAffineTransformMakeRotation(M_PI);
                    }
                    else
                    {
                        CGFloat currentY = y;
                        if (currentY - lastPointY > 5)
                        {
                            lastPointY = currentY;
                            tipLabel.text = titleWillPull;
                            arrowImageView.transform = CGAffineTransformMakeRotation(M_PI*2);
                        }
                        else if (lastPointY - currentY > 5)
                        {
                            lastPointY = currentY;
                        }
                    }
                }];

            }
            
        }
        else
        {
            if ([tipLabel.text isEqualToString:titlePulling])
            {
                [self beginRefresh];
            }
        }
    }
}
- (void)beginRefresh
{
    if (!isRefresh)
    {
        isRefresh = YES;
        [activity startAnimating];
        tipLabel.text = titlePulled;
        arrowImageView.transform = CGAffineTransformMakeRotation(M_PI);
        WEAKSELF
        [UIView animateWithDuration:0.3 animations:^{
            CGFloat y = weakSelf.scrollView.contentOffset.y;
            if (y > -1.5*34)
            {
                weakSelf.scrollView.contentOffset = CGPointMake(0, y - 1.5*headerHeight);
            }
            weakSelf.scrollView.contentInset = UIEdgeInsetsMake(1.5*headerHeight, 0, 0, 0);
        }];
        if (weakSelf.refreshBlock)
        {
            weakSelf.refreshBlock();
        }
    }
}
- (void)endRefresh
{
    isRefresh = NO;
    WEAKSELF
    dispatch_async(dispatch_get_main_queue(), ^(){
        [UIView animateWithDuration:0.3 animations:^{
            CGFloat y = weakSelf.scrollView.contentOffset.y;
            if (y > 0)
            {
                weakSelf.scrollView.contentOffset = CGPointMake(0, y + 1.5*headerHeight);
            }
            weakSelf.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            [activity stopAnimating];
            tipLabel.text = titleWillPull;
            arrowImageView.transform = CGAffineTransformMakeRotation(M_PI*2);
            
        }];
    });


}
@end
