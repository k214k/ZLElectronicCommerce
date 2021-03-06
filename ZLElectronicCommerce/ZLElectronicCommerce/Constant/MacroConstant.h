//
//  MacroConstant.h
//  ZLElectronicCommerce
//
//  Created by zhangliang on 16/3/3.
//  Copyright © 2016年 zhangl. All rights reserved.
//

#ifndef MacroConstant_h
#define MacroConstant_h
#define PRINTFLAG 1
#define WEAKSELF __weak typeof(self) weakSelf = self;
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight  [[UIScreen mainScreen] bounds].size.height
#define KPropertyStrong    @property (nonatomic, strong)
#define KPropertyWeak      @property (nonatomic, weak)
#define KPropertyAssign    @property (nonatomic, assign)
#define KPropertyCopyRead  @property (nonatomic,copy,readonly)
#define KPropertyCopy      @property (nonatomic,copy)

#define XYTimeViewLabelWidth  3
#define XYTimeViewBorderWidth 1
#define XYTimeViewBorderColor [UIColor redColor].CGColor
#define XYTimeViewWidthLabel 25
#define XYTimeViewHightLabel 18
#define XYTimeViewFontLabel  [UIFont systemFontOfSize:16]
#endif /* MacroConstant_h */
