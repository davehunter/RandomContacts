//
//  ContactGrabber.m
//  RandomContacts
//
//  Created by Dave Hunter on 2014-12-17.
//  Copyright (c) 2014 Dave Hunter. All rights reserved.
//

#import "ContactGrabber.h"
#import "CoreDataManager.h"
#define kContactGrabberURL @"http://api.randomuser.me/"
#define kContactErrorDomain @"com.some.domain"


@implementation ContactGrabber

+ (void)saveContacts:(NSArray*)contacts onSuccess:(ContactSuccessBlock)successBlock onError:(ContactErrorBlock)errorBlock
{
    NSManagedObjectContext* ctx = [CoreDataManager instance].ctx;
    NSError* theErr = nil;

    for ( NSDictionary* contactJSON in contacts )
    {
        Contact* contact = [Contact contactFromJSON:contactJSON managedObjectContext:ctx];
        if ( !contact )
        {
            theErr = [NSError errorWithDomain:kContactErrorDomain code:NSFormattingError userInfo:nil];
            if ( errorBlock )
            {
                errorBlock( theErr );
            }
            return;
        }
    }
    
    [ctx save:&theErr];

    if ( theErr )
    {
        if ( errorBlock )
        {
            errorBlock( theErr );
        }
        return;
    }
    
    if ( successBlock )
    {
        successBlock( contacts );
    }

}

+ (void)grabContacts:(NSUInteger)numberOfContacts onSuccess:(ContactSuccessBlock)successBlock onError:(ContactErrorBlock)errorBlock
{
    NSString* requestURL = [NSString stringWithFormat:@"%@?results=%li",kContactGrabberURL,(unsigned long)numberOfContacts];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestURL]];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPMethod:@"GET"];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         NSError* theErr = connectionError;
         
         if (data.length > 0 && theErr == nil)
         {
             NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data
                                                                    options:0
                                                                      error:&theErr];
             if ( !theErr )
             {
                 NSArray* contacts = [result objectForKey:@"results"];
                 [ContactGrabber saveContacts:contacts onSuccess:successBlock onError:errorBlock];
                 return;
             }
         }
         
         if ( !theErr )
         {
             theErr = [NSError errorWithDomain:kContactErrorDomain code:NSFormattingError userInfo:nil];
         }
         
         if ( errorBlock )
         {
             errorBlock( theErr );
         }
     }];
}

@end
