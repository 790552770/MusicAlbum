//
//  ReLoginViewController.m
//  BaseProject
//
//  Created by tarena on 15/12/7.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "ReLoginViewController.h"


@interface ReLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;

@end

@implementation ReLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
}

- (IBAction)register:(id)sender {
    BmobUser *bUser = [[BmobUser alloc] init];
    [bUser setUsername:self.nameText.text];
    [bUser setPassword:self.passwordText.text];
    [bUser signUpInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful){
            MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            progressHUD.labelText = @"注册成功";
            progressHUD.mode = MBProgressHUDModeText;
            [progressHUD hide:YES afterDelay:1];
            NSTimer *time = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(pop) userInfo:nil repeats:NO];
            //[self.navigationController popViewControllerAnimated:YES];
        }else{
            NSLog(@"%@",error);
        }
            
    }];
    
    
}

- (void)pop{
    [self.navigationController popViewControllerAnimated:YES];
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
