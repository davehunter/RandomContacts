//
//  ImageLoader.m
//  RandomContacts
//
//  Created by Dave Hunter on 2014-12-17.
//  Copyright (c) 2014 Dave Hunter. All rights reserved.
//

#import "ImageLoader.h"

@interface ImageLoader()

@property (nonatomic,strong) NSMutableDictionary* imageCache;

@end

@implementation ImageLoader

+ (ImageLoader*)instance
{
    static dispatch_once_t pred;
    static ImageLoader *shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [ImageLoader new];
    });
    
    return shared;
}

- (id)init
{
    self = [super init];
    
    if ( self )
    {
        _imageCache = [NSMutableDictionary new];
        
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidReceiveMemoryWarningNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
            NSLog(@"Emptying image cache");
            self.imageCache = [NSMutableDictionary new];
        }];

    }
    
    return self;
}


- (void)loadImageWithURL:(NSURL*)url onCompletion:(ImageCompletionBlock)completionBlock
{
    NSString* key = url.absoluteString;
    
    UIImage* cachedImage = self.imageCache[key];

    if ( cachedImage )
    {
        completionBlock( cachedImage );
        return;
    }
    
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if ( error )
         {
             completionBlock( nil );
             return;
         }
         
         UIImage* image = [UIImage imageWithData:data];
         
         if ( image )
         {
             self.imageCache[key] = image;
         }
         
         completionBlock( image );
     }];

}


@end
