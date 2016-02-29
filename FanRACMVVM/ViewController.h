//
//  ViewController.h
//  FanRACMVVM
//
//  Created by 向阳凡 on 16/1/4.
//  Copyright © 2016年 凡向阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FanLoginViewModel;
@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *regestButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet FanLoginViewModel *viewModel;

@property (weak, nonatomic) IBOutlet UITextView *showTextView;

@end

