//
//  ReleaseConstant.h
//  ZLElectronicCommerce
//
//  Created by zhangliang on 16/3/3.
//  Copyright © 2016年 zhangl. All rights reserved.
//

#ifndef ReleaseConstant_h
#define ReleaseConstant_h
#undef XYRELESE
#define XY_RELEASE_SAFELY(__REF)\
{\
if(__REF)\
{\
__REF = nil;\
}\
}

#define XYVIEW_RELEASE_SAFELYY(__REF)\
{\
if(__REF)\
{\
[__REF removeFromSuperview];\
__REF = nil;\
}\
}

#define XY_RELEASE_TIME_SAFELY(__REF)\
{\
if(__REF)\
{\
 [__REF invalidate];\
 __REF = nil;\
}\
}
#endif /* ReleaseConstant_h */
