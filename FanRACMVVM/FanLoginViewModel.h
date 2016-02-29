//
//  FanLoginViewModel.h
//  FanRACMVVM
//
//  Created by 向阳凡 on 16/1/8.
//  Copyright © 2016年 凡向阳. All rights reserved.
//

#import <ReactiveViewModel/ReactiveViewModel.h>
#import <ReactiveCocoa/RACCommand.h>
#import "FanAPIManager.h"

@interface FanLoginViewModel : RVMViewModel

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *password;

@property (nonatomic, strong) RACCommand *regesterCommand;
@property (nonatomic, strong) RACCommand *loginCommand;


/**
 *  API接口对象
 */
@property (nonatomic, strong) FanAPIManager *apiManager;

/**
 *  错误
 */
@property (nonatomic, strong) NSError *error;

/**
 *  是否正在执行
 */
@property (nonatomic, assign) NSNumber *executing;

@property (nonatomic, strong,readonly) NSMutableDictionary *modelDic;

@end
