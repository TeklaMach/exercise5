//LIBRARY//

print("WELCOME TO THE HOGWARTS LIBRARY ✨📚")

class Book {
    var bookID: Int
    var title: String
    var author: String
    var isBorrowed: Bool
    
    init(bookID: Int, title: String, author: String) {
        self.bookID = bookID
        self.title = title
        self.author = author
        self.isBorrowed = false
    }
    
    func markAsBorrowed() {
        isBorrowed = true
    }
    
    func markAsReturned() {
        isBorrowed = false
    }
}

class Owner {
    var ownerId: Int
    var name: String
    var borrowedBooks: [Book]
    
    init(ownerId: Int, name: String) {
        self.ownerId = ownerId
        self.name = name
        self.borrowedBooks = []
    }
    
    func borrowBook(book: Book) {
        book.markAsBorrowed()
        borrowedBooks.append(book)
    }
    
    func returnBook(book: Book) {
        book.markAsReturned()
        if let index = borrowedBooks.firstIndex(where: { $0.bookID == book.bookID }) {
            borrowedBooks.remove(at: index)
        }
    }
}

class Library {
    var books: [Book]
    var owners: [Owner]
    
    init() {
        self.books = []
        self.owners = []
    }
    
    func addBook(book: Book) {
        books.append(book)
    }
    
    func addOwner(owner: Owner) {
        owners.append(owner)
    }
    
    func findAllAvailableBooks() -> [Book] {
        return books.filter { !$0.isBorrowed }
    }
    
    func findAllBorrowedBooks() -> [Book] {
        books.filter { $0.isBorrowed }
    }
    
    func findOwnerByID(ownerId: Int) -> Owner? {
        owners.first { $0.ownerId == ownerId }
    }
    
    func findBooksBorrowedByOwner(owner: Owner) -> [Book] {
        owner.borrowedBooks
    }
    
    func allowBorrow(owner: Owner, book: Book) {
        if !book.isBorrowed {
            owner.borrowBook(book: book)
        } else {
            print("Book '\(book.title)' is already borrowed.")
        }
    }
}

let book1 = Book(bookID: 1, title: "Fantastic Beasts and Where to Find Them", author: "J.K. Rowling")
let book2 = Book(bookID: 3, title: "A Comprehensive History of the Game and Its Rules", author: "J.K. Rowling")
let book3 = Book(bookID: 4, title: "Newt Scamander's Masterwork on Magical Creatures", author: "J.K. Rowling")

let owner1 = Owner(ownerId: 101, name: "Harry Potter")
let owner2 = Owner(ownerId: 102, name: "Hermione Granger")

let library = Library()

library.addBook(book: book1)
library.addBook(book: book2)
library.addBook(book: book3)

library.addOwner(owner: owner1)
library.addOwner(owner: owner2)

library.allowBorrow(owner: owner1, book: book1)
library.allowBorrow(owner: owner2, book: book2)

print("\nBooks borrowed by \(owner1.name): \(owner1.borrowedBooks.map { $0.title })")
print("Books borrowed by \(owner2.name): \(owner2.borrowedBooks.map { $0.title })")

print("\nAll available books: \(library.findAllAvailableBooks().map { $0.title })")
print("All borrowed books: \(library.findAllBorrowedBooks().map { $0.title })")

//E-commerce-ish//

class Product {
    let productID: Int
    var name: String
    var price: Double
    
    init(productID: Int, name: String, price: Double) {
        self.productID = productID
        self.name = name
        self.price = price
    }
}

class Cart {
    let cartID: Int
    var items: [Product]
    
    init(cartID: Int) {
        self.cartID = cartID
        self.items = []
    }
    
    func addProduct(product: Product) {
        items.append(product)
    }
    
    func removeProduct(productID: Int) {
        items.removeAll { $0.productID == productID }
    }
    
    func calculateTotalPrice() -> Double {
        items.reduce(0) { $0 + $1.price }
    }
}

class User {
    let userID: Int
    var username: String
    var cart: Cart
    
    init(userID: Int, username: String, cartID: Int) {
        self.userID = userID
        self.username = username
        self.cart = Cart(cartID: cartID)
    }
    
    func addProductToCart(product: Product) {
        cart.addProduct(product: product)
    }
    
    func removeProductFromCart(productID: Int) {
        cart.removeProduct(productID: productID)
    }
    
    func checkout() -> Double {
        let totalPrice = cart.calculateTotalPrice()
        print("\(username)'s Cart Total Price: $\(totalPrice)")
        
        if !cart.items.isEmpty {
            print("Purchased Products:")
            for product in cart.items {
                print("- \(product.name) ($\(product.price))")
            }
        } else {
            print("No products purchased.")
        }
        
        print("Checkout completed. Payment of $\(totalPrice) has been made.")
        cart.items.removeAll()
        return totalPrice
    }
}

let product1 = Product(productID: 1, name: "Laptop", price: 1200.89)
let product2 = Product(productID: 2, name: "Smartphone", price: 800.99)
let product3 = Product(productID: 3, name: "Headphones", price: 500.0)

let user1 = User(userID: 101, username: "Lala", cartID: 201)
let user2 = User(userID: 102, username: "Po", cartID: 202)

user1.addProductToCart(product: product1)
user1.addProductToCart(product: product2)

user2.addProductToCart(product: product2)
user2.addProductToCart(product: product3)

let amountToPayUser1 = user1.checkout()
let amountToPayUser2 = user2.checkout()

print("\(user1.username)'s Cart Total Price after Checkout: $\(user1.cart.calculateTotalPrice())")
print("\(user2.username)'s Cart Total Price after Checkout: $\(user2.cart.calculateTotalPrice())")

