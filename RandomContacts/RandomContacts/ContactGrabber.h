//
//  ContactGrabber.h
//  RandomContacts
//
//  Created by Dave Hunter on 2014-12-17.
//  Copyright (c) 2014 Dave Hunter. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ContactSuccessBlock)(NSArray* contacts);
typedef void(^ContactErrorBlock)(NSError* error);

@interface ContactGrabber : NSObject

+ (void)grabContacts:(NSUInteger)numberOfContacts onSuccess:(ContactSuccessBlock)successBlock onError:(ContactErrorBlock)errorBlock;

@end
