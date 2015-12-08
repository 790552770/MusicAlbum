//
//  MyMusicViewController.m
//  BaseProject
//
//  Created by tarena on 15/11/7.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MyMusicViewController.h"
#import "TopCategoryViewModel.h"
#import "TopCategoryCell.h"
#import "MusicListViewController.h"


@interface MyMusicViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) TopCategoryViewModel *topVM;

@end

@implementation MyMusicViewController

- (TopCategoryViewModel *)topVM{
    if (!_topVM) {
        _topVM = [TopCategoryViewModel new];
    }
    return _topVM;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.rowHeight = 170/2;
        _tableView.estimatedRowHeight = 170/2;
        
        [_tableView registerClass:[TopCategoryCell class] forCellReuseIdentifier:@"Cell"];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.topVM refreshDataCompletionHandle:^(NSError *error) {
                if (error) {
                    [self showErrorMsg:error];
                }else{
                    [self.tableView reloadData];
                    //重置脚步，没有更多数据
                    [_tableView.footer resetNoMoreData];
                }
                [_tableView.header endRefreshing];
            }];
        }];
        self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self.topVM getMoreDataCompletionHandle:^(NSError *error) {
                if (error) {
                    [self showErrorMsg:error.localizedDescription];
                }else{
                    [self.tableView reloadData];
                    if ([self.topVM isHasMore]) {
                        [_tableView.footer endRefreshing];
                    }else{
                        [_tableView.footer endRefreshingWithNoMoreData];
                    }
                    
                }
                
            }];
        }];
        
    }
    return _tableView;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"倾听心灵";
        self.tabBarItem.image = [UIImage imageNamed:@"tabbar_item_my_music"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self.tableView.header beginRefreshing];
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.topVM.rowNumber;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TopCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.titleLb.text = [self.topVM titleForRow:indexPath.row];
    [cell.iconIV.imageView setImageWithURL:[self.topVM iconURLForRow:indexPath.row] placeholderImage:[UIImage imageNamed:@"UMS_url_music"]];
    cell.orderLb.text = @(indexPath.row + 1).stringValue;
    
    cell.descLb.text = [self.topVM descForRow:indexPath.row];
    cell.numberLb.text = [self.topVM numberForRow:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MusicListViewController *vc = [[MusicListViewController alloc] initWithAlbumId:[self.topVM albumIdForRow:indexPath.row]];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
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
