//
//  UIImage+PKImage.m
//  PKResManager
//
//  Created by zhongsheng on 12-11-27.
//
//

#import "UIImage+PKImage.h"
#import "PKResManagerKit.h"

static void AddRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth,
								 float ovalHeight)
{
    float fw, fh;
    if (ovalWidth == 0 || ovalHeight == 0) {
		CGContextAddRect(context, rect);
		return;
    }

    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth(rect) / ovalWidth;
    fh = CGRectGetHeight(rect) / ovalHeight;

    CGContextMoveToPoint(context, fw, fh/2);  // Start at lower right corner
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);  // Top right corner
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // Top left corner
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // Lower left corner
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // Back to lower right

    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

@implementation UIImage (PKImage)

+ (UIImage *)imageForKey:(id)key
{
    return [UIImage imageForKey:key cache:YES];
}

+ (UIImage *)imageForKey:(id)key cache:(BOOL)needCache
{
    if (key == nil) {
        return nil;
    }
    // 去除扩展名    
    if ([key hasSuffix:@".png"] || [key hasSuffix:@".jpg"]) {
        key = [key substringToIndex:((NSString*)key).length-4];
    }
    
    UIImage *image = ([PKResManager getInstance].resImageCache)[key];
    if (image) {
        // 从缓存中取到图片
        return image;
    }
    
    // 未从缓存中取到图片，从当前皮肤包中读取图片文件
    image = [UIImage imageForKey:key style:[PKResManager getInstance].styleId];
    
    // 当前皮肤包种文件读取失败，从 Common 皮肤包中读取图片文件
    if (image == nil) {
        image = [UIImage imageForKey:key inBundle:[PKResManager getInstance].commonStyleBundle];
    }
    
    // 读取图片成功，并且图片需要缓存，将图片缓存
    if (image != nil && needCache)
    {
        ([PKResManager getInstance].resImageCache)[key] = image;
    }

    
    return image;
}

+ (UIImage *)imageForKey:(id)key style:(NSString *)name
{
    if (key == nil)
    {
        //DLog(@" imageForKey:style: key = nil");
        return nil;
    }
    // 去除扩展名
    if ([key hasSuffix:@".png"] || [key hasSuffix:@".jpg"])
    {
        key = [key substringToIndex:((NSString*)key).length-4];
    }
    
    UIImage *image = nil;
    NSBundle *styleBundle = nil;
    // 不是当前style情况
    if (![name isEqualToString:[PKResManager getInstance].styleId])
    {
        styleBundle = [[PKResManager getInstance] bundleByStyleName:name];
    }
    else
    {
        styleBundle = [PKResManager getInstance].styleBundle;
    }
    
    image = [UIImage imageForKey:key inBundle:styleBundle];
    
    // mainBundle情况
    if (image == nil)
    {
        //DLog(@" will get default style => %@",key);
        styleBundle = [NSBundle mainBundle];
        image = [UIImage imageForKey:key inBundle:styleBundle];
    }

    return image;
}

// 支持png和jpg，可扩展
+ (UIImage *)imageForKey:(id)key inBundle:(NSBundle *)bundle
{
    NSString *imagePath = [bundle pathForResource:key ofType:@"png"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:imagePath]) {
        imagePath = [bundle pathForResource:key ofType:@"jpg"];
    }
    return [UIImage imageWithContentsOfFile:imagePath];
}

// 返回图片路径
+ (NSString *)imagePathForKey:(NSString *)key
{
    if (!key) {
        return nil;
    }

    for (NSString *suffix in [UIImage imageTypes]) {
        if ([key hasSuffix:suffix]) {
            key = [key substringToIndex:key.length - suffix.length];
            break;
        }
    }
    
    NSString *imagePath = [UIImage imagePathForKey:key inBundle:[PKResManager getInstance].styleBundle];
    if (!imagePath) {
        imagePath = [UIImage imagePathForKey:key inBundle:[PKResManager getInstance].commonStyleBundle];

        NSAssert1(imagePath, @"imagePath not exist !!! [image] ==> %@", key);
    }

    return imagePath;
}

+ (NSString *)imagePathForKey:(id)key inBundle:(NSBundle *)bundle
{
    NSString *imagePath = nil;
    for (NSString *suffix in [UIImage imageTypes]) {
        imagePath = [bundle pathForResource:key ofType:[suffix substringFromIndex:1]];
        if (imagePath) {
            break;
        }
    }
    return imagePath;
}

+ (NSArray *)imageTypes
{
    static NSMutableArray *typesArray = nil;

    if (!typesArray) {
        typesArray = [[NSMutableArray alloc]init];
        [typesArray addObject:@".png"];
        [typesArray addObject:@".jpg"];
        [typesArray addObject:@".gif"];
    }
    return typesArray;
}

+ (UIImage *)scaleImage:(UIImage *)image scaleToSize:(CGSize)size {
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    //    UIGraphicsBeginImageContext(size);
    UIGraphicsBeginImageContextWithOptions(size,NO, 0.0f);

    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];

    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();

    // 使当前的context出堆栈
    UIGraphicsEndImageContext();

    // 返回新的改变大小后的图片
    return scaledImage;
}

