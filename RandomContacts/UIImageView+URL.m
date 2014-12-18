//
//  UIImageView+URL.m
//  RandomContacts
//
//  Created by Dave Hunter on 2014-12-17.
//  Copyright (c) 2014 Dave Hunter. All rights reserved.
//

#import "UIImageView+URL.h"
#import <objc/runtime.h>
#import "ImageLoader.h"

@implementation UIImageView(URL)
@dynamic imageURL;

- (void)setImageURL:(NSURL*)url {
    NSURL* localURL = [url copy];
    
    objc_setAssociatedObject(self, @selector(imageURL), localURL, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    self.image = nil;
    
    [[ImageLoader instance] loadImageWithURL:url onCompletion:^(UIImage* image)
     {
         if ( !image )
         {
             self.image = nil;
         }
         else if ( [localURL isEqual:self.imageURL] )
         {
             self.image = image;
         }
     }];
    

}

- (id)imageURL {
    return objc_getAssociatedObject(self, @selector(imageURL));
}

@end
