//
//  UIImage+PKImage.h
//  PKResManager
//
//  Created by zhongsheng on 12-11-27.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (PKImage)

/*!
 *   @method
 *   @abstract get image by key
 *   @param needCache , will cached
 *   @param name, will not cached
 */
+ (UIImage *)imageForKey:(id)key style:(NSString *)name;
+ (UIImage *)imageForKey:(id)key cache:(BOOL)needCache;
+ (UIImage *)imageForKey:(id)key; // default cached
+ (NSString *)imagePathForKey:(NSString *)key; // default cached

// 缩放图片
+ (UIImage *)scaleImage:(UIImage *)image scaleToSize:(CGSize)size;

//中间拉伸自动宽高
+ (UIImage*)middleStretchableImageWithKey:(NSString*)key ;
//中间拉伸图片,不支持换肤
+ (UIImage *)middleStretchableImageWithOutSupportSkin:(NSString *)key;

+ (UIImage *) createRoundedRectImage:(UIImage*)image size:(CGSize)size cornerRadius:(CGFloat)radius;

///宽高取小缩放，取大居中截取
+ (UIImage *)suitableScaleImage:(UIImage *)image scaleToSize:(CGSize)size;
//等比缩放到多少倍
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;
//等比例缩放
+(UIImage*)scaleToSize:(UIImage*)image size:(CGSize)size;
// zhengzheng
//等比缩放
+ (UIImage *) scaleImageForImage:(UIImage *)image toScale:(float)scaleSize;
- (UIImage *)fixOrientation;

//截取部分图像(区分高分屏或者低分屏)
/* ++++++++++++++++++++++++++++++++++++++
 *
 * zhengzheng

 @param img 需要被截取的图片
 @param scale  倍率（低分屏1.0 高分屏2.0）
 @param rect 截取的范围
 @return 返回截取后的图片
 */
+ (UIImage*)getSubImage:(UIImage *)img scale:(CGFloat)scale rect:(CGRect)rect;

@end
