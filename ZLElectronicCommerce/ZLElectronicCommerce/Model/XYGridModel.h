//
//  XYGridModel.h
//  ZLElectronicCommerce
//
//  Created by zhangliang on 16/3/5.
//  Copyright © 2016年 zhangl. All rights reserved.
//

#import "XYBaseModel.h"

@interface XYGridModel : XYBaseModel
@property(nonatomic,copy)NSString* nameStr;
@property(nonatomic,copy)NSString* imagesStr;
@end


@interface XYGridFootModel : XYBaseModel
@property(nonatomic,copy)NSString* firstStr;
@property(nonatomic,copy)NSString* secondStr;
@end