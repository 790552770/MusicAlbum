//
//  AlbumModel.m
//  BaseProject
//
//  Created by tarena on 15/11/14.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "AlbumModel.h"

@implementation AlbumModel

@end
@implementation AlbumAlbumModel

@end


@implementation AlbumTracksModel

+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [AlbumTracksListModel class]};
}

@end


@implementation AlbumTracksListModel

@end


