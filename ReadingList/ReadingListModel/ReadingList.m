#import "ReadingList.h"
#import "Book.h"

NSString * const TitleKey = @"title";
NSString * const BooksKey = @"books";

@implementation ReadingList

- (id)initWithTitle:(NSString *)title books:(NSArray *)books
{
    NSDictionary *dict = @{TitleKey: title, BooksKey: books};
    if (!(self = [super initWithDictionary:dict])) return nil;
    return self;
}

+ (instancetype)readingListWithTitle:(NSString *)title books:(NSArray *)books
{
    return [[self alloc] initWithTitle:title books:books];
}

+ (NSArray *)keys
{
    return @[TitleKey, BooksKey];
}

- (NSDictionary *)dictionaryRepresentation
{
    NSDictionary *values = [super dictionaryWithValuesForKeys:[self.class keys]];
    NSArray *books = values[BooksKey];
    
    NSMutableArray *bookDicts = [NSMutableArray arrayWithCapacity:books.count];
    for (Book *currBook in books) {
        [bookDicts addObject:currBook.dictionaryRepresentation];
    }
    
    NSMutableDictionary *mutableValues = [values mutableCopy];
    mutableValues[BooksKey] = bookDicts;
    
    return mutableValues;
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:BooksKey])
    {
        NSArray *dictionaries = (NSArray *) value;
        
        if ([dictionaries.firstObject isKindOfClass:[NSDictionary class]])
        {
            NSMutableArray *books = [NSMutableArray arrayWithCapacity:dictionaries.count];
            for (NSDictionary *currDict in dictionaries) {
                [books addObject:[Book modelObjectWithDictionary:currDict]];
            }
            
            value = books;
        }
    }
    
    [super setValue:value forKey:key];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"\nTitle: %@\nBooks: %@", self.title, self.books];
}

@end
