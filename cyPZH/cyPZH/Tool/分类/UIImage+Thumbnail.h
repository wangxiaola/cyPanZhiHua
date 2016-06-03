//
//  UIImage+Thumbnail.h
//  slyjg
//
//  Created by 汤亮 on 16/4/25.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ZKThumbnailImage(originalImage, targetSize) \
[originalImage imageByScalingAndCroppingForSize:targetSize]

@interface UIImage (Thumbnail)
//将图片变成指定大小的缩略图
- (UIImage *)imageByScalingAndCroppingForSize:(CGSize)targetSize;
@end
