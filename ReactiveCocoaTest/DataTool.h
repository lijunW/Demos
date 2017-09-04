//
//  DataTool.h
//  SifuBang
//
//  Created by 王立军 on 2017/5/9.
//  Copyright © 2017年 sifang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataTool : NSObject
+ (void)ConfigRealmMigration;
+ (void)ConfigRealmMigrationToVersion:(int)Version;
+(void)save:(id)model;
+(id)get:(Class)modelClass;
@end
