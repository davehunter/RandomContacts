//
//  Contact+JSON.h
//  RandomContacts
//
//  Created by Dave Hunter on 2014-12-17.
//  Copyright (c) 2014 Dave Hunter. All rights reserved.
//

#import "Contact.h"

@interface Contact(JSON)

+ (instancetype)contactFromJSON:(NSDictionary*)json managedObjectContext:(NSManagedObjectContext*)ctx;

@end
