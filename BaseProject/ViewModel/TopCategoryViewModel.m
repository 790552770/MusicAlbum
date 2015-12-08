//
//  TopCategoryViewModel.m
//  BaseProject
//
//  Created by tarena on 15/11/14.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "TopCategoryViewModel.h"

@implementation TopCategoryViewModel

- (void)refreshDataCompletionHandle:(CompletionHandle)completionHandle{
    _pageId = 1;
    [self getDataFromNetCompleteHandle:completionHandle];
}

- (void)getMoreDataCompletionHandle:(CompletionHandle)completionHandle{
    if (self.isHasMore) {
        _pageId += 1;
        [self getDataFromNetCompleteHandle:completionHandle];
    }else{
        NSError *error = [NSError errorWithDomain:@"" code:999 userInfo:@{NSLocalizedDescriptionKey:@"没有更多数据了"}];
        completionHandle(error);
    }
}

- (void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle{
    self.dataTask = [TopNetManager getRankListWithPageId:_pageId completionHandle:^(RankingListModel *model, NSError *error) {
        if (!error) {
            if (_pageId == 1) {
                [self.dataArr removeAllObjects];
                
            }
            [self.dataArr addObjectsFromArray:model.list];
            _maxPageId = model.maxPageId;
            
        }
        completionHandle(error);
    }];
}

- (RankListListModel *)modelForRow:(NSInteger)row{
    return self.dataArr[row];
}

- (NSInteger)rowNumber{
    return self.dataArr.count;
}
- (NSInteger)albumIdForRow:(NSInteger)row{
    return [self modelForRow:row].albumId;
}

- (NSURL *)iconURLForRow:(NSInteger)row{
    return [NSURL URLWithString:[self modelForRow:row].albumCoverUrl290];
    
}

- (NSString *)titleForRow:(NSInteger)row{
    return [self modelForRow:row].title;
}

- (NSString *)descForRow:(NSInteger)row{
    return [self modelForRow:row].intro;
}

- (NSString *)numberForRow:(NSInteger)row{
    return [NSString stringWithFormat:@"%ld集",[self modelForRow:row].tracks];
}

- (BOOL)isHasMore{
    return _maxPageId > _pageId;
}







@end
