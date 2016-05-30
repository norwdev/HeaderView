//
//  WDHeaderView.m
//  HeaderView
//
//  Created by PZDF on 16/3/24.
//  Copyright © 2016年 WUDAN. All rights reserved.
//

#import "WDHeaderView.h"
#import "WDImageVIew.h"
@interface WDHeaderView()
@end

@implementation WDHeaderView

- (instancetype)initWithFrame:(CGRect)frame headerArray:(NSArray *)images
{
    self = [super initWithFrame:frame];
    if (self) {
        _headerArray = images;
    }
    return self;
}

- (void)setHeaderArray:(NSArray *)headerArray
{
    _headerArray = headerArray;
    [self setNeedsLayout];
}

- (void)updateSubViews{
    if (!_headerArray) {
        _headerArray = [[NSArray alloc] init];
    }
    float r = [self _getRadians];
    float selfWidth = CGRectGetWidth(self.frame);
    float padding = kPadding/2;
    switch (self.headerArray.count) {
        case 1:
        {
            [self _createImageView:NONE image:self.headerArray[0] center:CGPointMake(r, r)];
        }
            break;
        case 2:
        {
            [self _createImageView:NONE image:self.headerArray[0] center:CGPointMake(r+padding, r+padding)];
            [self _createImageView:LEFT_TOP_2 image:self.headerArray[1] center:CGPointMake(selfWidth-r-padding*2, selfWidth-r-padding*2)];
        }
            break;
        case 3:
        {
            float paddingy = (selfWidth - r*2 - r*2*0.82*(3/2))/2;
            [self _createImageView:LEFT_BOTTOM image:self.headerArray[0] center:CGPointMake(selfWidth/2, r+paddingy)];
            [self _createImageView:RIGHT image:self.headerArray[1] center:CGPointMake(r, selfWidth-r-paddingy)];
            [self _createImageView:LEFT_TOP_3 image:self.headerArray[2] center:CGPointMake(selfWidth-r, selfWidth-r-paddingy)];
        }
            break;
            case 4:
        {
            [self _createImageView:BOTTOM image:self.headerArray[0] center:CGPointMake(r+padding, r+padding)];
            [self _createImageView:LEFT image:self.headerArray[1] center:CGPointMake(selfWidth-r-padding, r+padding)];
            [self _createImageView:RIGHT image:self.headerArray[2] center:CGPointMake(r+padding, selfWidth-r-padding)];
            [self _createImageView:TOP image:self.headerArray[3] center:CGPointMake(selfWidth-r-padding, selfWidth-r-padding)];
        }
            break;
        case 5:
        {
            // 边距
            float s1 = -r*2 * 0.81;
            float x1 = 0;
            float y1 = s1;
            
            float x5 = (float) (s1 * cos(radians(19)));
            float y5 = (float) (s1 * sin(radians(18)));
            
            float x4 = (float) (s1 * cos(radians(54)));
            float y4 = (float) (-s1 * sin(radians(54)));
            
            float x3 = (float) (-s1 * cos(radians(54)));
            float y3 = (float) (-s1 * sin(radians(54)));
            
            float x2 = (float) (-s1 * cos(radians(19)));
            float y2 = (float) (s1 * sin(radians(18)));
            // 居中 Y轴偏移量
            float xx1 = selfWidth/2;
            // 居中 X轴偏移量
            float xxc1 = selfWidth/2;
            
            [self _createImageView:LEFT_BOTTOM_5 image:self.headerArray[0] center:CGPointMake(x1+xxc1, y1+xx1)];
            [self _createImageView:LEFT_TOP_5 image:self.headerArray[1] center:CGPointMake(x2+xxc1, y2+xx1)];
            [self _createImageView:RIGHT_TOP_5 image:self.headerArray[2] center:CGPointMake(x3+xxc1, y3+xx1)];
            [self _createImageView:RIGHT image:self.headerArray[3] center:CGPointMake(x4+xxc1, y4+xx1)];
            [self _createImageView:RIGHT_BOTTOM_5 image:self.headerArray[4] center:CGPointMake(x5+xxc1, y5+xx1)];
        }
            break;
        default:
            break;
    }
}

- (void )_createImageView:(NSInteger)direction
                image:(id)imageName
                 center:(CGPoint)center   //tag表示的是第几个imageView 从0开始
{
    WDImageVIew *imageView = [[WDImageVIew alloc] init];
    float r = [self _getRadians];
    [imageView wd_cornerRadiusWithDirection:direction];
    [imageView setHidden:NO];
    imageView.frame = CGRectMake(0, 0, r*2, r*2);
    imageView.center = CGPointMake(center.x, center.y);
    UIImage *image;
    if([imageName isKindOfClass:[UIImage class]]){
        image = imageName;
    }else if([imageName isKindOfClass:[NSString class]] && [imageName hasPrefix:@"http://"]){
        image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageName]]];
    }else if([imageName isKindOfClass:[NSString class]]){
        image = [UIImage imageNamed:imageName];
    }else if([imageName isKindOfClass:[NSURL class]]){
        image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageName]];
    }else{
        image = [UIImage imageNamed:kDefalutUserHeader];
    }
    [imageView setImage:image];
    [self addSubview:imageView];
}

//半径
- (float)_getRadians{
    float selfWidth = CGRectGetWidth(self.frame);
    float r = selfWidth/2;   //默认是一个圆
    if (self.headerArray.count == 2) {
        float c = selfWidth/sin(radians(45));   //斜线长
        r = (selfWidth + selfWidth - c)/2;
    }else if(self.headerArray.count == 5){
        r = selfWidth*0.4/2;
    }
    else if(self.headerArray.count > 2){
        r = selfWidth / 4;
    }
    return r;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateSubViews];
}


@end
