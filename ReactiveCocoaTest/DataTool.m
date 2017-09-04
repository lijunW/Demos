//
//  DataTool.m
//  SifuBang
//
//  Created by 王立军 on 2017/5/9.
//  Copyright © 2017年 sifang. All rights reserved.
//

#import "DataTool.h"
#import <Realm/Realm.h>
@implementation DataTool
+(void)ConfigRealmMigration{
    // 在 [AppDelegate didFinishLaunchingWithOptions:] 中进行配置
    //RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    
    [self ConfigRealmMigrationToVersion:2];

}
+ (void)ConfigRealmMigrationToVersion:(int)Version{
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    if (Version > 0) {
        config.schemaVersion = Version;
    }
    config.migrationBlock = ^(RLMMigration *migration, uint64_t oldSchemaVersion) {
    };
    [RLMRealmConfiguration setDefaultConfiguration:config];
}
@end
