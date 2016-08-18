//
//  UIButton+JWCountdown.m
//  JWCountdown
//
//  Created by zhangjiaweios on 16/8/14.
//  Copyright © 2016年 zhangjiaweios. All rights reserved.
//

#import "UIButton+JWCountdown.h"
#import <objc/runtime.h>

@interface UIButton ()

@property (nonatomic, strong) NSTimer *countdownTimer;
@property (nonatomic, copy) NSString *disabledTitle;

@end

@implementation UIButton (JWCountdown)

static char countdownTimerKey = 'k';
static char disabledTitleKey = 'k';

- (void)setCountdownTimer:(NSTimer *)countdownTimer {
    if (countdownTimer) {
        self.enabled = NO;
    } else {
        self.enabled = YES;
        [self setTitle:self.disabledTitle forState:UIControlStateDisabled];
        self.disabledTitle = nil;
    }
    
    objc_setAssociatedObject(self, &countdownTimerKey, countdownTimer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimer *)countdownTimer {
    return objc_getAssociatedObject(self, &countdownTimerKey);
}

- (void)setDisabledTitle:(NSString *)disabledTitle {
    objc_setAssociatedObject(self, &disabledTitleKey, disabledTitle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)disabledTitle {
    return objc_getAssociatedObject(self, &disabledTitleKey);
}

- (void)countdownBegin {
    [self countdownBeginWithTimeInterval:1];
}

- (void)countdownBeginWithTimeInterval:(NSTimeInterval)timeInterval {
    if (!self.countdownTimer) {
        self.countdownTimer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(countdown) userInfo:nil repeats:YES];
        [self.countdownTimer fire];
    }
}

- (void)countdownEnd {
    if (self.countdownTimer) {
        [self.countdownTimer invalidate];
        self.countdownTimer = nil;
    }
}

- (void)countdown {
    NSString *disabledTitle = [self titleForState:UIControlStateDisabled];
    NSScanner *countdownScanner = [NSScanner scannerWithString:disabledTitle];
    countdownScanner.charactersToBeSkipped = nil;
    
    NSCharacterSet *decimalDigitCharacterSet = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *anyCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@""];
    NSString *firstString = @"";
    NSDecimal middleDecimal;
    NSString *lastString = @"";
    
    [countdownScanner scanUpToCharactersFromSet:decimalDigitCharacterSet intoString:&firstString];
    [countdownScanner scanDecimal:&middleDecimal];
    [countdownScanner scanUpToCharactersFromSet:anyCharacterSet intoString:&lastString];
    
    NSDecimalNumber *middleDecimalNumber = [NSDecimalNumber decimalNumberWithDecimal:middleDecimal];
    NSDecimalNumber *timeIntervalDecimalNumber = [NSDecimalNumber decimalNumberWithString:@(self.countdownTimer.timeInterval).stringValue];
    
    if ([middleDecimalNumber compare:timeIntervalDecimalNumber] == NSOrderedDescending) {
        if (!self.disabledTitle) {
            self.disabledTitle = disabledTitle;
            disabledTitle = [NSString stringWithFormat:@"%@%@%@", firstString, middleDecimalNumber.stringValue, lastString];
        } else {
            NSDecimalNumber *differenceDecimalNumber = [middleDecimalNumber decimalNumberBySubtracting:timeIntervalDecimalNumber];
            disabledTitle = [NSString stringWithFormat:@"%@%@%@", firstString, differenceDecimalNumber.stringValue, lastString];
        }
        
        [self setTitle:disabledTitle forState:UIControlStateDisabled];
    } else {
        [self countdownEnd];
    }
}

@end
