//
//  TopNetManager.m
//  BaseProject
//
//  Created by tarena on 15/11/14.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "TopNetManager.h"

#define kRankListPath   @"http://mobile.ximalaya.com/mobile/discovery/v1/rankingList/album"
#define kAlbumPath      @"http://mobile.ximalaya.com/mobile/others/ca/album/track/%@/true/%@/20"



@implementation TopNetManager

+ (id)getRankListWithPageId:(NSInteger)pageId completionHandle:(void (^)(id, NSError *))completionHandle{
    NSDictionary *params = @{@"device":@"iPhone",@"key":@"ranking:album:played:1:2",@"pageId":@(pageId),@"pageSize":@20,@"position":@0,@"title":@"排行榜"};
    return [self GET:kRankListPath parameters:params completionHandler:^(id responseObj, NSError *error) {
        completionHandle([RankingListModel mj_objectWithKeyValues:responseObj],error);
    }];
}

+ (id)getAlbumWithId:(NSInteger)ID page:(NSInteger)pageId completionHandle:(void (^)(id, NSError *))completionHandle{
    NSString *path = [NSString stringWithFormat:kAlbumPath,@(ID),@(pageId)];
    return [self GET:path parameters:@{@"device":@"iPhone"} completionHandler:^(id responseObj, NSError *error) {
        completionHandle([AlbumModel mj_objectWithKeyValues:responseObj],error);
    }];
}








@end
