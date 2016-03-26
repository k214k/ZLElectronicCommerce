//
//  XYTimeView.h
//  ZLElectronicCommerce
//
//  Created by zhangliang on 16/3/19.
//  Copyright © 2016年 zhangl. All rights reserved.
//

#import "XYBaseView.h"
typedef void(^UpdateTimeBlock)();
@interface XYTimeView : XYBaseView
KPropertyCopy UpdateTimeBlock updateTimeBlock;
-(instancetype)initWithFrame:(CGRect)frame timeStr:(NSString*)aTimeStr;
@end
