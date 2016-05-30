//
//  ViewController.m
//  HeaderView
//
//  Created by PZDF on 16/5/27.
//  Copyright © 2016年 WUDAN. All rights reserved.
//

#import "ViewController.h"
#import "WDImageVIew.h"
#import "WDHeaderView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    float width = 60;
    //直接用headerView创建,只能创建单个
    WDImageVIew *imageView = [[WDImageVIew alloc] initWithDirection:BOTTOM];
    imageView.frame = CGRectMake(width, width, width, width);
    imageView.image = [UIImage imageNamed:@"4.png"];
    [self.view addSubview:imageView];
    
    //用封装好的WDHeaderView来创建
    WDHeaderView *headerView5 = [[WDHeaderView alloc] initWithFrame:CGRectMake(10, width*2, width, width) headerArray:@[@"1.png", @"2.png", @"3.png", @"4.png", @"5.png"]];
    [self.view addSubview:headerView5];
    
    WDHeaderView *headerView4 = [[WDHeaderView alloc] initWithFrame:CGRectMake(50+width, width*3, width, width) headerArray:@[@"1.png", @"2.png", @"3.png", @"4.png"]];
    [self.view addSubview:headerView4];
    
    WDHeaderView *headerView3 = [[WDHeaderView alloc] initWithFrame:CGRectMake(10, width*3 + 50, width, width) headerArray:@[@"1.png", @"2.png", @"3.png"]];
    [self.view addSubview:headerView3];
    
    WDHeaderView *headerView2 = [[WDHeaderView alloc] initWithFrame:CGRectMake(50+width, width*4 + 50, width, width)];
    headerView2.headerArray = @[@"1.png", @"2.png"];
    [self.view addSubview:headerView2];
    
    WDHeaderView *headerView1 = [[WDHeaderView alloc] initWithFrame:CGRectMake(50+width*2, width, width, width)];
    headerView1.headerArray = @[@"1.png"];
    [self.view addSubview:headerView1];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
