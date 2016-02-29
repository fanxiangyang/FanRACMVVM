# FanRACMVVM

*MVVM的设计模式（RAC的使用）

## 简单的登录实现


```
//ViewController实现
@weakify(self);
RAC(self.viewModel,userName)=self.userNameTextField.rac_textSignal;
RAC(self.viewModel,password)=self.passwordTextField.rac_textSignal;
self.regestButton.rac_command=self.viewModel.regesterCommand;
self.loginButton.rac_command=self.viewModel.loginCommand;
[self rac_liftSelector:@selector(toggleHUD:) withSignals:RACObserve(self.viewModel, executing), nil];
[self rac_liftSelector:@selector(showMessage:) withSignals:[[RACObserve(self.viewModel, error) ignore:nil] map:^id (id value) {
    return [value localizedDescription];
}], nil];

[[RACObserve(self.viewModel, modelDic) ignore:nil] subscribeNext:^(id x) {
    @strongify(self);
    [self showMessage:@"登录成功"];
    //跳转到
    NSLog(@"登录结果：%@",x);
    SBJson4Writer *jsmodel4=[[SBJson4Writer alloc]init];
    NSString *msg=[jsmodel4 stringWithObject:x];
    self.showTextView.text=msg;
}];

//ViewModel实现
-(RACCommand *)loginCommand{
    if (!_loginCommand) {
        @weakify(self);
        _loginCommand=[[RACCommand alloc]initWithEnabled:
                       [RACSignal combineLatest:@[RACObserve(self, userName), RACObserve(self, password)] reduce:^id (NSString *userName, NSString *password){
            //1.字符串校验
            return @(([FanClass validateUserName:userName]&&[FanClass validatePassword:password]));
        }]signalBlock:^RACSignal *(id input) {
            //2.网络请求得到结果
            @strongify(self);
            return [self.apiManager loginWithUserName:self.userName password:self.password];
        }];
        
        [[_loginCommand.executionSignals concat] subscribeNext:^(id x) {
            //3.订阅结果
            @strongify(self);
            self.modelDic = x;
        }];
        [_loginCommand.errors subscribeNext:^(id x) {
            //4.订阅错误信息
            @strongify(self);
            self.error = x;
        }];
        [_loginCommand.executing subscribeNext:^(id x) {
            //订阅执行的状态
            @strongify(self);
            self.executing = x;
        }];
    }
    return _loginCommand;
}

```


###开发环境

* OS X 10.11.2
* Xcode Version 7.2 

####有问题请直接在文章下面留言。
####喜欢此系列文章可以点击上面右侧的 Star 哦，变成 Unstar 就可以了！ 
###开发人：凡向阳
####Email:fanxiangyang_heda@163.com
