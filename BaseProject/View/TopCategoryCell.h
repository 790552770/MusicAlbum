//
//  TopCategoryCell.h
//  BaseProject
//
//  Created by tarena on 15/11/14.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRImageView.h"

@interface TopCategoryCell : UITableViewCell
/** 序号标签 */
@property(nonatomic,strong) UILabel *orderLb;
/** 类型图片 */
@property(nonatomic,strong) TRImageView *iconIV;
/** 类型名称 */
@property(nonatomic,strong) UILabel *titleLb;
/** 类型描述 */
@property(nonatomic,strong) UILabel *descLb;
/** 集数 */
@property(nonatomic,strong) UILabel *numberLb;
/** 集数图标 */
@property(nonatomic,strong) TRImageView *numberIV;




@end
