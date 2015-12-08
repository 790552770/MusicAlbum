//
//  MyHeadView.m
//  BaseProject
//
//  Created by tarena on 15/12/6.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MyHeadView.h"


@implementation MyHeadView

- (instancetype)init {
    self = [super init];
    if (self) {
        _imaView1 = self.imaView1;
        _effectview = self.effectview;
        _imaView2 = self.imaView2;
        _btn1 = self.btn1;
        _btn2 = self.btn2;
    }
    return self;
}

- (UIVisualEffectView *)effectview{
    if (!_effectview) {
        _effectview = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        [self.imaView1 addSubview:_effectview];
        [_effectview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _effectview;
}

- (UIImageView *)imaView1{
    if (!_imaView1) {
        _imaView1 = [[UIImageView alloc] init];
        _imaView1.userInteractionEnabled = YES;
        [self addSubview:_imaView1];
        _imaView1.image = [UIImage imageNamed:@"HeaderBack"];
        [_imaView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
        
            }
    return _imaView1;
}

- (UIImageView *)imaView2{
    if (!_imaView2) {
        
        UIView *view = [UIView new];
        [self.effectview.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(100, 100));
        }];
        view.layer.cornerRadius = 50;
        view.clipsToBounds = YES;
        
        _imaView2 = [[UIImageView alloc] init];
        _imaView2.layer.cornerRadius = 50;
        _imaView2.backgroundColor = [UIColor redColor];
        _imaView2.contentMode = 2;
        _imaView2.userInteractionEnabled = YES;
        [view addSubview:self.imaView2];
        [_imaView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
//            make.center.mas_equalTo(0);
//            make.size.mas_equalTo(CGSizeMake(100, 100));
        }];
//        self.clipsToBounds = YES;
    }
    return _imaView2;
}

- (UIButton *)btn1{
    if (!_btn1) {
        _btn1 = [[UIButton alloc] init];
        [_btn1 setTitle:@"登陆" forState:UIControlStateNormal];
        [_btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.effectview.contentView addSubview:_btn1];
        [_btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(self.imaView2.mas_bottom).mas_equalTo(8);
            make.size.mas_equalTo(CGSizeMake(170, 30));
        }];
        
    }
    return _btn1;
}

- (UIButton *)btn2{
    if (!_btn2) {
        _btn2 = [[UIButton alloc]init];
        [_btn2 setTitle:@"注册" forState:UIControlStateNormal];
         [_btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.effectview.contentView addSubview:_btn2];
        [_btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(self.imaView2.mas_bottom).mas_equalTo(8);
            make.size.mas_equalTo(CGSizeMake(170, 30));
        }];
    }
    return _btn2;
}

- (UILabel *)nameLb{
    if (!_nameLb) {
        _nameLb = [UILabel new];
        [self.effectview.contentView addSubview:_nameLb];
        [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(self.imaView2.mas_bottom).mas_equalTo(8);
        }];
        
    }
    return _nameLb;
}





// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
}

@end
