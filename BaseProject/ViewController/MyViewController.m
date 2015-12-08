//
//  MyViewController.m
//  BaseProject
//
//  Created by tarena on 15/12/6.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MyViewController.h"
#import "MyHeadView.h"
#import "RegisterViewController.h"
#import "ReLoginViewController.h"

@interface MyViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
@property (nonatomic,strong) MyHeadView *myhd;

@end

@implementation MyViewController
- (MyHeadView *)myhd{
    if (!_myhd) {
        _myhd = [[MyHeadView alloc] init];
        _myhd.frame = CGRectMake(0, 0, 0, 200);
    }
    return _myhd;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableHeaderView = self.myhd;
    [self.myhd.btn1 bk_addEventHandler:^(id sender) {
        RegisterViewController *vc = [RegisterViewController new];
        [vc didSignUpWithBlock:^(BmobUser *user) {
            self.myhd.nameLb.text = user.username;
            self.myhd.btn1.hidden = YES;
            self.myhd.btn2.hidden = YES;
        }];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    } forControlEvents:UIControlEventTouchUpInside];

    [self.myhd.btn2 bk_addEventHandler:^(id sender) {
        ReLoginViewController *reVc = [ReLoginViewController new];
        reVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:reVc animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];

    //添加上传头像的手势
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    //tapGR.numberOfTapsRequired = 1;
    [self.myhd.imaView2 addGestureRecognizer:tapGR];

    
   
}

- (void)tap{
    UIActionSheet *sheet;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
    }else{
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
    }
    sheet.tag = 255;
    [sheet showInView:self.view];
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
    self.myhd.imaView2.image = saveImage;
    
    self.myhd.imaView2.tag = 100;
    
    
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






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell new];
    
   
    
    return cell;
}



//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 200;
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
