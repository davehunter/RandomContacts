//
//  Contact+JSON.m
//  RandomContacts
//
//  Created by Dave Hunter on 2014-12-17.
//  Copyright (c) 2014 Dave Hunter. All rights reserved.
//

#import "Contact+JSON.h"

@implementation Contact(JSON)

+ (instancetype)contactFromJSON:(NSDictionary*)json managedObjectContext:(NSManagedObjectContext*)ctx
{
    NSString* entityName = NSStringFromClass([self class]);
    Contact* contact = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:ctx];
    NSDictionary* user = json[@"user"];
    
    NSDictionary* name = user[@"name"];
    contact.title = name[@"title"];
    contact.firstName = name[@"first"];
    contact.lastName = name[@"last"];

    NSDictionary* location = user[@"location"];
    contact.state = location[@"state"];
    contact.street = location[@"street"];
    contact.city = location[@"city"];
    contact.zip = location[@"zip"];

    NSDictionary* picture = user[@"picture"];
    contact.pictureLarge = picture[@"large"];
    contact.pictureMedium = picture[@"medium"];
    contact.pictureThumb = picture[@"thumbnail"];

    contact.cell = user[@"cell"];
    contact.phone = user[@"phone"];
    contact.email = user[@"email"];
 
    return contact;
}

@end
