//
//  ContactCollectionViewCell.h
//  RandomContacts
//
//  Created by Dave Hunter on 2014-12-17.
//  Copyright (c) 2014 Dave Hunter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *contactImageView;
@property (weak, nonatomic) IBOutlet UILabel *contactName;

@end
