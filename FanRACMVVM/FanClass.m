//
//  FanClass.m
//  Mitbbs_Forum
//
//  Created by Fan on 15-1-16.
//  Copyright (c) 2015年 未名空间. All rights reserved.
//

#import "FanClass.h"

@implementation FanClass

#pragma mark - 邮箱校验
+(BOOL)validateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
#pragma mark - 用户名校验
+(BOOL)validateUserName:(NSString *)userName {
    NSString *Regex = @"^[A-Za-z]{1}+[A-Z0-9a-z]{2,11}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    if (![predicate evaluateWithObject:userName]) {
        return NO;
    } ;
    //    unichar c=[userName characterAtIndex:0];
    //    if ((c>'a'&&c<'z')||(c>'A'&&c<'Z')) {
    //
    //    }else{
    //        return NO;
    //    }
    BOOL isNum=NO;
    for (int i=1; i<userName.length; i++) {
        unichar c=[userName characterAtIndex:i];
        if (isNum) {
            if ((c<'0'||c>'9')) {
                return NO;
            }
        }else{
            if ((c>'0'&&c<'9')) {
                if (!isNum) {
                    isNum=YES;
                }
            }
        }
        
    }
    return YES;

}
#pragma mark - 用户名校验
+(BOOL)validateUserName1:(NSString *)userName {
   // NSString *Regex = @"^[A-Za-z]{1}+[A-Z0-9a-z]{2,11}";
    //NSString *Regex1 = @"^[A-Za-z]{1}+[A-Za-z]{2,11}";
    NSString *Regex = @"^[A-Za-z]{1}+[a-zA-Z0-9]{1,10}+[0-9]{1}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [predicate evaluateWithObject:userName];
}
#pragma mark - 用户名校验
+(BOOL)validateUserName2:(NSString *)userName {
    NSString *Regex = @"^[A-Za-z]{1}+[A-Z0-9a-z]{2,11}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    if (![predicate evaluateWithObject:userName]) {
        return NO;
    } ;
//    unichar c=[userName characterAtIndex:0];
//    if ((c>'a'&&c<'z')||(c>'A'&&c<'Z')) {
//        
//    }else{
//        return NO;
//    }
    BOOL isNum=NO;
    for (int i=1; i<userName.length; i++) {
        unichar c=[userName characterAtIndex:i];
        if (isNum) {
            if ((c<'0'||c>'9')) {
                return NO;
            }
        }else{
            if ((c>'0'&&c<'9')) {
                if (!isNum) {
                    isNum=YES;
                }
            }
        }
        
    }
    return YES;
}
#pragma mark - 密码校验
+(BOOL)validatePassword:(NSString *)password {
    NSString *Regex = @"[\\S]{6,18}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [predicate evaluateWithObject:password];
}


#pragma mark - 手机号验证
+(BOOL)validateTelphonNum:(NSString *)telNum {
    for (int i=1; i<telNum.length; i++) {
        unichar c=[telNum characterAtIndex:i];
        if ((c<'0'||c>'9')) {
            return NO;
        }
    }
    return YES;
    
}

// 获取字符串的字符长度  汉字2 字母1
+ (long int)fan_byteLengthFrom:(NSString *)string
{
    long int len = 0;
    char *p = (char *)[string cStringUsingEncoding:NSUnicodeStringEncoding];
    
    for (int i = 0; i < [string lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++) {
        if (*p) {
            p++;
            len++;
        }else {
            p++;
        }
    }
    return len;
}
@end
