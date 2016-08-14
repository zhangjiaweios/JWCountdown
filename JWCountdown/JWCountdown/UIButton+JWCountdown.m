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
@property (nonatomic, copy) NSString *titleForDisabled;

@end

@implementation UIButton (JWCountdown)

static const char countdownTimerKey = 'k';
static const char titleForDisabledKey = 'k';

- (void)setCountdownTimer:(NSTimer *)countdownTimer {
    if (countdownTimer) {
        self.enabled = NO;
    } else {
        self.enabled = YES;
        [self setTitle:self.titleForDisabled forState:UIControlStateDisabled];
        self.titleForDisabled = nil;
    }
    
    objc_setAssociatedObject(self, &countdownTimerKey, countdownTimer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimer *)countdownTimer {
    return objc_getAssociatedObject(self, &countdownTimerKey);
}

- (void)setTitleForDisabled:(NSString *)titleForDisabled {
    objc_setAssociatedObject(self, &titleForDisabledKey, titleForDisabled, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)titleForDisabled {
    return objc_getAssociatedObject(self, &titleForDisabledKey);
}

- (void)jwCountdownBeginWithTimeInterval:(NSTimeInterval)timeInterval {
    if (!self.countdownTimer) {
        self.countdownTimer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(jwCountdown) userInfo:nil repeats:YES];
        [self.countdownTimer fire];
    }
}

- (void)jwCountdownEnd {
    if (self.countdownTimer) {
        [self.countdownTimer invalidate];
        self.countdownTimer = nil;
    }
}

- (void)jwCountdown {
    NSString *titleForDisabled = [self titleForState:UIControlStateDisabled];
    NSScanner *countdownScanner = [NSScanner scannerWithString:titleForDisabled];
    countdownScanner.charactersToBeSkipped = nil;
    
    NSCharacterSet *decimalDigitCharacterSet = [NSCharacterSet decimalDigitCharacterSet];
    NSString *firstString = @"";
    NSDecimal middleDecimal;
    NSString *lastString = @"";
    
    [countdownScanner scanUpToCharactersFromSet:decimalDigitCharacterSet intoString:&firstString];
    if (![countdownScanner scanDecimal:&middleDecimal]) {
        [self jwCountdownEnd];
        return;
    }
    [countdownScanner scanUpToCharactersFromSet:decimalDigitCharacterSet intoString:&lastString];
    
    NSDecimalNumber *middleDecimalNumber = [NSDecimalNumber decimalNumberWithDecimal:middleDecimal];
    NSDecimalNumber *timeIntervalDecimalNumber = [NSDecimalNumber decimalNumberWithString:@(self.countdownTimer.timeInterval).stringValue];
    
    if ([middleDecimalNumber compare:timeIntervalDecimalNumber] == NSOrderedDescending) {
        if (!self.titleForDisabled) {
            self.titleForDisabled = titleForDisabled;
            titleForDisabled = [NSString stringWithFormat:@"%@%@%@", firstString, middleDecimalNumber.stringValue, lastString];
        } else {
            NSDecimalNumber *differenceDecimalNumber = [middleDecimalNumber decimalNumberBySubtracting:timeIntervalDecimalNumber];
            titleForDisabled = [NSString stringWithFormat:@"%@%@%@", firstString, differenceDecimalNumber.stringValue, lastString];
        }
        
        [self setTitle:titleForDisabled forState:UIControlStateDisabled];
    } else {
        [self jwCountdownEnd];
    }
}

@end
