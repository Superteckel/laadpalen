//
//  SQL.h
//  Laadpalen
//
//  Created by Max van Doren on 12-12-14.
//  Copyright (c) 2014 Max van Doren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"


@interface SQL : NSObject


#define SQL_DBS_DIRECTORY                   @"main"
#define SQL_DBS_NAME_DATABASE               @"laadpalen"
#define SQL_DBS_NAME_EXTENSION              @"sqlite"


#define SQL_TABLE_LAADPALEN                 @"laadpalen2"

#define SQL_COLUMN_ADDRESS                  @"address"
#define SQL_COLUMN_LONGITUDE                @"longitude"
#define SQL_COLUMN_LATITUDE                 @"latitude"

#define SQL_COLUMN_COUNT                    @"count"
#define SQL_COLUMN_TYPE                     @"type"
#define SQL_COLUMN_TYPE_SNELLADER           @"typeSnellader"



+ (NSString *)pathToDB:(NSString *)aVersion
          dbsDirectory:(NSString *)aDbsDirectory
               dbsName:(NSString *)aDbsName
          dbsExtension:(NSString *)aDbsExtension;

+ (NSArray *)sqlSelectLaadpalen:(FMDatabase *)aDatabase;

@end
