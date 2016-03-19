//
//  XYGridCollectionViewCell.m
//  ZLElectronicCommerce
//
//  Created by zhangliang on 16/3/5.
//  Copyright © 2016年 zhangl. All rights reserved.
//

#import "XYGridCollectionViewCell.h"
@interface XYGridCollectionViewCell()
KPropertyStrong UIImageView* imageView;
KPropertyStrong UILabel* nameLabel;
@end
@implementation XYGridCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];

        CGFloat w = frame.size.width;
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, w-30,w-30)];
        self.imageView.layer.masksToBounds = YES;
        self.imageView.layer.cornerRadius = (w-30)/2;
        self.imageView.layer.borderWidth = 0.0;
        [self addSubview:self.imageView];
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.imageView.frame.origin.y+self.imageView.frame.size.height, w, 30)];
        self.nameLabel.font = [UIFont systemFontOfSize:10];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.nameLabel];
        
    }
    return self;
}
-(void)setModel:(XYGridModel *)model
{
    self.imageView.image = [UIImage imageNamed:model.imagesStr];
    self.nameLabel.text = [model.nameStr copy];
}
@end
