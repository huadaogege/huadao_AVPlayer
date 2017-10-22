//
//  HDStrategyController.m
//  HDAVPlayer
//
//  Created by 崔玉冠 on 2017/10/22.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "HDStrategyController.h"
#import "NumberInputValidator.h"
#import "AlphaInputValidator.h"

@interface HDStrategyController ()

@end

@implementation HDStrategyController

- (void)viewDidLoad {
    [super viewDidLoad];
    HDInputValidator *numberValidator = [[NumberInputValidator alloc] init];
    HDInputValidator *alphaValidator = [[AlphaInputValidator alloc] init];
    //策略在此处配置
    _numberTF.inputValidator = numberValidator;
    _numberTF.delegate = self;
    _alphaTF.inputValidator = alphaValidator;
    _alphaTF.delegate = self;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([textField isKindOfClass:[HDUITextField class]]) {
        [(HDUITextField *)textField validate];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
