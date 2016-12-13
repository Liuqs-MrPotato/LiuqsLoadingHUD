//
//  LiuqsLoadingHUD.h
//  LiuqsLoadingHUD
//
//  Created by 刘全水 on 2016/11/17.
//  Copyright © 2016年 刘全水. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^dissmissBlock)(void);

@interface LiuqsLoadingHUD : UIView

//单例创建方法
+ (instancetype)shareHUD;
//出现方法
+ (void)show;
//消失方法
+ (void)dismissWithBlock:(dissmissBlock)dismiss;

@property(nonatomic, copy) void(^cancelAction)();

@end
