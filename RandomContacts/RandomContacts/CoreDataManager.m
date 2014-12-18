//
//  CoreDataManager.m
//  RandomContacts
//
//  Created by Dave Hunter on 2014-12-17.
//  Copyright (c) 2014 Dave Hunter. All rights reserved.
//

#import "CoreDataManager.h"

@implementation CoreDataManager

+ (CoreDataManager*)instance
{
    static dispatch_once_t pred;
    static CoreDataManager *shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [CoreDataManager new];
    });
    
    return shared;
}

- (id)init
{
    self = [super init];
    if ( self )
    {
        NSURL* modelUrl = [[NSBundle bundleForClass:[self class]] URLForResource:@"RandomContacts" withExtension:@"momd"];
        NSManagedObjectModel* model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelUrl];
        
        _coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
        
        NSArray* paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
        NSString* applicationSupportDirectory = [paths firstObject];
        NSString* saveDir = [applicationSupportDirectory stringByAppendingPathComponent:@"RandomContacts"];
        
        NSError* theErr = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:saveDir withIntermediateDirectories:YES attributes:nil error:&theErr];
        if ( theErr )
        {
            return nil;
        }
        NSString* saveLocation = [saveDir stringByAppendingPathComponent:@"database.sqlite"];

        NSURL* dbURL = [NSURL fileURLWithPath:saveLocation];
        

        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                                 [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];

        if (![_coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:dbURL options:options error:nil])
        {
            return nil;
        }
        
        _ctx = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        _ctx.persistentStoreCoordinator = _coordinator;

    }
    return self;
}

@end
