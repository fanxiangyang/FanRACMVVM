//
//  FanLoginViewModel.m
//  FanRACMVVM
//
//  Created by 向阳凡 on 16/1/8.
//  Copyright © 2016年 凡向阳. All rights reserved.
//

#import "FanLoginViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "FanClass.h"

@interface FanLoginViewModel()

@property (nonatomic, strong, readwrite) NSMutableDictionary *modelDic;


@end

@implementation FanLoginViewModel
- (instancetype)init{
    if((self = [super init])) {
        [self.didBecomeActiveSignal
         subscribeNext:^(id x) {
             NSLog(@"%s ---Active!", __func__);
         }];
        [self.didBecomeInactiveSignal
         subscribeNext:^(id x) {
             NSLog(@"%s ---Inactive!", __func__);
         }];
        self.apiManager = [[FanAPIManager alloc] init];
    }
    return self;
}

-(RACCommand *)regesterCommand{
    if (!_regesterCommand) {
        
    }
    return _regesterCommand;
}
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
@end
