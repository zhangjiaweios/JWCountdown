//
//  JWCountdownViewController.m
//  JWCountdown
//
//  Created by zhangjiaweios on 16/8/17.
//  Copyright © 2016年 zhangjiaweios. All rights reserved.
//

#import "JWCountdownViewController.h"
#import "UIButton+JWCountdown.h"

@interface JWCountdownViewController ()

@property (nonatomic, strong) UIButton *countdownBeginButton;
@property (nonatomic, strong) UIButton *countdownEndButton;

@end

@implementation JWCountdownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.countdownBeginButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 50, 200, 40)];
    [self.countdownBeginButton setTitle:@"countdownBegin" forState:UIControlStateNormal];
    [self.countdownBeginButton addTarget:self action:@selector(countdownBeginButtonTouch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.countdownBeginButton];
    
    self.countdownEndButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 100, 200, 40)];
    [self.countdownEndButton setTitle:@"countdownEnd" forState:UIControlStateNormal];
    [self.countdownEndButton addTarget:self action:@selector(countdownEndButtonTouch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.countdownEndButton];
    
    
    // Just set a number
    [self.countdownBeginButton setTitle:@"any1e1any10any" forState:UIControlStateDisabled];
}

- (void)countdownBeginButtonTouch {
    [self.countdownBeginButton countdownBeginWithTimeInterval:0.01];
}

- (void)countdownEndButtonTouch {
    [self.countdownBeginButton countdownEnd];
}

@end
