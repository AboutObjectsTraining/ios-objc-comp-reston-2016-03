#import "Book.h"
#import "Author.h"

NSString * const BookTitleKey = @"title";
NSString * const YearKey = @"year";
NSString * const AuthorKey = @"author";

@implementation Book

+ (NSArray *)keys
{
    return @[BookTitleKey, YearKey, AuthorKey];
}

- (NSDictionary *)dictionaryRepresentation
{
    NSDictionary *values = [super dictionaryWithValuesForKeys:[self.class keys]];
    NSMutableDictionary *mutableVals = [values mutableCopy];
    
    Author *author = mutableVals[AuthorKey];
    mutableVals[AuthorKey] = author.dictionaryRepresentation;
    
    return mutableVals;
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:AuthorKey] && [value isKindOfClass:[NSDictionary class]])
    {
        value = [Author modelObjectWithDictionary:value];
    }
    
    [super setValue:value forKey:key];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"Title: %@, Year: %@, Author: %@", self.title, self.year, self.author];
}

@end









