//
//  DQUtil.h
//  ChangYouYiBin
//
//  Created by Daqsoft-Mac on 14/11/24.
//  Copyright (c) 2014年 StrongCoder. All rights reserved.
//


#import "ZKUtil.h"

@interface ZKUtil : NSObject

/**
 *  取出缓存
 *
 *  @param key 标示符
 *
 *  @return 数据
 */
+ (id)readForKey:(NSString*)key;

/**
 *  缓存策略
 *
 *  @param data       数据
 *  @param key 标示符
 *
 *  @return 是否存入
 */
+ (void)write:(id)data forKey:(NSString*)key;

/**
 *  uilabel的状态
 *
 *  @param size 限制的宽高
 *  @param font 字体大小
 *  @param str  内容
 *
 *  @return 返回的 CGSize
 */
+(CGSize)contentLabelSize:(CGSize)size labelFont:(float)font labelText:(NSString*)str;
//取bool变量
+(BOOL)MyboolForKey:(NSString *)defaultName;
//存bool变量
+(void)MyboolForKey:(NSString *)defaultName setBool:(BOOL)value;
/**
 *  NSUserDefaults取值
 *
 *  @sK 要取的key
 *
 *  @id 返回的值
 */
+(NSString*)ToTakeTheKey:(NSString*)sK;
/**
 *  NSUserDefaults存
 *
 *  @YouValue 要存的值
 *
 *  @MKey 值的key
 */
+(void)MyValue:(NSString*)YouValue MKey:(NSString*)YouKey;

/**
 *  正则判断手机号码地址格式
 *
 *  @param mobileNum 号码
 *
 *  @return yes为是
 */
+(BOOL)isMobileNumber:(NSString *)mobileNum;
/**
 *  判断字符是否以字母开头
 *
 *  @param str 需验证的字符
 *
 *  @return yes为是
 */
+(BOOL)character:(NSString*)str;

/**
 *  返回图片
 *
 *  @param image self
 *  @param url   url
 */
+(void)UIimageView:(UIImageView*)image NSSting:(NSString*)url;
/**
 *  返回图片并且自定义传err图片
 *
 *  @param image       self
 *  @param url         url
 *  @param duImageName 错误图片
 */
+(void)UIimageView:(UIImageView*)image NSSting:(NSString*)url  duImage:(NSString*)duImageName;



@end
