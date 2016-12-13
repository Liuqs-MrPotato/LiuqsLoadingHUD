//
//  ViewController.m
//  LiuqsLoadingHUD
//
//  Created by 刘全水 on 2016/11/24.
//  Copyright © 2016年 刘全水. All rights reserved.
//

#import "ViewController.h"
#import "LiuqsLoadingHUD.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *ImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    ImageView.image = [UIImage imageNamed:@"8.JPG"];
    [self.view addSubview:ImageView];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [LiuqsLoadingHUD show];
    [[LiuqsLoadingHUD shareHUD] setCancelAction:^{
        
    }];
}

@end
