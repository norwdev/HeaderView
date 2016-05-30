//
//  WDImageVIew.m
//  HeaderView
//
//  Created by PZDF on 16/3/21.
//  Copyright © 2016年 WUDAN. All rights reserved.
//

#import <UIKit/UIKit.h>
enum DirectionType{
    TOP = 0,       //上开口
    BOTTOM,        //下开口
    LEFT,          //左开口
    RIGHT,         //右开口
    LEFT_TOP_2,    //只有两个头像时的左上角开口
    LEFT_TOP_3,    //只有三个头像时的左上角开口
    LEFT_BOTTOM,   //左下角开口
    LEFT_BOTTOM_5,
    RIGHT_BOTTOM_5,
    RIGHT_TOP_5,
    LEFT_TOP_5,
    NONE,          //没有切角，直接是一个圆
};

static inline float radians(double degrees) { return degrees * M_PI / 180; }

@interface WDImageVIew : UIImageView

//director  ：开口的方向   angle:开口的度数 开口的度数默认是60度
- (instancetype)initWithDirection:(NSInteger)direction;
- (instancetype)initWithDirection:(NSInteger)direction angle:(float)angle;

- (void)wd_cornerRadiusWithDirection:(NSInteger)direction;
- (void)wd_cornerRadiusWithDirection:(NSInteger)direction angle:(float)angle;

//更新图片的开口方向
- (void)updateDirection:(NSInteger)direction image:(UIImage *)image;
@end
