//
//  XYGridCollectViewFootView.m
//  ZLElectronicCommerce
//
//  Created by zhangliang on 16/3/9.
//  Copyright © 2016年 zhangl. All rights reserved.
//

#import "XYGridCollectViewFootView.h"
#import "BBCyclingLabel.h"
@interface XYGridCollectViewFootView()
KPropertyStrong NSTimer *timer;
KPropertyStrong UIScrollView *scrollView;
KPropertyStrong NSArray* tipArray;
KPropertyStrong NSMutableArray* showArray;
KPropertyAssign NSInteger selectIndex;
KPropertyAssign CGFloat   lineWidth;
@end
@implementation XYGridCollectViewFootView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        CGFloat w = [UIScreen mainScreen].scale;
        w = 1/w;
        _lineWidth = w;
        UIView* line = [[UIView alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth-20, w)];
        line.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line];
        
        UILabel* leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, line.frame.origin.y+w, 40, self.frame.size.height-w)];
        leftLabel.text = @"淘宝头条";
        leftLabel.numberOfLines = 2;
        leftLabel.font = [UIFont systemFontOfSize:18];
        leftLabel.backgroundColor = [UIColor whiteColor];
        leftLabel.textAlignment = NSTextAlignmentCenter;
        leftLabel.textColor = [UIColor redColor];
        [self addSubview:leftLabel];
        
        UIView* vline = [[UIView alloc] initWithFrame:CGRectMake(leftLabel.frame.origin.x+leftLabel.frame.size.width+5, 5, w, self.frame.size.height-10)];
        vline.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:vline];
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(vline.right, line.bottom, self.width-vline.right, self.height-line.bottom)];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.clipsToBounds = YES;
        [self addSubview:_scrollView];
        [self sendSubviewToBack:_scrollView];
        _selectIndex = MAXFLOAT;
    }
    return self;
}

-(void)showTip:(NSArray*)aArray
{
    if (!aArray.count)
    {
        return;
    }
    _tipArray = aArray;
    _selectIndex = 0;
    if (!_showArray)
    {
        _showArray = [NSMutableArray new];
    }
    [self showMessage];
    [self start];
}

-(void)showMessage
{
    NSArray* array = [_scrollView subviews];
    [array makeObjectsPerformSelector:@selector(removeFromSuperview) withObject:nil];

    [_showArray removeAllObjects];
    [_showArray addObject:[_tipArray objectAtIndex:[self pre]]];
    [_showArray addObject:[_tipArray objectAtIndex:_selectIndex]];
    [_showArray addObject:[_tipArray objectAtIndex:[self next]]];
    _scrollView.contentSize = CGSizeMake(_scrollView.width, _scrollView.height*_showArray.count);
    for (int i = 0; i < _showArray.count;++i)
    {
        XYGridFootView* footView = [[XYGridFootView alloc] initWithFrame:CGRectMake(0, _scrollView.height*i, _scrollView.width, _scrollView.height)];
        footView.model = _showArray[i];
        [_scrollView addSubview:footView];
    }
    _scrollView.contentOffset = CGPointMake(0, _scrollView.height);
}
-(NSInteger)pre
{
    NSInteger ret = _selectIndex-1;
    if (ret <= 0)
    {
        ret = _tipArray.count-1;
    }
    return ret;
}

-(NSInteger)next
{
    NSInteger ret = _selectIndex+1;
    if (ret >= _tipArray.count)
    {
        ret = 0;
    }
    return ret;
}

-(void)start
{
    if (!_timer)
    {
        _timer = [XYTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(repeat) userInfo:nil repeats:YES];
    }
}

-(void)repeat
{
    ++_selectIndex;
    _selectIndex = _selectIndex%(_tipArray.count);
    
    CABasicAnimation *animation;
    animation=[CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    animation.delegate = self;
    animation.duration = 1;
    animation.repeatCount = 0;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.autoreverses = NO;
    animation.fromValue = [NSNumber numberWithFloat:_scrollView.height];
    animation.toValue = [NSNumber numberWithFloat:0];
    [_scrollView.layer addAnimation:animation forKey:@"animateLayer"];
    [self showMessage];
    
}

@end
