//
//  ContactDetailsViewController.m
//  RandomContacts
//
//  Created by Dave Hunter on 2014-12-17.
//  Copyright (c) 2014 Dave Hunter. All rights reserved.
//

#import "ContactDetailsViewController.h"
#import "UIImageView+URL.h"

@interface ContactDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *phoneButton;
@property (weak, nonatomic) IBOutlet UIButton *emailButton;

@end

@implementation ContactDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", self.contact.firstName, self.contact.lastName];
    self.navigationItem.title = self.contact.firstName;
    
    self.imageView.imageURL = [NSURL URLWithString:self.contact.pictureLarge];
    
    [self.phoneButton setTitle:self.contact.cell forState:UIControlStateNormal];
    
    [self.emailButton setTitle:self.contact.email forState:UIControlStateNormal];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onPhone:(id)sender
{
    NSString* urlString = [NSString stringWithFormat:@"tel:%@",self.contact.cell];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

- (IBAction)onEmail:(id)sender
{
    NSString* urlString = [NSString stringWithFormat:@"mailto:%@",self.contact.email];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];

}

@end
