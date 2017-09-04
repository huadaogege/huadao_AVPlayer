//
//  HDFmdbManager.m
//  HDAVPlayer
//
//  Created by huadao on 2017/8/2.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "HDFmdbManager.h"

@implementation HDFmdbManager

+ (HDFmdbManager *)shareInstance {
    static HDFmdbManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HDFmdbManager alloc] init];
    });
    return manager;
}

- (void)initDatabase {
    NSString *fileName = [Document_Path stringByAppendingPathComponent:@"student.sqlite"];
    FMDatabase *database = [FMDatabase databaseWithPath:fileName];
    if ([database open]) {
        BOOL result = [database executeUpdate:@"CREATE TABLE IF NOT EXISTS t_student (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL, number integer NOT NULL);"];
        if (result) {
            NSLog(@"创建成功!");
        } else {
            NSLog(@"创建失败!");
        }
    }
    self.db = database;
}

- (void)insert {
    for (int i = 0; i<10; i++) {
        NSString *name = [NSString stringWithFormat:@"jack-%d", arc4random_uniform(100)];
        [self.db executeUpdateWithFormat:@"INSERT INTO t_student (name, age, number) VALUES ('jack_%@', %d, %d);", name, arc4random_uniform(40), arc4random_uniform(40)];
    }
}

- (void)query {
    // 1.执行查询语句
    FMResultSet *resultSet = [self.db executeQuery:@"SELECT * FROM t_student"];
    // 2.遍历结果
    while ([resultSet next]) {
        int ID = [resultSet intForColumn:@"id"];
        NSString *name = [resultSet stringForColumn:@"name"];
        int age = [resultSet intForColumn:@"age"];
        NSLog(@"%d %@ %d", ID, name, age);
    }
}

- (void)delete {
    [self.db executeUpdate:@"DROP TABLE IF EXISTS t_student;"];
    [self.db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_student (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL, number integer NOT NULL);"];
}


@end
