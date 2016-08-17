//
//  UIButton+JWCountdown.h
//  JWCountdown
//
//  Created by zhangjiaweios on 16/8/14.
//  Copyright © 2016年 zhangjiaweios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (JWCountdown)

- (void)countdownBegin; // timeInterval 1s
- (void)countdownBeginWithTimeInterval:(NSTimeInterval)timeInterval;
- (void)countdownEnd;

@end
