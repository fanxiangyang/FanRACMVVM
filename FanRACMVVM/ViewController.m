//
//  ViewController.m
//  FanRACMVVM
//
//  Created by 向阳凡 on 16/1/4.
//  Copyright © 2016年 凡向阳. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "FanLoginViewModel.h"
#import <SBJson/SBJson4.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithWhite:0.95 alpha:1];
    // Do any additional setup after loading the view, typically from a nib.
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

    
}
-(void)toggleHUD:(NSNumber *)state{
    if ([state boolValue]) {
        [self showMessage:@"正在执行"];
    }else{
        [self showMessage:@"执行完毕"];
    }
}

-(void)showMessage:(NSString *)msg{
    NSLog(@"msg:%@",msg);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
