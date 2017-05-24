# RYNumberkeyboard

#直接把 RYNumberkeyboard,导入RYNumberkeyboard.h就可以用了 </br>

#example
</br>
_textField=[[UITextField alloc]initWithFrame:CGRectMake(100, 100, 200, 30)];</br>
_textField.delegate=self;</br>
_textField.layer.borderWidth=1;</br>
_textField.layer.borderColor=[UIColor grayColor].CGColor;</br>
[self.view addSubview:_textField];</br>
RYNumberKeyboard *tNumberKb = [[RYNumberKeyboard alloc] init];</br>
tNumberKb.textFiled = _textField;</br>
_textField.inputView = tNumberKb;</br>
