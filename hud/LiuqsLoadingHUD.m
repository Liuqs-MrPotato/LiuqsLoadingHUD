//
//  LiuqsLoadingHUD.m
//  LiuqsLoadingHUD
//
//  Created by 刘全水 on 2016/11/17.
//  Copyright © 2016年 刘全水. All rights reserved.
//

#import "LiuqsLoadingHUD.h"
#import "LiuqsCircleLoader.h"

#define ColorRGB(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]

#define screenBounds [UIScreen mainScreen].bounds

#define animationTime 0.3

@interface LiuqsLoadingHUD ()

@property(nonatomic, strong)UILabel *loadingLabel;

@property(nonatomic, strong)UIButton *cancelButton;

@property(nonatomic, strong)LiuqsCircleLoader *loadView;

@property(nonatomic, strong)UIView *hudView;

@property(nonatomic, strong)UIWindow *keyWindow;

@end

@implementation LiuqsLoadingHUD

#pragma mark ======== 懒加载 ======

- (UIWindow *)keyWindow {

    if (!_keyWindow) {
        _keyWindow = [UIApplication sharedApplication].keyWindow;
    }
    return _keyWindow;
}

- (UIView *)hudView {

    if (!_hudView) {
        _hudView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 400, 100)];
        _hudView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.9];
        _hudView.layer.cornerRadius = 4.0f;
        _hudView.layer.masksToBounds = YES;
        _hudView.userInteractionEnabled = YES;
    }
    return _hudView;
}

- (LiuqsCircleLoader *)loadView {

    if (!_loadView) {
        _loadView = [[LiuqsCircleLoader alloc]initWithFrame:CGRectMake(10, 6, 38, 38)];
        _loadView.trackTintColor = ColorRGB(210, 210, 210);
        _loadView.progressTintColor = ColorRGB(43, 174, 253);
        _loadView.lineWidth = 3.0;
        _loadView.progressValue = 0.1;
        _loadView.animationing = YES;
        _loadView.centerImage = [UIImage imageNamed:@"Icon-180"];
    }
    return _loadView;
}

- (UIButton *)cancelButton {

    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(self.hudView.frame.size.width - 50, (self.hudView.frame.size.height - 50) * 0.5, 50, 50)];
        [_cancelButton setImage:[UIImage imageNamed:@"icon_notice_shut.png"] forState:UIControlStateNormal];
        [_cancelButton setImageEdgeInsets:UIEdgeInsetsMake(16, 16, 16, 16)];
        [_cancelButton addTarget:self action:@selector(dismissAction) forControlEvents:UIControlEventTouchUpInside];
        _cancelButton.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _cancelButton;
}

- (UILabel *)loadingLabel {

    if (!_loadingLabel) {
        _loadingLabel = [[UILabel alloc]initWithFrame:CGRectMake(55, 5, self.hudView.frame.size.width - 100, self.hudView.frame.size.height - 10)];
        _loadingLabel.text = @"正在加载···";
        _loadingLabel.textAlignment = NSTextAlignmentCenter;
        _loadingLabel.font = [UIFont systemFontOfSize:19];
    }
    return _loadingLabel;
}

//约束frame
- (void)layoutSubviews {
    
    self.hudView.center      = self.keyWindow.center;
    self.loadingLabel.frame  = CGRectMake(55, 5, self.hudView.frame.size.width - 100, self.hudView.frame.size.height - 10);
    self.cancelButton.frame  = CGRectMake(self.hudView.frame.size.width - 50, (self.hudView.frame.size.height - 50) * 0.5, 50, 50);
    self.loadView.frame      = CGRectMake(10, (self.hudView.frame.size.height - 38) * 0.5, 38, 38);
}

#pragma mark ======== 构造方法 ========
//初始化
- (instancetype)init {

    if (self = [super init]) {
        
        [self configureSomeThing];
        [self configureSubviews];
        [self configureNotis];
    }
    return self;
}

#pragma mark ======== 自定义方法 ========
//配置通知
- (void)configureNotis {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(EnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
}

//回前台的方法
- (void)EnterForeground {

    [self.loadView start];
}

//配置视图
- (void)configureSubviews {

    [self.hudView addSubview:self.loadingLabel];
    [self.hudView addSubview:self.cancelButton];
    [self.hudView addSubview:self.loadView];
    [self addSubview:self.hudView];
}

//配置一些信息
- (void)configureSomeThing {

    self.frame = CGRectMake(0, 0, screenBounds.size.width, screenBounds.size.height);
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    self.userInteractionEnabled = YES;
}

//取消按钮事件
- (void)dismissAction {

    if (self.cancelAction) {
        self.cancelAction();
    }
    [LiuqsLoadingHUD dismissWithBlock:^{
    }];
}

#pragma mark ======== 类方法 ========

//单例创建方法
+ (instancetype)shareHUD {
    
    static LiuqsLoadingHUD *aleartView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        aleartView = [[LiuqsLoadingHUD alloc]init];
    });
    return aleartView;
}

//展示方法
+ (void)show {
    
    LiuqsLoadingHUD *aleart    = [LiuqsLoadingHUD shareHUD];
    aleart.hudView.center      = aleart.keyWindow.center;
    aleart.hudView.alpha = 0;
    [aleart.keyWindow addSubview:aleart];
    aleart.loadingLabel.alpha = 0;
    aleart.cancelButton.alpha = 0;
    aleart.alpha = 0;
    [UIView animateWithDuration:animationTime animations:^{
        aleart.hudView.alpha = 1.0;
        aleart.alpha = 1.0;
        aleart.hudView.frame = CGRectMake(0, 0, 200, 50);
        aleart.hudView.center = aleart.keyWindow.center;
        [aleart setNeedsLayout];
        [aleart layoutIfNeeded];
        aleart.loadingLabel.alpha = 1.0;
        aleart.cancelButton.alpha = 1.0;
    } completion:^(BOOL finished) {
        [aleart.loadView start];
    
    }];
}

//消失方法
+ (void)dismissWithBlock:(dissmissBlock)dismiss {
    
    LiuqsLoadingHUD *aleart    = [LiuqsLoadingHUD shareHUD];
    aleart.loadingLabel.alpha  = 0.0;
    aleart.cancelButton.alpha  = 0.0;
    [UIView animateWithDuration:animationTime animations:^{
        
        aleart.hudView.frame  = CGRectMake(0, 0, 400, 100);
        aleart.hudView.alpha  = 0;
        aleart.alpha = 0;
        aleart.hudView.center = aleart.keyWindow.center;
        [aleart setNeedsLayout];
        [aleart layoutIfNeeded];
    } completion:^(BOOL finished) {
        [aleart removeFromSuperview];
        dismiss();
    }];
}

@end
