//
//  FanClass.h
//  Mitbbs_Forum
//
//  Created by Fan on 15-1-16.
//  Copyright (c) 2015年 未名空间. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FanClass : NSObject



#pragma mark - 邮箱校验
+(BOOL)validateEmail:(NSString *)email;
#pragma mark - 用户名校验（两次验证）
+(BOOL)validateUserName:(NSString *)userName;
+(BOOL)validateUserName1:(NSString *)userName;
#pragma mark - 用户名校验
+(BOOL)validatePassword:(NSString *)password;
#pragma mark - 手机号验证
+(BOOL)validateTelphonNum:(NSString *)telNum;
+ (long int)fan_byteLengthFrom:(NSString *)string;
@end
