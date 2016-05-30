//
//  WDImageVIew.m
//  HeaderView
//
//  Created by PZDF on 16/3/21.
//  Copyright © 2016年 WUDAN. All rights reserved.
//

#import "WDImageVIew.h"
#import <objc/runtime.h>

//原点离圆弧最低点的距离
#define radianDeepLenght(angle, radiusLen) (radiusLen * sin(radians(90 - angle)) - radiusLen * sin(radians(angle)) * tan(radians(angle)))

const char kProcessedImage;

@interface WDImageVIew()
@property (nonatomic, assign) BOOL hadAddObserver;
@property (nonatomic, assign) NSInteger direction;
@property (nonatomic, assign) float halfAngle;
@end

@implementation WDImageVIew

- (instancetype)initWithDirection:(NSInteger)direction angle:(float)angle{
    if (self == [super init]) {
        [self wd_cornerRadiusWithDirection:direction angle:angle];
    }
    return self;
}

- (instancetype)initWithDirection:(NSInteger)direction{
    if (self == [super init]) {
        [self wd_cornerRadiusWithDirection:direction angle:60];
    }
    return self;
}

- (void)wd_cornerRadiusWithDirection:(NSInteger)direction angle:(float)angle{
    self.direction = direction;
    self.halfAngle = angle/2;
    if (!_hadAddObserver) {
        [self addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
        self.hadAddObserver = YES;
    }
}

- (void)wd_cornerRadiusWithDirection:(NSInteger)direction{
    [self wd_cornerRadiusWithDirection:direction angle:60];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if(self.image != nil){
        [self wd_cornerRadiusWithImage:self.image director:self.direction angle:self.halfAngle];
    }
}

- (void)wd_cornerRadiusWithImage:(UIImage *)image director:(NSInteger)direction angle:(float)angle
{
    CGSize size = self.bounds.size;
    CGFloat scale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    if (nil == UIGraphicsGetCurrentContext()) {
        return;
    }
    [self drawCircle];
    [image drawInRect:self.bounds];
    UIImage *processedImage = UIGraphicsGetImageFromCurrentImageContext();
    objc_setAssociatedObject(processedImage, &kProcessedImage, @(1), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.image = processedImage;
    UIGraphicsEndImageContext();
}

//根据开口方向绘制
- (void)drawCircle{
    CGFloat startAngle = 0;
    CGFloat endAngle = 0;
    CGFloat x1 = 0;
    CGFloat x2 =0;
    CGFloat y1 = 0;
    CGFloat y2 = 0;
    float halfAngle = self.halfAngle;
    float centerWidth = self.bounds.size.width/2;
    float centerHeight = self.bounds.size.width/2;
    float radiusLen = self.bounds.size.width/2;  //半径
    switch (self.direction) {
        case TOP:
        {
            startAngle = radians(-(90 + halfAngle));
            endAngle = radians(-90 + halfAngle);
            x1 = centerWidth;
            y1 = centerHeight - radianDeepLenght(halfAngle, radiusLen);
            x2 = centerWidth - radiusLen * sin(radians(halfAngle));
            y2 = centerHeight - radiusLen * sin(radians(90 - halfAngle));
        }
            break;
        case BOTTOM:
        {
            startAngle = radians(90-halfAngle);
            endAngle = radians(90+halfAngle);
            x1 = centerWidth;
            y1 = centerHeight + radianDeepLenght(halfAngle, radiusLen);
            x2 = centerWidth + radiusLen * sin(radians(halfAngle));
            y2 = centerHeight + radiusLen * sin(radians(90 - halfAngle));
        }
            break;
        case LEFT:
        {
            startAngle = radians(180-halfAngle);
            endAngle = radians(-180+halfAngle);
            x1 = centerWidth - radianDeepLenght(halfAngle, radiusLen);
            y1 = centerHeight;
            x2 = centerWidth - radiusLen * sin(radians(90 - halfAngle));
            y2 = centerHeight + radiusLen * sin(radians(halfAngle));
        }
            break;
        case RIGHT:
        {
            startAngle = radians(-halfAngle);
            endAngle = radians(halfAngle);
            x1 = centerWidth + radianDeepLenght(halfAngle, radiusLen);
            y1 = centerHeight;
            x2 = centerWidth + radiusLen * sin(radians(90 - halfAngle));
            y2 = centerHeight - radiusLen * sin(radians(halfAngle));
        }
            break;
        case LEFT_TOP_2:
        {
            startAngle = radians(-(180-45+halfAngle));
            endAngle = radians(-(180-45-halfAngle));
            x1 = centerWidth - radianDeepLenght(halfAngle, radiusLen)*sin(radians(45));
            y1 = centerHeight - radianDeepLenght(halfAngle, radiusLen)*sin(radians(45));;
            x2 = centerWidth - radiusLen*sin(radians(45+halfAngle));
            y2 = centerHeight - radiusLen*sin(radians(45-halfAngle));
        }
            break;
        case LEFT_BOTTOM:
        {
            startAngle = radians(90);
            endAngle = radians(90+halfAngle*2);
            x1 = centerWidth - radianDeepLenght(halfAngle, radiusLen)*sin(radians(halfAngle));
            y1 = centerHeight + radianDeepLenght(halfAngle, radiusLen)/sin(radians(90-halfAngle));
            y2 = centerHeight*2;
            x2 = centerWidth;
        }
            break;
        case LEFT_TOP_3:
        {
            startAngle = radians(-(90+halfAngle*2));
            endAngle = radians(-(90));
            y1 = centerHeight - radianDeepLenght(halfAngle, radiusLen)/sin(radians(90-halfAngle));
            x1 = centerWidth - radianDeepLenght(halfAngle, radiusLen)*sin(radians(halfAngle));
            x2 = centerWidth - centerWidth*sin(radians(30*2));
            y2 = centerHeight - centerWidth*sin(radians(90-30*2));
        }
            break;
        case RIGHT_TOP_5:
        {
            startAngle = radians(-72-halfAngle);
            endAngle = radians(-72+halfAngle);
            
            x1 = centerWidth + radianDeepLenght(halfAngle, radiusLen)*sin(radians(90-72));
            y1 = centerHeight - radianDeepLenght(halfAngle, radiusLen)*sin(radians(72));
            y2 = centerHeight - radiusLen * sin(radians(90-(90-72-halfAngle)));
            x2 = centerWidth + radiusLen * sin(radians(90-72-halfAngle));
        }
            break;
        case LEFT_TOP_5:
        {
            startAngle = radians(-144-halfAngle);
            endAngle = radians(-144 + halfAngle);
            x1 = centerWidth - radianDeepLenght(halfAngle, radiusLen)*sin(radians(144-90));
            y1 = centerHeight - radianDeepLenght(halfAngle, radiusLen)*sin(radians(90-(144-90)));
            x2 = centerHeight - radiusLen * sin(radians(90-(180-144-halfAngle)));
            y2 = centerWidth - radiusLen * sin(radians(180-144-halfAngle));
        }
            break;
        case LEFT_BOTTOM_5:
        {
            startAngle = radians(144-halfAngle);
            endAngle = radians(144 + halfAngle);
            x1 = centerWidth - radianDeepLenght(halfAngle, radiusLen)*sin(radians(144-90));
            y1 = centerHeight + radianDeepLenght(halfAngle, radiusLen)*sin(radians(90-(144-90)));
            y2 = centerHeight + radiusLen * sin(radians(90-(144-halfAngle-90)));
            x2 = centerWidth - radiusLen * sin(radians(144-halfAngle-90));
        }
            break;
        case RIGHT_BOTTOM_5:
        {
            startAngle = radians(72-halfAngle);
            endAngle = radians(72+halfAngle);
            x1 = centerWidth + radianDeepLenght(halfAngle, radiusLen)*sin(radians(90-72));
            y1 = centerHeight + radianDeepLenght(halfAngle, radiusLen)*sin(radians(72));
            y2 = centerHeight + radiusLen * sin(radians(72-halfAngle));
            x2 = centerWidth + radiusLen * sin(radians(90-72+halfAngle));
        }
            break;
        case NONE:
        {
            startAngle = radians(90-halfAngle);
            endAngle = radians(-270-halfAngle);
        }
            break;
        default:
            break;
    }
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 0, 0, 1, 1);
    CGContextAddArc(context, centerWidth, centerHeight, radiusLen, startAngle, endAngle, 1);
    CGContextAddArcToPoint(context,
                           x1,
                           y1,
                           x2,
                           y2,
                           radiusLen);
    CGContextClosePath(context);
    CGContextClip(context);
}

- (void)updateDirection:(NSInteger)direction image:(UIImage *)image{
    if (self.direction == direction) return;
    self.direction = direction;
    if (self.image != nil) {
        [self wd_cornerRadiusWithImage:image director:self.direction angle:self.halfAngle];
    }
}

- (void)dealloc {
    if (_hadAddObserver) {
        [self removeObserver:self forKeyPath:@"image"];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"image"]) {
        UIImage *newImage = change[NSKeyValueChangeNewKey];
        if ([newImage isMemberOfClass:[NSNull class]]) {
            return;
        } else if ([objc_getAssociatedObject(newImage, &kProcessedImage) intValue] == 1) {
            return;
        }
        if (self.image != nil) {
            [self wd_cornerRadiusWithImage:newImage director:self.direction angle:self.halfAngle];
        }
    }
}

@end
