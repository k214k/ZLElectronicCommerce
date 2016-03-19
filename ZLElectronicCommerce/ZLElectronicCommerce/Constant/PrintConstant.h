//
//  PrintConstant.h
//  ZLElectronicCommerce
//
//  Created by zhangliang on 16/3/3.
//  Copyright © 2016年 zhangl. All rights reserved.
//

#ifndef PrintConstant_h
#define PrintConstant_h
#undef PRINT
#ifdef PRINTFLAG
#define PRINT(CMD) NSLog(@"%@-%d",NSStringFromSelector(_cmd),__LINE__)
#else
#define PRINT(CMD)
#endif

#endif /* PrintConstant_h */
