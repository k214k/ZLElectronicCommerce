//
//  XYTimeView.m
//  ZLElectronicCommerce
//
//  Created by zhangliang on 16/3/19.
//  Copyright © 2016年 zhangl. All rights reserved.
//

#import "XYTimeView.h"
@interface XYTimeView()
KPropertyStrong NSTimer* timer;
KPropertyCopy   NSString* timeStr;
KPropertyStrong UIView* baseView;
KPropertyStrong UILabel* hourLabel;
KPropertyStrong UILabel* minLabel;
KPropertyStrong UILabel* secondLabel;
KPropertyStrong UILabel* firstDotLabel;
KPropertyStrong UILabel* secondDotLabel;
@end
@implementation XYTimeView
-(instancetype)initWithFrame:(CGRect)frame timeStr:(NSString*)aTimeStr
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _timeStr = [aTimeStr copy];
        [self createView];
        [self createData];
        [self startTime];
    }
    return self;
}

-(UIView*)baseView
{
    if (!_baseView)
    {
        _baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 21)];
    }
    return _baseView;
}
-(UILabel*)hourLabel
{
    if (!_hourLabel)
    {
        _hourLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 21)];
        _hourLabel.text = @"12";
        _hourLabel.textAlignment = NSTextAlignmentCenter;
        _hourLabel.font = [UIFont systemFontOfSize:12];
    }
    return _hourLabel;
}
-(UILabel*)firstDotLabel
{
    if (!_firstDotLabel)
    {
        _firstDotLabel = [[UILabel alloc] initWithFrame:CGRectMake(_hourLabel.right, 0, 5, 21)];
        _firstDotLabel.text = @":";
        _firstDotLabel.text = @"12";
        _firstDotLabel.textAlignment = NSTextAlignmentCenter;
        _firstDotLabel.font = [UIFont systemFontOfSize:12];
    }
    return _firstDotLabel;
}
-(UILabel*)minLabel
{
    if (!_minLabel)
    {
        _minLabel = [[UILabel alloc] initWithFrame:CGRectMake(_firstDotLabel.right, 0, 20, 21)];
        _minLabel.text = @"12";
        _minLabel.textAlignment = NSTextAlignmentCenter;
        _minLabel.font = [UIFont systemFontOfSize:12];
    }
    return _minLabel;
}
-(UILabel*)secondDotLabel
{
    if (!_secondDotLabel)
    {
        _secondDotLabel = [[UILabel alloc] initWithFrame:CGRectMake(_minLabel.right, 0, 5, 21)];
        _secondDotLabel.text = @":";
        _secondDotLabel.text = @"12";
        _secondDotLabel.textAlignment = NSTextAlignmentCenter;
        _secondDotLabel.font = [UIFont systemFontOfSize:12];
    }
    return _secondDotLabel;
}
-(UILabel*)secondLabel
{
    if (!_secondLabel)
    {
        _secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(_secondDotLabel.right, 0, 20, 21)];
        _secondLabel.text = @"12";
        _secondLabel.textAlignment = NSTextAlignmentCenter;
        _secondLabel.font = [UIFont systemFontOfSize:12];
    }
    return _secondLabel;
}

-(void)createView
{
    [self addSubview:self.baseView];
    [_baseView addSubview:self.hourLabel];
    [_baseView addSubview:self.firstDotLabel];
    [_baseView addSubview:self.minLabel];
    [_baseView addSubview:self.secondDotLabel];
    [_baseView addSubview:self.secondLabel];
    
}

-(void)createData
{
    
}

-(void)startTime
{
    XY_RELEASE_TIME_SAFELY(_timer);
    if (!_timer)
    {
        _timer = [XYTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(repeatTime) userInfo:nil repeats:YES];
    }
}

-(void)repeatTime
{
    
}
@end