//截取部分图像(区分高分屏或者低分屏)
+ (UIImage*)getSubImage:(UIImage *)img scale:(CGFloat)scale rect:(CGRect)rect
{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(img.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    // 此处有可能生成的图片比需要生成的图片大，故作以下判断  zhengzheng
    if(!CGSizeEqualToSize(smallBounds.size, rect.size))
    {
        CGImageRelease(subImageRef);
        subImageRef = nil;
        int wOffset = smallBounds.size.width - rect.size.width;
        int hOffset = smallBounds.size.height - rect.size.height;
        rect.size.width = rect.size.width - wOffset;
        rect.size.height = rect.size.height - hOffset;
        subImageRef = CGImageCreateWithImageInRect(img.CGImage, rect);
        smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    }
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    //    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIImage *smallImage = [UIImage imageWithCGImage:subImageRef scale:scale orientation:UIImageOrientationUp];
    UIGraphicsEndImageContext();

    CGImageRelease(subImageRef);
    return smallImage;
}

+ (UIImage*)middleStretchableImageWithKey:(NSString*)key {
    UIImage *image = [UIImage imageForKey:key];
    return [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
}

//中间拉伸图片,不支持换肤
+ (UIImage *)middleStretchableImageWithOutSupportSkin:(NSString *)key {
    UIImage *image = [UIImage imageNamed:key];
    return [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
}

/*create round rect UIImage with the specific size*/
+ (UIImage *) createRoundedRectImage:(UIImage*)image size:(CGSize)size cornerRadius:(CGFloat)radius
{
    // the size of CGContextRef
    int w = size.width;
    int h = size.height;

    UIImage *img = image;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    CGRect rect = CGRectMake(0, 0, w, h);

    CGContextBeginPath(context);
    AddRoundedRectToPath(context, rect, radius, radius);
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);

    UIImage *imageMask = [UIImage imageWithCGImage:imageMasked];
    CGImageRelease(imageMasked);
    return imageMask;

}
//等比缩放
+ (UIImage *) scaleImage:(UIImage *)image toScale:(float)scaleSize {
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //    DDLogInfo(@"syp===scaledImage===size==%f,%f",scaledImage.size.width,scaledImage.size.height);
    return scaledImage;
}

// zhengzheng
//等比缩放
+ (UIImage *) scaleImageForImage:(UIImage *)image toScale:(float)scaleSize {
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //    DDLogInfo(@"syp===scaledImage===size==%f,%f",scaledImage.size.width,scaledImage.size.height);
    return scaledImage;
}

//宽高取小缩放，取大居中截取
+ (UIImage *)suitableScaleImage:(UIImage *)image scaleToSize:(CGSize)size
{
    CGFloat screenScale = [UIScreen mainScreen].scale;
    CGSize imageSize = image.size;
    CGFloat realScale = 0.0f;
    UIImage *tmpImage = nil;
    CGFloat imageSizeMax = MAX(imageSize.width, imageSize.height);
    CGFloat imageSizeMin = MIN(imageSize.width, imageSize.height);

    //短边大于定长
    if ( imageSizeMin >= size.width/* * screenScale*/ ) {
        if ( imageSize.width <= imageSize.height ) {
            realScale = size.width / imageSize.width * screenScale;
            UIImage *currentImage = [UIImage scaleImage:image toScale:realScale];
            tmpImage = [UIImage getSubImage:currentImage scale:screenScale rect:CGRectMake(0, ( currentImage.size.height - size.height * screenScale ) / 2.0f, size.width * screenScale, size.height *screenScale)];
        }
        else
        {
            realScale = size.height / imageSize.height * screenScale;
            UIImage *currentImage = [UIImage scaleImage:image toScale:realScale];
            tmpImage = [UIImage getSubImage:currentImage scale:screenScale rect:CGRectMake( ( currentImage.size.width - size.width * screenScale ) / 2.0f, 0, size.width * screenScale, size.height * screenScale)];
        }
    }
    else
    {   //短边小于定长，长边大于定长
        if ( imageSizeMax > size.width/* * screenScale*/ ) {
            if ( imageSize.width < imageSize.height ) {
                tmpImage = [UIImage getSubImage:image scale:screenScale rect:CGRectMake(0, ( imageSize.height - size.height * screenScale ) / 2.0f, size.width * screenScale, size.height *screenScale)];
            }
            else
            {
                tmpImage = [UIImage getSubImage:image scale:screenScale rect:CGRectMake( ( imageSize.width - size.width * screenScale ) / 2.0f, 0, size.width * screenScale, size.height * screenScale)];
            }
        }
        else //长短边都小于定长
        {
            tmpImage = image;
        }
    }

    return tmpImage;
}

//等比例缩放
+(UIImage*)scaleToSize:(UIImage*)image size:(CGSize)size
{
    CGFloat width = CGImageGetWidth(image.CGImage);
    CGFloat height = CGImageGetHeight(image.CGImage);

    float verticalRadio = size.height*1.0/height;
    float horizontalRadio = size.width*1.0/width;

    float radio = 1;
    if(verticalRadio>1 && horizontalRadio>1)
    {
        radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio;
    }
    else
    {
        radio = verticalRadio < horizontalRadio ? verticalRadio : horizontalRadio;
    }

    width = width*radio;
    height = height*radio;

    int xPos = (size.width - width)/2;
    int yPos = (size.height-height)/2;

    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);

    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(xPos, yPos, width, height)];

    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();

    // 使当前的context出堆栈
    UIGraphicsEndImageContext();

    // 返回新的改变大小后的图片
    return scaledImage;
}

- (UIImage *)fixOrientation {

    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;

    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;

    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;

        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;

        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }

    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;

        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }

    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;

        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }

    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

@end
