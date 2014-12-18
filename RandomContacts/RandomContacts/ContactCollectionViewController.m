//
//  ContactCollectionViewController.m
//  RandomContacts
//
//  Created by Dave Hunter on 2014-12-17.
//  Copyright (c) 2014 Dave Hunter. All rights reserved.
//

#import "ContactCollectionViewController.h"
#import "ContactCollectionViewCell.h"
#import "UIImageView+URL.h"
#import "ContactGrabber.h"
#import "ContactDetailsViewController.h"

@interface ContactCollectionViewController ()
@property (nonatomic,readwrite) NSFetchedResultsController* fetchedResults;
@property (nonatomic,readwrite) NSMutableArray* addedIndexPaths;

@end

@implementation ContactCollectionViewController

static NSString * const reuseIdentifier = @"ContactCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Contact"];
    
    [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"firstName" ascending:YES]]];
    
    NSManagedObjectContext* ctx = [CoreDataManager instance].ctx;

    self.fetchedResults = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:ctx sectionNameKeyPath:nil cacheName:nil];
    
    [self.fetchedResults setDelegate:self];
    
    NSError* theErr = nil;
    [self.fetchedResults performFetch:&theErr];
    
    if ( theErr ) {
        NSLog(@"Unable to load contacts");
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addOne:(id)sender
{
    [ContactGrabber grabContacts:1 onSuccess:^(NSArray* contacts)
     {
     }
                         onError:^(NSError* error)
     {
         [self showErrorAdding];
     }];
}

- (IBAction)addFive:(id)sender
{
    [ContactGrabber grabContacts:5 onSuccess:^(NSArray* contacts)
     {
     }
                         onError:^(NSError* error)
     {
         [self showErrorAdding];
     }];
    
}

- (void)showErrorAdding
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error Adding Contact" message:@"Can't add a contact.  Please try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSArray* indexPaths = [self.collectionView indexPathsForSelectedItems];
    
    NSIndexPath* indexPath = [indexPaths objectAtIndex:0];
    Contact* contact = [self.fetchedResults objectAtIndexPath:indexPath];
    
    ContactDetailsViewController* detailsVC = segue.destinationViewController;
    
    detailsVC.contact = contact;
    
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return [[self.fetchedResults sections] count];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    NSArray *sections = [self.fetchedResults sections];
    id<NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
    
    return [sectionInfo numberOfObjects];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ContactCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    Contact* contact = [self.fetchedResults objectAtIndexPath:indexPath];

    cell.contactName.text = contact.firstName;
    NSURL* url = [NSURL URLWithString:contact.pictureThumb];
    
    cell.contactImageView.imageURL = url;
    
    return cell;
}

#pragma mark <NSFetchedResultsControllerDelegate>

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    self.addedIndexPaths = [NSMutableArray new];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.addedIndexPaths addObject:newIndexPath];
            break;
        case NSFetchedResultsChangeDelete:
        case NSFetchedResultsChangeUpdate:
        case NSFetchedResultsChangeMove:
            NSAssert( NO, @"Not implemented." );
            break;

    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.collectionView insertItemsAtIndexPaths:self.addedIndexPaths];
    self.addedIndexPaths = nil;
}


@end
