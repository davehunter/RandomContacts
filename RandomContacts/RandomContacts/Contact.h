//
//  Contact.h
//  RandomContacts
//
//  Created by Dave Hunter on 2014-12-17.
//  Copyright (c) 2014 Dave Hunter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Contact : NSManagedObject

@property (nonatomic, retain) NSString * cell;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * pictureLarge;
@property (nonatomic, retain) NSString * pictureMedium;
@property (nonatomic, retain) NSString * pictureThumb;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSString * street;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * zip;

@end
