//
//  LiuqsCircleLoader.h
//  LiuqsLoadingHUD
//
//  Created by 刘全水 on 2016/11/24.
//  Copyright © 2016年 刘全水. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiuqsCircleLoader : UIView

@property(nonatomic, retain) UIColor *progressTintColor;

@property(nonatomic, retain) UIColor *trackTintColor;

@property(nonatomic, assign) float lineWidth;

@property(nonatomic, strong) UIImage *centerImage;

@property(nonatomic, assign) float progressValue;

@property(nonatomic, strong) NSString *promptTitle;

@property(nonatomic, assign) BOOL animationing;

- (void)hide;

- (void)start;

@end
