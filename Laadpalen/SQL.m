//
//  SQL.m
//  Laadpalen
//
//  Created by Max van Doren on 12-12-14.
//  Copyright (c) 2014 Max van Doren. All rights reserved.
//

#import "SQL.h"
#import "FMDatabase.h"


@implementation SQL


+ (NSString *)pathToDB:(NSString *)aVersion
          dbsDirectory:(NSString *)aDbsDirectory
               dbsName:(NSString *)aDbsName
          dbsExtension:(NSString *)aDbsExtension {
    NSString *bundlePathDB = [[NSBundle mainBundle] pathForResource:aDbsName
                                                             ofType:aDbsExtension
                              ];
    NSArray *supportPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true);
    NSString *supportPath = [NSString stringWithFormat:@"%@/%@.%@"
                             ,[supportPaths objectAtIndex:0]
                             , aDbsDirectory
                             , aVersion
                             ];
    NSString *supportPathDB = [NSString stringWithFormat:@"%@/%@.%@"
                               , supportPath
                               , aDbsName
                               , aDbsExtension
                               ];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    NSError *error = nil;
    if (![fileManager fileExistsAtPath:supportPath isDirectory:&isDir])
        if (![fileManager createDirectoryAtPath:supportPath withIntermediateDirectories:true attributes:nil error:nil])
            return nil;
    if (![fileManager fileExistsAtPath:supportPathDB])
        if (![fileManager copyItemAtPath:bundlePathDB toPath:supportPathDB error:&error])
            return nil;
    return supportPathDB;
}


+ (NSArray *)sqlSelectLaadpalen:(FMDatabase *)aDatabase
             laadpalenPredicate:(NSDictionary *)aLaadpalenPredicate {
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@"
                     , SQL_TABLE_LAADPALEN
                     ];
    NSLog(@"sql = %@", sql);
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    FMResultSet *resultSet = [aDatabase executeQuery:sql];
    while ([resultSet next])
        [resultArray addObject:[resultSet resultDictionary]];
    [resultSet close];
    return [resultArray count] ? [resultArray copy] : nil;
}


@end
