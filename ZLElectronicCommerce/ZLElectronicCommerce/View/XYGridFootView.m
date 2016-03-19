//
//  XYGridFootView.m
//  ZLElectronicCommerce
//
//  Created by zhangliang on 16/3/10.
//  Copyright © 2016年 zhangl. All rights reserved.
//

#import "XYGridFootView.h"
@interface XYGridFootView()
KPropertyStrong UILabel* firstLabel;
KPropertyStrong UILabel* secondLabel;
@end
@implementation XYGridFootView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {

        UIView* redFirst = [[UIView alloc] initWithFrame:CGRectMake(5, 13+10, 5, 5)];
        [redFirst.layer setCornerRadius:2.5];
        [redFirst.layer setMasksToBounds:YES];
        redFirst.backgroundColor = [UIColor blueColor];
        [self addSubview:redFirst];
        
        _firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(redFirst.right+5, redFirst.top-6, self.width-10, 16)];
        _firstLabel.font = [UIFont systemFontOfSize:12];
        _firstLabel.backgroundColor = [UIColor clearColor];
        _firstLabel.clipsToBounds = YES;
        [self addSubview:_firstLabel];
        
        UIView* redSecond = [[UIView alloc] initWithFrame:CGRectMake(redFirst.left, _firstLabel.bottom+5, 5, 5)];
        [redSecond.layer setCornerRadius:2.5];
        [redSecond.layer setMasksToBounds:YES];
        redSecond.backgroundColor = [UIColor blueColor];
        [self addSubview:redSecond];
        
        _secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(redSecond.right+5, redSecond.top-6, self.width-10, 16)];
        _secondLabel.font = [UIFont systemFontOfSize:12];
        _secondLabel.backgroundColor = [UIColor clearColor];
        _secondLabel.clipsToBounds = YES;
        [self addSubview:_secondLabel];
        
    }
    return self;
}

-(void)setModel:(XYGridFootModel *)model
{
    _firstLabel.text = [model.firstStr copy];
    _secondLabel.text = [model.secondStr copy];
}
@end
