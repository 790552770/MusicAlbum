//
//  RegisterViewController.m
//  BaseProject
//
//  Created by tarena on 15/12/7.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "RegisterViewController.h"
#import "ReLoginViewController.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTx;

@property (weak, nonatomic) IBOutlet UITextField *passwordTx;
@property (copy, nonatomic) Signup signUp;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登陆";
}
- (void)didSignUpWithBlock:(__autoreleasing Signup)signUp{
    self.signUp = signUp;
}
- (IBAction)login:(id)sender {
    [BmobUser loginWithUsernameInBackground:self.nameTx.text password:self.passwordTx.text block:^(BmobUser *user, NSError *error) {
        if (!error) {
            self.signUp(user);
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
            NSLog(@"Login failed : REASON :%@",error.description);
        }
    }];
//    [BmobUser loginWithUsernameInBackground:self.nameTx.text password:self.passwordTx.text];
//    BmobUser *buser = [BmobUser getCurrentUser];
//    [BmobUser logout];
//    if (buser) {
//        [self.navigationController popViewControllerAnimated:YES];
//        
//    }else {
//        ReLoginViewController *vc = [ReLoginViewController new];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
