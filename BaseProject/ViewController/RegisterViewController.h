//
//  RegisterViewController.h
//  BaseProject
//
//  Created by tarena on 15/12/7.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Signup)(BmobUser *user);

@interface RegisterViewController : UIViewController

- (void)didSignUpWithBlock: (Signup )signUp;

@end
