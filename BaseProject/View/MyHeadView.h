//
//  MyHeadView.h
//  BaseProject
//
//  Created by tarena on 15/12/6.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyHeadView : UIView
/** 毛玻璃*/
@property (nonatomic,strong) UIVisualEffectView *effectview;
/** 背景图*/
@property (nonatomic,strong) UIImageView *imaView1;
/** 头像*/
@property (nonatomic,strong) UIImageView *imaView2;
/** 登陆*/
@property (nonatomic,strong) UIButton *btn1;
/** 注册 */
@property (nonatomic,strong) UIButton *btn2;
/** 用户名 */
@property (nonatomic,strong) UILabel *nameLb;



@end
