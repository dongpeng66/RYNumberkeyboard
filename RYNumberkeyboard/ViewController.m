//
//  ViewController.m
//  RYNumberkeyboard
//
//  Created by dp on 17/5/23.
//  Copyright © 2017年 dp. All rights reserved.
//

#import "ViewController.h"
#import "RYNumberKeyboard.h"
@interface ViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *textField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _textField=[[UITextField alloc]initWithFrame:CGRectMake(100, 100, 200, 30)];
    _textField.delegate=self;
    _textField.layer.borderWidth=1;
    _textField.layer.borderColor=[UIColor grayColor].CGColor;
    [self.view addSubview:_textField];
    
    RYNumberKeyboard *tNumberKb = [[RYNumberKeyboard alloc] init];
     tNumberKb.textFiled = _textField;
    _textField.inputView = tNumberKb;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
