//
//  RYNumberKeyBoard.h
//  RYNumberKeyboardDemo
//
//  Created by Resory on 16/2/20.
//  Copyright © 2016年 Resory. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SYS_DEVICE_WIDTH    ([[UIScreen mainScreen] bounds].size.width)                 //屏幕宽度
#define SYS_DEVICE_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)                //屏幕长度

typedef NS_ENUM(NSUInteger, RYInputType) {
    RYIntInputType,        // 整数键盘
    RYFloatInputType,      // 浮点数键盘
    RYIDCardInputType,     // 身份证键盘
};
@class RYNumberKeyboard;
@protocol RYNumberKeyboardDelegate <NSObject>
- (void)RYNumberKeyboardSureDidClick:(RYNumberKeyboard *)keyboard WithTextFiled:(UITextField*)textFiled;
- (void)RYNumberKeyboardWillEditing:(RYNumberKeyboard *)keyboard WithTextFiled:(UITextField*)textFiled;
- (void)RYNumberKeyboardTextString:(RYNumberKeyboard *)keyboard WithTextFiled:(UITextField*)textFiled string:(NSString *)string;
@end
@interface RYNumberKeyboard : UIView

@property (nonatomic, weak) UITextField<UITextInput> *textInput;
@property (nonatomic, assign) RYInputType inputType;        // 键盘类型
@property (nonatomic, strong) NSNumber *interval;           // 每隔多少个数字空一格
@property (nonatomic, weak) id<RYNumberKeyboardDelegate>deleate;

- (id)initWithInputType:(RYInputType)inputType;


@end
