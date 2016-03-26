//
//  XYPanicBuyView.m
//  ZLElectronicCommerce
//
//  Created by zhangliang on 16/3/19.
//  Copyright © 2016年 zhangl. All rights reserved.
//

#import "XYPanicBuyView.h"
@interface XYPanicBuyView()
@property(nonatomic,strong)XYTimeView* showTimeView;
@end
@implementation XYPanicBuyView
-(void)updateDate
{
    if ([_delegate respondsToSelector:@selector(upDateTimer)])
    {
        [_delegate upDateTimer];
    }
}

-(XYTimeView*)showTimeView
{
    if (!_showTimeView)
    {
        WEAKSELF
        _showTimeView = [[XYTimeView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100) timeStr:nil];
        _showTimeView.updateTimeBlock = ^(){
            [weakSelf updateDate];
        };
    }
    return _showTimeView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.showTimeView];
    }
    return self;
}

@end
