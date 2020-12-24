//
//  FRLawlib-Bridging-Header.h
//  FRLawlib
//
//  Created by Lynn Hui on 2020/10/9.
//

#ifndef FRLawlib_Bridging_Header_h
#define FRLawlib_Bridging_Header_h

#ifndef __OPTIMIZE__
#define NSLog(format, ...) printf("[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define NSLog(format, ...)
#endif

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define isFullScreen [FRBaseOCViewController isIPhoneX]
#define kBottomSpaceHeight (isFullScreen ? 34.f : 0.f)
#define rgba(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define kString(a) ((a == nil || [a isKindOfClass:[NSNull class]]) ? @"" : a)

#import "WXApi.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"
#import "FMDB.h"

#endif /* FRLawlib_Bridging_Header_h */
