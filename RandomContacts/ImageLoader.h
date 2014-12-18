//
//  ImageLoader.h
//  RandomContacts
//
//  Created by Dave Hunter on 2014-12-17.
//  Copyright (c) 2014 Dave Hunter. All rights reserved.
//

#import <UIKit/UIKit.h>

// Returns nil if no image is found
typedef void(^ImageCompletionBlock)(UIImage* image);

@interface ImageLoader : NSObject

+ (ImageLoader*)instance;
- (void)loadImageWithURL:(NSURL*)url onCompletion:(ImageCompletionBlock)completionBlock;

@end
