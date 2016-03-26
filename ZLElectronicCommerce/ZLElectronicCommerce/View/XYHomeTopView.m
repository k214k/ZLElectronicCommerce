//
//  XYHomeTopView.m
//  ZLElectronicCommerce
//
//  Created by zhangliang on 16/3/4.
//  Copyright © 2016年 zhangl. All rights reserved.
//

#import "XYHomeTopView.h"
@interface XYHomeTopView()<UIScrollViewDelegate>
KPropertyStrong UIScrollView* scrollView;
KPropertyStrong UIPageControl* pageControl;
KPropertyStrong NSTimer* timer;
KPropertyStrong NSMutableArray* scrollViewArray;
KPropertyStrong NSMutableArray* imageArray;
KPropertyAssign NSInteger selectIndex;
@end
@implementation XYHomeTopView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.userInteractionEnabled = YES;
        [self createData];
        [self createView];
    }
    return self;
}

-(void)createData
{
    _selectIndex = MAXFLOAT;
    _scrollViewArray = [NSMutableArray new];
    _imageArray = [NSMutableArray new];
}
-(UIPageControl*)pageControl
{
    if (!_pageControl)
    {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height-20, kScreenWidth, 20)];
        _pageControl.pageIndicatorTintColor = [UIColor blueColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.currentPage = 0;
    }
    return _pageControl;
}
-(UIScrollView*)scrollView
{
    if (!_scrollView)
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.frame.size.height)];
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
    }
    return _scrollView;
}

-(void)createView
{
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
}
//点击事件
-(void)Tap:(UITapGestureRecognizer*)aTap
{//预留接口
    if ([_delegate respondsToSelector:@selector(selectTopIndex:)])
    {
        
    }
}

-(void)imageStrArray
{
    for (int i = 0;i < 8; ++i)
    {
        NSString* str = [NSString stringWithFormat:@"%d.jpg",i+1];
        [_imageArray addObject:str];
    }
    _pageControl.numberOfPages = _imageArray.count;
    _selectIndex = 0;
    [self refreshView];
    [self startTime];
}

-(void)refreshView
{
    self.pageControl.currentPage = _selectIndex;
    
    NSArray *temp = [_scrollView subviews];
    [temp makeObjectsPerformSelector:@selector(removeFromSuperview) withObject:nil];
    
    [_scrollViewArray removeAllObjects];
    
    [_scrollViewArray addObject:[_imageArray objectAtIndex:[self preIndex]]];
    [_scrollViewArray addObject:[_imageArray objectAtIndex:_selectIndex]];
    [_scrollViewArray addObject:[_imageArray objectAtIndex:[self nextIndex]]];
    
    _scrollView.contentSize = CGSizeMake(kScreenWidth*_scrollViewArray.count,_scrollView.frame.size.height);
    
    for (int i = 0;i < _scrollViewArray.count;++i)
    {
        UIImage* image = [UIImage imageNamed:_scrollViewArray[i]];
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth*i,0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
        imageView.userInteractionEnabled = YES;
        imageView.image = [image copy];
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Tap:)];
        [imageView addGestureRecognizer:tap];
        [_scrollView addSubview:imageView];
    }
    [_scrollView setContentOffset:CGPointMake(kScreenWidth, 0)];
}

-(NSInteger)preIndex
{
    NSInteger currentIndex = _selectIndex-1;
    if (_selectIndex == 0)
    {
        currentIndex = _imageArray.count-1;
    }
    return currentIndex;
}

-(NSInteger)nextIndex
{
    NSInteger currentIndex = _selectIndex+1;
    if (_selectIndex+1 >= _imageArray.count)
    {
        currentIndex = 0;
    }
    return currentIndex;
}

-(void)startTime
{
    _timer = [XYTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(repeat) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

-(void)repeat
{
    ++_selectIndex;
    _selectIndex = _selectIndex%(_imageArray.count);
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromRight];
    [_scrollView.layer addAnimation:animation forKey:nil];
    [self refreshView];
    self.pageControl.currentPage = _selectIndex;
}

-(void)stopTime
{
    if (_timer)
    {
        XY_RELEASE_TIME_SAFELY(_timer);
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset = _scrollView.contentOffset.x;
    if (offset >= 2* kScreenWidth)
    {
        ++_selectIndex;
        _selectIndex = _selectIndex%(_imageArray.count);
        [self refreshView];
    }
    if (offset <= 0)
    {
        if (_selectIndex == 0) {
            _selectIndex = _imageArray.count-1;
        }
        else
        {
            --_selectIndex;
        }
        [self refreshView];
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{//开始拖拽的时候开始执行
    [self stopTime];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{//停止拖拽的时候开始执行
    [self startTime];;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{//减速停止的时候开始执行
    [_scrollView setContentOffset:CGPointMake(kScreenWidth, 0) animated:YES];
}
@end
