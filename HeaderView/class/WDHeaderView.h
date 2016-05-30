//
//  WDHeaderView.h
//  HeaderView
//
//  Created by PZDF on 16/3/24.
//  Copyright © 2016年 WUDAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kPadding 1.2   //越大距离越近
#define kDefalutUserHeader @"1.png"
@interface WDHeaderView : UIView
//有几个头像就headerArray就传多少个imagename
@property (nonatomic, strong) NSArray *headerArray;
- (instancetype)initWithFrame:(CGRect)frame headerArray:(NSArray *)headerArray;
@end
