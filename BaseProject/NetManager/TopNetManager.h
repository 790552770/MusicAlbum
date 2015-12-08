//
//  TopNetManager.h
//  BaseProject
//
//  Created by tarena on 15/11/14.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseNetManager.h"
#import "TopModel.h"

@interface TopNetManager : BaseNetManager

+ (id)getRankListWithPageId:(NSInteger)pageId kCompletionHandle;

+ (id)getAlbumWithId:(NSInteger)ID page:(NSInteger)pageId kCompletionHandle;



@end
