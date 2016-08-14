//
//  ViewController.m
//  JWCountdown
//
//  Created by zhangjiaweios on 16/8/14.
//  Copyright © 2016年 zhangjiaweios. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+JWCountdown.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UIButton *countdownButton1;
@property (nonatomic, weak) IBOutlet UIButton *countdownButton2;
@property (nonatomic, weak) IBOutlet UIButton *countdownButton3;
@property (nonatomic, weak) IBOutlet UIButton *countdownButton4;
@property (nonatomic, weak) IBOutlet UIButton *countdownButton5;
@property (nonatomic, weak) IBOutlet UIButton *countdownButton6;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.countdownButton1 setTitle:@"10text" forState:UIControlStateDisabled];
    [self.countdownButton2 setTitle:@"text10.0text" forState:UIControlStateDisabled];
    [self.countdownButton3 setTitle:@"text1e1" forState:UIControlStateDisabled];
    [self.countdownButton4 setTitle:@"10.5" forState:UIControlStateDisabled];
    [self.countdownButton5 setTitle:@"text" forState:UIControlStateDisabled];
}

- (IBAction)countdownButton1Touch {
    NSLog(@"%s", __func__);
    [self.countdownButton1 jwCountdownBeginWithTimeInterval:3];
}

- (IBAction)countdownButton2Touch {
    NSLog(@"%s", __func__);
    [self.countdownButton2 jwCountdownBeginWithTimeInterval:1.5];
}

- (IBAction)countdownButton3Touch {
    NSLog(@"%s", __func__);
    [self.countdownButton3 jwCountdownBeginWithTimeInterval:1];
}

- (IBAction)countdownButton4Touch {
    NSLog(@"%s", __func__);
    [self.countdownButton4 jwCountdownBeginWithTimeInterval:0.1];
}

- (IBAction)countdownButton5Touch {
    NSLog(@"%s", __func__);
    [self.countdownButton5 jwCountdownBeginWithTimeInterval:0.01];
}

- (IBAction)countdownButton6Touch {
    NSLog(@"%s", __func__);
    [self.countdownButton1 jwCountdownEnd];
    [self.countdownButton2 jwCountdownEnd];
    [self.countdownButton3 jwCountdownEnd];
    [self.countdownButton4 jwCountdownEnd];
    [self.countdownButton5 jwCountdownEnd];
}

@end
