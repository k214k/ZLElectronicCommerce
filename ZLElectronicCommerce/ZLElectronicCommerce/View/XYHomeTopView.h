//
//  XYHomeTopView.h
//  ZLElectronicCommerce
//
//  Created by zhangliang on 16/3/4.
//  Copyright © 2016年 zhangl. All rights reserved.
//

#import "XYBaseView.h"

@interface XYHomeTopView : XYBaseView
@property(weak,nonatomic)id<XYHomeTopViewDelegate>delegate;
-(void)imageStrArray;
@end
