//
//  DQUtil.m
//  ChangYouYiBin
//
//  Created by Daqsoft-Mac on 14/11/24.
//  Copyright (c) 2014年 StrongCoder. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"

@implementation ZKUtil

+ (id)readForKey:(NSString*)key;
{

    return [NSKeyedUnarchiver unarchiveObjectWithFile:[kDocumentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.dataFile",key]]];
}
+ (void)write:(id)data forKey:(NSString*)key;
{
    if (data) {
        
        dispatch_queue_t queue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        dispatch_async(queue, ^{
            
            [NSKeyedArchiver archiveRootObject:data toFile:[kDocumentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.dataFile",key]]];
            
        });
    }

}

+(CGSize)contentLabelSize:(CGSize)size labelFont:(float)font labelText:(NSString*)str
{
    
  return [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    
}


- (UIImage*)imageFromRGB565:(void*)rawData width:(int)width height:(int)height
{
    const size_t bufferLength = width * height * 2;
    NSData *data = [NSData dataWithBytes:rawData length:bufferLength];
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((CFDataRef)data);
    
    // Creating CGImage from cv::Mat
    CGImageRef imageRef = CGImageCreate(width,          //width
                                        height,         //height
                                        5,              //bits per component
                                        16,             //bits per pixel
                                        width * 2,      //bytesPerRow
                                        colorSpace,     //colorspace
                                        kCGImageAlphaNoneSkipFirst | kCGBitmapByteOrder16Little,// bitmap info
                                        provider,               //CGDataProviderRef
                                        NULL,                   //decode
                                        false,                  //should interpolate
                                        kCGRenderingIntentDefault   //intent
                                        );
    
    // Getting UIImage from CGImage
    UIImage *finalImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);
    
    return finalImage;
}



+ (BOOL)MyboolForKey:(NSString *)defaultName;
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:defaultName];

}
+ (void)MyboolForKey:(NSString *)defaultName setBool:(BOOL)value;
{
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:defaultName];
    [[NSUserDefaults standardUserDefaults] synchronize];


}
+(NSString*)ToTakeTheKey:(NSString*)sK;
{

    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    if (defaults) {
        
        NSString *phone=[defaults objectForKey:sK];
        return phone;
    }else{
    
        return nil;
    }

}

+(void)MyValue:(NSString*)YouValue MKey:(NSString*)YouKey;
{
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:YouValue forKey:YouKey];
    [defaults synchronize];
}



+(BOOL)isMobileNumber:(NSString *)mobileNum;
{


    NSPredicate* phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"1[34578]([0-9]){9}"];
    
    return [phoneTest evaluateWithObject:mobileNum];
    
}

+(BOOL)character:(NSString*)str;
{
    NSString *regex = @"[A-Za-z]+";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    NSString *k =[str substringToIndex:1];
    return [predicate evaluateWithObject:k];
        
    
}


+ (void)UIimageView:(UIImageView*)image NSSting:(NSString*)url;
{
    [image sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"cell_ default"]];
  
}


+( void)UIimageView:(UIImageView*)image NSSting:(NSString*)url  duImage:(NSString*)duImageName;
{
  [image sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:duImageName]];

}

+ (void)UIButtonImage:(UIButton*)bty NSSting:(NSString*)url;
{
    [bty sd_setBackgroundImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal];
}

+ (NSString *)timeStamp
{
    NSTimeInterval time= [[NSDate date] timeIntervalSince1970] * 1000;
    
    return [NSString stringWithFormat:@"%lld", (long long)time];
}




@end
