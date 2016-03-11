#import "RELAddBookController.h"

#import "Book.h"
#import "Author.h"

@interface RELAddBookController ()

@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextField *yearField;
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;

@end


@implementation RELAddBookController

- (NSDictionary *)bookDictionary
{
    return @{ BookTitleKey: self.titleField.text,
              YearKey:      self.yearField.text,
              AuthorKey:    self.authorDictionary };
}

- (NSDictionary *)authorDictionary
{
    return @{ FirstNameKey: self.firstNameField.text,
              LastNameKey:  self.lastNameField.text };
}

- (Book *)book
{
    return [Book modelObjectWithDictionary:self.bookDictionary];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Done"])
    {
        self.completion(self.book);
    }
}

@end
