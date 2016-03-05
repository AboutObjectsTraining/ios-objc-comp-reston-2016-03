#import "Person.h"

@implementation Person


// NEW
- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (!(self = [super init])) return nil;
    
    _firstName = [dictionary objectForKey:@"firstName"];
    _lastName = [dictionary objectForKey:@"lastName"];
    _age = [[dictionary objectForKey:@"age"] intValue];
    
    return self;
}
//

//// Part 2
- (id)initWithFirstName:(NSString *)firstName
               lastName:(NSString *)lastName
                    age:(int)age
{
    self = [super init];
    if (!self) return nil;
    
    _firstName = [firstName copy];
    _lastName = [lastName copy];
    _age = age;
    
    return self;
}

- (NSString *)fullName
{
    return [NSString stringWithFormat:@"%@ %@", [self firstName], [self lastName]];
}

//- (NSString *)description
//{
//    return [NSString stringWithFormat:@"name: %@, age: %d",
//            [self fullName], [self age]];
//}
//// Part 2


//// Part 3
+ (instancetype)personWithFirstName:(NSString *)firstName
                           lastName:(NSString *)lastName
                                age:(int)age
{
    return [[self alloc] initWithFirstName:firstName
                                  lastName:lastName
                                       age:age];
}

- (void)display
{
    printf("%s\n", [[self description] UTF8String]);
}
////

//// Part 4

const NSUInteger MaxRanking = 5;

- (NSUInteger)favoritesRanking
{
    return _favoritesRanking;
}

- (void)setFavoritesRanking:(NSUInteger)newValue
{
    _favoritesRanking = newValue > MaxRanking ? MaxRanking : newValue;
}

- (NSString *)favoritesRankingStars
{
    
    if ([self favoritesRanking] == 0)  return @"-";

    return [@"*****" substringToIndex:[self favoritesRanking]];
}

- (NSString *)description
{
    NSString *stars = [self favoritesRankingStars];
    stars = [stars stringByPaddingToLength:MaxRanking
                                withString:@" "
                           startingAtIndex:0];
    
    return [NSString stringWithFormat:@"%@  %@", stars, [self fullName]];
}

////

- (NSString *)firstName
{
    return _firstName;
}

- (void)setFirstName:(NSString *)newValue
{
    _firstName = newValue;
}

- (NSString *)lastName
{
    return _lastName;
}

- (void)setLastName:(NSString *)newValue
{
    _lastName = newValue;
}

- (int)age
{
    return _age;
}

- (void)setAge:(int)newValue
{
    _age = newValue;
}

@end
