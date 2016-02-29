//
//  FanAPIManager.h
//  FanRACMVVM
//
//  Created by 向阳凡 on 16/1/8.
//  Copyright © 2016年 凡向阳. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface FanAPIManager : JSONModel
/**
 *  通用的POST请求
 *
 *  @param path       请求地址
 *  @param parameters 请求参数
 *
 *  @return signal
 */
-(RACSignal *)requestWithPath:(NSString *)path parameters:(id)parameters;
/**
 *  登录
 *
 *  @param userName 用户名
 *  @param password 密码
 *
 *  @return signal
 */
-(RACSignal *)loginWithUserName:(NSString *)userName password:(NSString *)password;
@end
