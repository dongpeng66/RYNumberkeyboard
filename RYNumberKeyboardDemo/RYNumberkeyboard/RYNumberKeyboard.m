//
//  RYNumberKeyBoard.m
//  RYNumberKeyboardDemo
//
//  Created by Resory on 16/2/20.
//  Copyright © 2016年 Resory. All rights reserved.
//

#import "RYNumberkeyboard.h"

@interface RYNumberKeyboard ()<UIKeyInput,UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIView *keyboardView;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@end

@implementation RYNumberKeyboard

- (id)initWithInputType:(RYInputType)inputType
{
    self = [super init];
    
    if(self)
    {
        // 通知
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(editingDidBegin:)
//                                                     name:UITextFieldTextDidBeginEditingNotification
//                                                   object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(editingDidEnd:)
//                                                     name:UITextFieldTextDidEndEditingNotification
//                                                   object:nil];
        
        // 添加keyboardview
        [[NSBundle mainBundle] loadNibNamed:@"RYNumberKeyboard" owner:self options:nil];
        self.frame = CGRectMake(0, 0, SYS_DEVICE_WIDTH, 216);
        self.keyboardView.frame = self.frame;
        [self addSubview:self.keyboardView];
        
        // 设置图片
        [self.deleteBtn setImage:[UIImage imageNamed:@"RYNumbeKeyboard.bundle/image/delete.png"]
                        forState:UIControlStateNormal];
        
        self.inputType = inputType;
        
        self.textInput.delegate=self;
    }
    
    return self;
}

- (void)setInterval:(NSNumber *)interval
{
    _interval = interval;
}

- (void)setInputType:(RYInputType)inputType
{
    UIButton *xBtn = [self viewWithTag:1011];
    UIButton *dotBtn = [self viewWithTag:1010];
    
    _inputType = inputType;
    
    switch (inputType)
    {
        // 浮点数键盘
        case RYFloatInputType:
        {
            xBtn.hidden = YES;
            dotBtn.hidden = NO;
            break;
        }
        // 身份证键盘
        case RYIDCardInputType:
        {
            xBtn.hidden = NO;
            dotBtn.hidden = YES;
            break;
        }
        // 数字键盘
        default:
        {
            xBtn.hidden = YES;
            dotBtn.hidden = YES;
            break;
        }
    }
}

- (IBAction)keyboardViewAction:(UIButton *)sender
{
    NSInteger tag = sender.tag;
    
    switch (tag)
    {
        case 1010:
        {
            // 小数点
            if(self.textInput.text.length > 0 && ![self.textInput.text containsString:@"."])
                [self.textInput insertText:@"."];
        }
            break;
        case 1011:
        {
            // 身份证X
            if(self.textInput.text.length > 0 && ![self.textInput.text containsString:@"X"])
                [self.textInput insertText:@"X"];
        }
            break;
        case 1012:
        {
            // 删除
            if(self.textInput.text.length > 0)
                [self.textInput deleteBackward];
        }
            break;
        case 1013:
        {
            // 确认
            if ([self.deleate respondsToSelector:@selector(RYNumberKeyboardSureDidClick:WithTextFiled:)]) {
                [self.deleate RYNumberKeyboardSureDidClick:self WithTextFiled:self.textInput];
            }
            [self.textInput resignFirstResponder];
        }
            break;
        default:
        {
            // 数字
            NSString *text = [NSString stringWithFormat:@"%ld",sender.tag - 1000];
            [self.textInput insertText:text];
            
            if(self.interval && (self.textInput.text.length+1) % ([self.interval integerValue] + 1) == 0)
                [self.textInput insertText:@" "];
        }
            break;
    }
    
    NSString *firstString=nil;
    if (self.textInput.text.length>=1) {
        firstString=[self.textInput.text  substringWithRange:NSMakeRange(0, 1)];
    }
    NSString *secondString=nil;
    if (self.textInput.text.length>=2) {
        secondString=[self.textInput.text  substringWithRange:NSMakeRange(1, 1)];
    }
    
    if ([firstString isEqualToString:@"0"]) {
        if ([secondString isEqualToString:@"."]) {
            int myIndex = 0;
            
            NSMutableArray *arr = [NSMutableArray array];
            for (int i=1; i<=self.textInput.text .length; i++) {
                [arr addObject:[self.textInput.text  substringWithRange:NSMakeRange(i-1, 1)]];
                if ([arr[i-1] isEqualToString:@"."]) {
                    myIndex = i;
                }
            }
            
            if(myIndex!=0){
                
                if (self.textInput.text .length-myIndex>2) {
                    self.textInput.text  = [self.textInput.text substringToIndex:self.textInput.text.length-1];
                }
                
            }
        }else{
            if (self.textInput.text.length>=2) {
                self.textInput.text  = [self.textInput.text substringToIndex:self.textInput.text.length-1];
            }
            
        }
    }else{
        int myIndex = 0;
        
        NSMutableArray *arr = [NSMutableArray array];
        for (int i=1; i<=self.textInput.text .length; i++) {
            [arr addObject:[self.textInput.text  substringWithRange:NSMakeRange(i-1, 1)]];
            if ([arr[i-1] isEqualToString:@"."]) {
                myIndex = i;
            }
        }
        
        if(myIndex!=0){
            
            if (self.textInput.text .length-myIndex>2) {
                self.textInput.text  = [self.textInput.text substringToIndex:self.textInput.text.length-1];
            }
            
        }
    }
    
    if ([self.deleate respondsToSelector:@selector(RYNumberKeyboardTextString:WithTextFiled:string:)]) {
        [self.deleate RYNumberKeyboardTextString:self WithTextFiled:self.textInput string:self.textInput.text];
    }
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([self.deleate respondsToSelector:@selector(RYNumberKeyboardWillEditing:WithTextFiled:)]) {
        [self.deleate RYNumberKeyboardWillEditing:self WithTextFiled:textField];
    }
    return YES;
}
#pragma mark -
#pragma mark - Notification Action
//- (void)editingDidBegin:(NSNotification *)notification {
//    if (![notification.object conformsToProtocol:@protocol(UITextInput)])
//    {
//        self.textInput = nil;
//        return;
//    }
//    self.textInput = notification.object;
//}
//
//- (void)editingDidEnd:(NSNotification *)notification
//{
//    self.textInput = nil;
//}

#pragma mark -
#pragma mark - UIKeyInput Protocol


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
