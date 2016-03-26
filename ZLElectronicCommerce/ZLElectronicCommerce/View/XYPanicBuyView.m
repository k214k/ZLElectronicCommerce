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
-(XYTimeView*)showTimeView
{
    if (!_showTimeView)
    {
        _showTimeView = [[XYTimeView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    }
    return _showTimeView;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.showTimeView];
    }
    return self;
}
@end
