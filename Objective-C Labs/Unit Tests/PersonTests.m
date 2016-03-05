#import "AOITestCase.h"
#import "Person.h"

@interface PersonTests : AOITestCase
//{
//    Person *_person;
//}

@end


@implementation PersonTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testPart01
{
    Person *fred = [[Person alloc] init];
    [fred setFirstName:@"Fred"];
    [fred setLastName:@"Smith"];
    [fred setAge:32];
    
    NSLog(@"\nfirst name: %@"
          @"\nlast name: %@"
          @"\nage: %d",
          [fred firstName],
          [fred lastName],
          [fred age]);
}

- (void)testPart02
{
    Person *fred = [[Person alloc] initWithFirstName:@"Fred"
                                            lastName:@"Smith"
                                                 age:32];
    NSLog(@"%@", [fred fullName]);
    
    NSLog(@"%@", [fred description]);
    
    NSLog(@"%@", fred);
}

- (void)testPart03
{
    NSArray *people = @[[Person personWithFirstName:@"Fred"
                                           lastName:@"Smith"
                                                age:32],
                        [Person personWithFirstName:@"Jill"
                                           lastName:@"Brown"
                                                age:27],
                        [Person personWithFirstName:@"Lee"
                                           lastName:@"Jones"
                                                age:41]];
    for (Person *currPerson in people)
    {
        [currPerson display];
    }
}

- (void)testPart04
{
    NSArray *people = @[[Person personWithFirstName:@"Fred" lastName:@"Smith" age:32],
                        [Person personWithFirstName:@"Jill" lastName:@"Brown" age:27],
                        [Person personWithFirstName:@"Lee" lastName:@"Jones" age:41],
                        [Person personWithFirstName:@"Greg" lastName:@"Moore" age:25],
                        [Person personWithFirstName:@"Sue" lastName:@"Davis" age:36]];
    
    [people[0] setFavoritesRanking:3];
    [people[1] setFavoritesRanking:999];
    [people[2] setFavoritesRanking:0];
    [people[3] setFavoritesRanking:3];
    [people[4] setFavoritesRanking:4];
    
    printf("\nPeople:\n-------\n");
    for (Person *currPerson in people) {
        [currPerson display];
    }
    
    NSSortDescriptor *sortDesc = [NSSortDescriptor
                                  sortDescriptorWithKey:@"favoritesRanking"
                                  ascending:NO];
    NSArray *sortedPeeps = [people sortedArrayUsingDescriptors:@[sortDesc]];
    
    printf("\nSorted People:\n--------------\n");
    for (Person *currPerson in sortedPeeps) {
        [currPerson display];
    }
}

- (void)testPart05
{
    NSArray *people = @[[Person personWithFirstName:@"Fred" lastName:@"Smith" age:32],
                        [Person personWithFirstName:@"Jill" lastName:@"Brown" age:27],
                        [Person personWithFirstName:@"Al" lastName:@"Smith" age:41],
                        [Person personWithFirstName:@"Greg" lastName:@"Brown" age:25],
                        [Person personWithFirstName:@"Sue" lastName:@"Davis" age:36]];
    
    [people[0] setFavoritesRanking:3];
    [people[1] setFavoritesRanking:2];
    [people[2] setFavoritesRanking:3];
    [people[3] setFavoritesRanking:2];
    [people[4] setFavoritesRanking:3];
    
    printf("\nPeople:\n-------\n");
    for (Person *currPerson in people) {
        [currPerson display];
    }
    
    NSSortDescriptor *d1 = [NSSortDescriptor
                            sortDescriptorWithKey:@"favoritesRanking"
                            ascending:NO];
    NSSortDescriptor *d2 = [NSSortDescriptor
                            sortDescriptorWithKey:@"lastName"
                            ascending:YES];
    NSSortDescriptor *d3 = [NSSortDescriptor
                            sortDescriptorWithKey:@"firstName"
                            ascending:YES];
    NSArray *sortedPeeps = [people sortedArrayUsingDescriptors:@[d1, d2, d3]];
    
    printf("\nSorted People:\n--------------\n");
    [sortedPeeps makeObjectsPerformSelector:@selector(display)];
}

@end
