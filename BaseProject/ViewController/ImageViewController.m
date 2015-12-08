//
//  ImageViewController.m
//  BaseProject
//
//  Created by tarena on 15/11/7.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UITextFieldDelegate>
@property(nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIButton *btn;
@property (nonatomic,strong) UIView *vie;
@property (nonatomic,strong) UITextField *writeTX;
@property (nonatomic,strong) UIButton *btn1;

@end

@implementation ImageViewController

- (UIButton *)btn1{
    if (!_btn1) {
        _btn1 = [UIButton buttonWithType:0];
//        _btn1.buttonColor = [UIColor whiteColor];
//        _btn1.shadowColor = [UIColor blackColor];
//        _btn1.shadowHeight = 3.0f;
//        _btn1.cornerRadius = 6.0f;
        _btn1.titleLabel.font = [UIFont boldFlatFontOfSize:15];
        
        [_btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn1 setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
        
        [_btn1 setTitle:@"保存" forState:0];
        
        
        [_btn1 bk_addEventHandler:^(id sender) {
            
            UIGraphicsBeginImageContextWithOptions(self.vie.frame.size, YES, 0.0);
            
            [self.vie.layer renderInContext:UIGraphicsGetCurrentContext()];
            UIImage *ima = UIGraphicsGetImageFromCurrentImageContext();
            
            UIImageWriteToSavedPhotosAlbum(ima, nil, nil, nil);
           
//            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"保存成功" message:@"111" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
//            
//            [alter show];
//            [alter reloadInputViews];
            
            MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            progressHUD.labelText = @"保存成功";
            progressHUD.mode = MBProgressHUDModeText;
            [progressHUD hide:YES afterDelay:1];
            //[MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            

            
        } forControlEvents:UIControlEventTouchUpInside];
        
        
        
        
    }
    return _btn1;

}

- (UITextField *)writeTX{
    if (!_writeTX) {
        _writeTX = [[UITextField alloc]init];
        _writeTX.font = [UIFont systemFontOfSize:16];
        _writeTX.textColor = [UIColor blackColor];
        _writeTX.placeholder = @"添加文字";
       

        //_writeTX.clearsOnBeginEditing = YES;
        _writeTX.delegate = self;
        [self.vie addSubview:_writeTX];
//        [_writeTX mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.imageView.mas_bottom).mas_equalTo(5);
//            make.bottom.mas_equalTo(-5);
//            make.left.mas_equalTo(5);
//            make.right.mas_equalTo(-5);
//            //make.bottom.mas_equalTo(8);
//        }];
    }
    return _writeTX;
}


- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleToFill;
        //_imageView.backgroundColor = [UIColor blackColor];
        _imageView.image = [UIImage imageNamed:@"3.jpg"];
        [self.vie addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            //make.size.mas_equalTo(CGSizeMake(200, 200));
            make.bottom.mas_equalTo(-4);
            make.left.mas_equalTo(4);
            make.right.mas_equalTo (-4);
            //make.bottom.mas_equalTo(self.writeTX.mas_top).mas_equalTo(3);
            make.height.mas_equalTo(380);
         
            
        }];
    }
    return _imageView;
}
- (UIView *)vie{
    if (!_vie) {
        _vie = [[UIView alloc] init];
        _vie.backgroundColor = [UIColor whiteColor];
        _vie.layer.cornerRadius = 5;
    }
    return _vie;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"碎玉无声";
        self.tabBarItem.image = [UIImage imageNamed:@"tabbar_item_my_music-1"];
    }
    return self;
}


- (UIButton *)btn{
    if (!_btn) {
        _btn = [FUIButton buttonWithType:0];

        _btn.titleLabel.font = [UIFont boldFlatFontOfSize:15];
        
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
       
        [_btn setTitle:@"添加" forState:0];
        
        
        [_btn bk_addEventHandler:^(id sender) {
            UIActionSheet *sheet;
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
            }else{
                sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
            }
            sheet.tag = 255;
            [sheet showInView:self.vie];
            
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

//实现actionSheet delegate事件
/** 判断是否支持相机，跳转到相机或相册界面 */
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 255) {
        NSInteger sourceType = 0;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0:
                    //取消
                    return;
                case 1:
                    //相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 2:
                    //相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                    
            }
        }else{
            if (buttonIndex == 0) {
                return;
            }else{
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        //跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        [self presentViewController:imagePickerController animated:YES completion:nil];
        
    }
}

#pragma  -- ImagePickerdelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self saveImage:image withName:@"currentImage.png"];
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    UIImage *saveImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    //saveImage.size = CGSizeMake(100, 100);
    
    self.imageView.image = saveImage;
    
     self.imageView.tag = 100;
    
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}


/** 图片压缩 */
- (void)saveImage:(UIImage *)currentImage withName:(NSString *)imageName{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    [imageData writeToFile:fullPath atomically:NO];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIImageView *ima = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"20140219214112_VHNVS.jpg"]];
    [self.view addSubview:ima];
    [ima mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    self.btn.frame = CGRectMake(0, 0, 50, 40);
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.btn];
    
    self.navigationItem.leftBarButtonItem = item;
    
    self.btn1.frame = CGRectMake(0, 0, 50, 40);
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:self.btn1];
    self.navigationItem.rightBarButtonItem = item1;
  
    
   
    
    [self.view addSubview:self.vie];
    [self.vie mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        //make.top.mas_equalTo(self.btn.mas_bottom).mas_equalTo(8);
        make.size.mas_equalTo(CGSizeMake(300, 430));
        //        make.left.mas_equalTo(20);
        //        make.right.mas_equalTo(-20);
        //make.bottom.mas_equalTo(100);
        
    }];
    
    
    
    [self.vie addSubview:self.writeTX];
    
   // self.writeTX.backgroundColor = [UIColor yellowColor];
    
    [_writeTX mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.imageView.mas_top).mas_equalTo(-2);
        make.top.mas_equalTo(2);
        make.left.mas_equalTo(2);
        make.right.mas_equalTo(-2);
        //make.bottom.mas_equalTo(8);
    }];

    //self.writeTX.frame = CGRectMake(0, 0, 200, 200);
    
    
    
}
//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    if (range.location>=20)
//    {
//        return  NO;
//        //[self.writeTX resignFirstResponder];
//    }
//    else
//    {
//        return YES;
//    }
//    
//    if ([self.writeTX.text isEqualToString:@"\n"]) {
//        [textView resignFirstResponder];
//        return NO;
//    }
//    return YES;
//    
//}

//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

//* 滑动放大缩小图片 
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    UITouch *touch = [touches anyObject];
//    CGPoint touchPoint = [touch locationInView:self.view];
//    CGPoint imagePoint = self.imageView.frame.origin;
//    //触点在imageView内 点击时放大，再次点击时缩小
//    if (imagePoint.x <= touchPoint.x && imagePoint.x + self.imageView.frame.size.width >= touchPoint.x && imagePoint.y <= touchPoint.y && imagePoint.y+self.imageView.frame.size.height >= touchPoint.y) {
//        //设置图片放大动画
//        [UIView beginAnimations:nil context:nil];
//        //动画时间
//        [UIView setAnimationDuration:1];
//        if (isfullScree) {
//            <#statements#>
//        }
//    }
//}
//
//
//* 上传图片 
//ASIFormDataRequest *requestReport  = [[ASIFormDataRequest alloc] initWithURL:服务器地址];
//
//NSString *Path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
//
//[requestReport setFile:Path forKey:@"picturepath"];
//
//[requestReport buildPostBody];
//
//requestReport.delegate = self;
//
//[requestReport startAsynchronous];
//



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
