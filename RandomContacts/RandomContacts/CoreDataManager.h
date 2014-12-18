//
//  CoreDataManager.h
//  RandomContacts
//
//  Created by Dave Hunter on 2014-12-17.
//  Copyright (c) 2014 Dave Hunter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Contact+JSON.h"

@interface CoreDataManager : NSObject

@property (nonatomic,readonly) NSPersistentStoreCoordinator* coordinator;
@property (nonatomic,readonly) NSManagedObjectContext* ctx;

+ (CoreDataManager*)instance;

@end
