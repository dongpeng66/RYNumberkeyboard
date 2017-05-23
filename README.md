# RYNumberkeyboard

#直接把 RYNumberkeyboard,导入RYNumberkeyboard.h就可以用了 

#example
#_textField=[[UITextField alloc]initWithFrame:CGRectMake(100, 100, 200, 30)];
#_textField.delegate=self;
# _textField.layer.borderWidth=1;
#_textField.layer.borderColor=[UIColor grayColor].CGColor;
#[self.view addSubview:_textField];
#RYNumberKeyboard *tNumberKb = [[RYNumberKeyboard alloc] init];
#tNumberKb.textFiled = _textField;
#_textField.inputView = tNumberKb;
