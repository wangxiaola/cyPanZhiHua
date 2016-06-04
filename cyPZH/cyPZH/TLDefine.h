
#ifndef _TLDEFINE_H_
#define _TLDEFINE_H_

// 补全图片路径
#define FullImagePath(suffix) [NSString stringWithFormat:@"%@", suffix];
// HUD
#define HUDShowLoading(prompt) [SVProgressHUD showWithStatus:prompt];
#define HUDShowSuccess(success) [SVProgressHUD showSuccessWithStatus:success];
#define HUDShowError(error) [SVProgressHUD showErrorWithStatus:error];
#define HUDShowFailure [SVProgressHUD showErrorWithStatus:@"网络错误"];
#define HUDDissmiss [SVProgressHUD dismiss];


// 屏幕
#define _SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define _SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


// 颜色
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RANDOMCOLOR [UIColor colorWithRed:(arc4random()%256)/255.0 green:(arc4random()%256)/255.0 blue:(arc4random()%256)/255.0 alpha:1]


// 控制器view的背景色
#define ZKViewBackgroundColor RGB(248, 248, 248)
// 导航条标题颜色
#define ZKTitleColor RGB(78, 147, 232)


// 判断系统版本
#define __IPHONE_CURRENT_VERSION [UIDevice currentDevice].systemVersion.doubleValue
#define __iOS8_OR_LATTER __IPHONE_CURRENT_VERSION > 8.0
#define __iOS9_OR_LATTER __IPHONE_CURRENT_VERSION > 9.0
#define __ONLY_iOS8 __IPHONE_CURRENT_VERSION >= 8.0 && __IPHONE_CURRENT_VERSION < 9.0
#define __ONLY_iOS9 __IPHONE_CURRENT_VERSION >= 9.0 && __IPHONE_CURRENT_VERSION < 10.0


// DEBUG LOG
#ifdef DEBUG
#define MMLog( s, ... ) NSLog( @"< %@ > ( 第%d行 ) %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define MMLog( s, ... )
#endif


// 在iOS8下刷新布局
#define AutoLayoutUpdateWhenIOS8 \
if (__ONLY_iOS8) { \
    [self updateConstraintsIfNeeded]; \
}

#endif