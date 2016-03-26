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
        _hourLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, XYTimeViewWidthLabel, XYTimeViewHightLabel)];
        _hourLabel.text = @"01";
        _hourLabel.layer.cornerRadius = XYTimeViewLabelWidth;
        _hourLabel.layer.masksToBounds = YES;
        _hourLabel.layer.borderWidth = XYTimeViewBorderWidth;
        _hourLabel.layer.borderColor = XYTimeViewBorderColor;
        _hourLabel.textAlignment = NSTextAlignmentCenter;
        _hourLabel.font = XYTimeViewFontLabel;
    }
    return _hourLabel;
}
-(UILabel*)firstDotLabel
{
    if (!_firstDotLabel)
    {
        _firstDotLabel = [[UILabel alloc] initWithFrame:CGRectMake(_hourLabel.right, 0, 5, XYTimeViewHightLabel)];
        _firstDotLabel.text = @":";
        _firstDotLabel.textAlignment = NSTextAlignmentCenter;
        _firstDotLabel.font = XYTimeViewFontLabel;
    }
    return _firstDotLabel;
}
-(UILabel*)minLabel
{
    if (!_minLabel)
    {
        _minLabel = [[UILabel alloc] initWithFrame:CGRectMake(_firstDotLabel.right, 0, XYTimeViewWidthLabel, XYTimeViewHightLabel)];
        _minLabel.text = @"01";
        _minLabel.layer.cornerRadius = XYTimeViewLabelWidth;
        _minLabel.layer.masksToBounds = YES;
        _minLabel.layer.borderWidth = XYTimeViewBorderWidth;
        _minLabel.layer.borderColor = XYTimeViewBorderColor;
        _minLabel.textAlignment = NSTextAlignmentCenter;
        _minLabel.font = XYTimeViewFontLabel;
    }
    return _minLabel;
}
-(UILabel*)secondDotLabel
{
    if (!_secondDotLabel)
    {
        _secondDotLabel = [[UILabel alloc] initWithFrame:CGRectMake(_minLabel.right, 0, 5, XYTimeViewHightLabel)];
        _secondDotLabel.text = @":";
        _secondDotLabel.textAlignment = NSTextAlignmentCenter;
        _secondDotLabel.font = XYTimeViewFontLabel;
    }
    return _secondDotLabel;
}
-(UILabel*)secondLabel
{
    if (!_secondLabel)
    {
        _secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(_secondDotLabel.right, 0, XYTimeViewWidthLabel, XYTimeViewHightLabel)];
        _secondLabel.text = @"12";
        _secondLabel.layer.cornerRadius = XYTimeViewLabelWidth;
        _secondLabel.layer.masksToBounds = YES;
        _secondLabel.layer.borderWidth = XYTimeViewBorderWidth;
        _secondLabel.layer.borderColor = XYTimeViewBorderColor;
        _secondLabel.textAlignment = NSTextAlignmentCenter;
        _secondLabel.font = XYTimeViewFontLabel;
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
    NSInteger second = [_secondLabel.text integerValue];
    NSInteger min = [_minLabel.text integerValue];
    NSInteger hour = [_hourLabel.text integerValue];
    if ((min == 0)&&(hour == 0)&&(second == 0))
    {
        XY_RELEASE_TIME_SAFELY(_timer);
        [self updateData];
    }
    else
    {
        second -= 1;
        if (second < 0)
        {
            second = 59;
            min -= 1;
            if ((min < 0)&&(hour))
            {
                min = 59;
                hour -= 1;
            }
        }
    }

    _secondLabel.text = [NSString stringWithFormat:@"%02ld",(long)second];
    _minLabel.text = [NSString stringWithFormat:@"%02ld",(long)min];
    _hourLabel.text = [NSString stringWithFormat:@"%02ld",(long)hour];
}

-(void)updateData
{
    if (_updateTimeBlock)
    {
        _updateTimeBlock();
    }
}
@end
