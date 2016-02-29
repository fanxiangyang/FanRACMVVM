//
//  FanAPIManager.m
//  FanRACMVVM
//
//  Created by 向阳凡 on 16/1/8.
//  Copyright © 2016年 凡向阳. All rights reserved.
//

#import "FanAPIManager.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking-RACExtensions/AFHTTPRequestOperationManager+RACSupport.h>
#import <SBJson/SBJson4.h>

@interface FanAPIManager()

@property (nonatomic,strong)AFHTTPRequestOperationManager *manager;

@end

@implementation FanAPIManager
- (AFHTTPRequestOperationManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPRequestOperationManager manager];
        
        //RequestSerializer
        [_manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        //Cookie
        [_manager.requestSerializer setValue:[self getCookieString] forHTTPHeaderField:@"Cookie"];
        //ResponseSerializer
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    }
    return _manager;
}
- (NSString *)getCookieString{
    NSString *cookieStr = [NSString stringWithFormat: @"UTMPKEY=%@;UTMPNUM=%@;UTMPUSERID=%@;LOGINTIME=%@;COUNTRY=%@",
                           @"1", @"1", @"1", @"1", @"1"];
        return cookieStr;
}
-(RACSignal *)requestWithPath:(NSString *)path parameters:(id)parameters{
    return [[self.manager rac_POST:path parameters:parameters]reduceEach:^id (NSDictionary *dictionary,NSHTTPURLResponse *response){
        return dictionary;
    }];
}
-(RACSignal *)loginWithUserName:(NSString *)userName password:(NSString *)password{
    NSParameterAssert(userName);
    NSParameterAssert(password);
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
    [dic setObject:@"0601" forKey:@"reqType"];
    [dic setObject:userName forKey:@"username"];
    [dic setObject:password forKey:@"password"];
    [dic setObject:@"yes" forKey:@"kickmulti"];
    [dic setObject:@"BBS" forKey:@"app_type"];
    [dic setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:@"device_id"];
//    JSONModel *jsmodel=[[JSONModel alloc]initWithDictionary:dic error:nil];
    SBJson4Writer *jsmodel4=[[SBJson4Writer alloc]init];
    NSString *msg=[jsmodel4 stringWithObject:dic];
    NSString *path=@"http://123.57.11.223/iphone_new/service_new.php";
    
    //2.1 POST请求
    return [[[[[self requestWithPath:path parameters:@{@"msg":msg}]
    map:^id(id value) {
        //2.2这里可以过滤数据
        return [self analysisValue:value];
    }]flattenMap:^RACStream *(id value) {
        //2.3过滤错误数据
        if ([value isKindOfClass:[NSError class]]) {
            return [RACSignal error:value];
        }
        return [RACSignal return:value];
    }]logError]replayLazily];
}
/**
 *  处理错误的方法（不通用）
 *
 *  @param value value
 *
 *  @return value
 */
-(id)analysisValue:(id)value{
    if(![value isKindOfClass:[NSDictionary class]]) {
        return value;
    }
    
    NSInteger resultCode = [[(NSDictionary *)value objectForKey:@"result"] integerValue];
    if(1 == resultCode) {
        return value[@"data"][0];
    }
    
    return [NSError errorWithDomain:@"KFanAPIErrorDomain" code:resultCode userInfo:@{NSLocalizedDescriptionKey:value[@"data"][0][@"faileDesc"]}];
}
@end
