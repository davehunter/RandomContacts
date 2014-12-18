//
//  RandomContactsTests.m
//  RandomContactsTests
//
//  Created by Dave Hunter on 2014-12-17.
//  Copyright (c) 2014 Dave Hunter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "CoreDataManager.h"

@interface RandomContactsTests : XCTestCase
@property (nonatomic,strong) NSManagedObjectContext* ctx;
@end

@implementation RandomContactsTests

- (void)setUp {
    [super setUp];

    NSManagedObjectModel* objectModel = [NSManagedObjectModel mergedModelFromBundles:[NSArray arrayWithObject:[NSBundle bundleForClass:[CoreDataManager class]]]];
    
    NSPersistentStoreCoordinator* coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:objectModel];
    
    XCTAssert( [coordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:NULL], @"Can't add store" );
    
    self.ctx = [[NSManagedObjectContext alloc] init];
    self.ctx.persistentStoreCoordinator = coordinator;

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testLoadingContactFromJSON {
    // This is an example of a functional test case.
    
    NSString* jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"TestContact" ofType:@"json"];
    
    XCTAssert( jsonPath != nil, @"Can't find test Json path");

    
    NSData* data = [NSData dataWithContentsOfFile:jsonPath];
    
    XCTAssert( jsonPath != nil, @"Can't load test Json data");
    
    NSError* theErr = nil;
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data
                                                                         options:0
                                                                           error:&theErr];
    XCTAssert( theErr == nil, @"Can't parse json");


    Contact* contact = [Contact contactFromJSON:result managedObjectContext:self.ctx];
    
    XCTAssert( contact != nil, @"Couldn't get contact");
    
    XCTAssert( [contact.firstName isEqualToString:@"barbra"], @"Not barbra!" );
    XCTAssert( [contact.lastName isEqualToString:@"streisand"], @"Not streisand!" );

}

@end
