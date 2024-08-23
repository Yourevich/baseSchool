import UIKit

var greeting = "Back to school Zorin"
print(greeting)


// Протокольчики

struct Gamer: Hashable, Identifiable {
    
    var name: String
    var age: Int
    var id = UUID()
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
}

////MARK: - Hashable
//extension Gamer: Hashable {
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(name)
//        hasher.combine(age)
//    }
//}

//MARK: - Equatable
extension Gamer: Equatable {
    static func == (lhs: Gamer, rhs: Gamer) -> Bool {
        return lhs.name == rhs.name && lhs.age == rhs.age
    }
}

//MARK: - Comparable
extension Gamer: Comparable {
    
    // Реализация функции сравнения для протокола Comparable
    static func < (lhs: Gamer, rhs: Gamer) -> Bool {
        if lhs.age != rhs.age {
            return lhs.age < rhs.age
        } else {
            return lhs.name < rhs.name
        }
    }
}


//MARK: - Codable
extension Gamer: Codable {
    // Перечисление CodingKeys описывает, как свойства класса будут закодированы и декодированы
    enum CodingKeys: String, CodingKey {
        case name = "_name" // если на беке неймы другие
        case age
    }
}

//MARK: - Identifiable
//extension Gamer: Identifiable {
//
//    var id: UUID { // всегда меняется при КАЖДОМ обращении
//            return UUID()
//        }
//
//
//}


// Создаем экземпляры класса Gamer
let gamer1 = Gamer(name: "Alice", age: 25)
let gamer2 = Gamer(name: "Alice", age: 25)
let gamer3 = Gamer(name: "Charlie", age: 25)

print("\(gamer1.hashValue == gamer2.hashValue)")


// Сравнение на равенство
print(gamer1 == gamer3) // false
print(gamer1 == gamer1) // true

// Сравнение на больше или меньше
print(gamer1 < gamer2) // false
print(gamer2 < gamer1) // true
print(gamer1 < gamer3) // false (так как возраст одинаковый, сравниваем по имени)

// Использование в коллекциях
var gamersSet: Set<Gamer> = [gamer1, gamer2]
gamersSet.insert(gamer3)
print(gamersSet) // Set содержит все три элемента

var gamersArray = [gamer1, gamer2, gamer3]
gamersArray.sort()
print(gamersArray) // Сортировка по возрасту и имени


// Кодирование в JSON
if let jsonData = try? JSONEncoder().encode(gamer1),
   let jsonString = String(data: jsonData, encoding: .utf8) {
    print(jsonString) // {"name":"Alice","age":25}
}

// Декодирование из JSON
let jsonString = "{\"_name\":\"Alice\",\"age\":25}"
if let jsonData = jsonString.data(using: .utf8),
   let decodedGamer = try? JSONDecoder().decode(Gamer.self, from: jsonData) {
    print(decodedGamer) // Gamer(name: Alice, age: 25)
}

// Использование Identifiable
print(gamer1.id) // Уникальный UUID
print(gamer2.id) // Уникальный UUID
print(gamer3.id) // Уникальный UUID



// Функции высшего порядка
// map, filter, reduce, forEach, sorted, и compactMap

var gamers = [
    Gamer(name: "Alice", age: 25),
    Gamer(name: "Bob", age: 20),
    Gamer(name: "Charlie", age: 23),
    Gamer(name: "Dave", age: 20)
]

//MARK: - map. Позволяет достать из коллекции экземпляры с опредеденным свойством


let namesOfGamers = gamers.map { gamer in
    gamer.name
}
print(namesOfGamers)

//MARK: - filter. Возвраает новый массив отфилтрованный по заданному условию

let filterOfGamers = gamers.filter { gamer in
    gamer.age > 18
}
print(filterOfGamers)

// MARK: - reduce. Позволят сложить все значения какой то свойства

let totalAge = gamers.reduce(0) { $0 + $1.age }
print(totalAge)


// MARK: - forEach. Позволяет итерироваться по коллекции и выполнить какое то действие для каждого экземпляра

//gamers.forEach { gamer in
//    gamer.age += 1
//}
print(gamers.map { "\($0.name): \($0.age)" })

//MARK: - sorted. Возвращает новый массив по заданному критерию

let sortedGamers  = gamers.sorted()
print(sortedGamers.map { "\($0.name): \($0.age)" })


//MARK: - compactMap. Позволяет вернуть новый массив без nil-значений

let unknownGamers: [Gamer?] = [
    Gamer(name: "Alice", age: 25),
    nil,
    Gamer(name: "Bob", age: 20),
    nil,
    Gamer(name: "Charlie", age: 23),
    Gamer(name: "Dave", age: 20),
    nil
]

// Использование compactMap для удаления nil значений

let nonNilGamers = gamers.compactMap { $0 }

// MARK: - FlatMap. Схлопываем несколько подмассивов в один новыый массив значений.

let gamersArrayTwo = [gamers, gamers]
gamersArrayTwo.forEach { gamers in
    print(gamers)
}

let numbers = [
    [1, 2, 3, 4],
    [5, 6, 7, 8]
]
let flatNumbers = numbers.flatMap { numbers in
    numbers
}

print(flatNumbers.count)

//MARK: - allSatisfy. Проверка на какое то условие

flatNumbers.allSatisfy { number in
    number > 0
}

print(flatNumbers)

//MARK: - first. Возвращает первое занчение массива

let firsNumber = flatNumbers.first
let unwrappFirstNumber = firsNumber ?? 0
print(unwrappFirstNumber)

//MARK: - last. Возвращает последнее занчение массива

let lastNumber = flatNumbers.last
let unwrappLastNumber = lastNumber ?? 0
print(unwrappLastNumber)

// верни нам первого у кого возраст 20
let firstNumberTwo = gamers.first { gamer in
    gamer.age == 20
}

// верни нам последнего у кого возраст 20
let lastNumberTwo =  gamers.last { gamer in
    gamer.age == 20
}


print(firstNumberTwo!.name)
print(lastNumberTwo!.name)

print(gamers.max()!.name)
print(gamers.min()!.name)

let maxName = gamers.max { gamer1, gamer2 in
    gamer1.name.count < gamer2.name.count
}

print(maxName!.name)


// MARK: - split. Возращает новый массив разделяя исходный по какому то разделителю

let splitNumbers = flatNumbers.split(separator: 5)
print(splitNumbers)

let string = "1, 2, 3, Four"
let resultSplit = string.split(separator: ", ")
print(resultSplit.compactMap({ number in
    Int(number)
}))


//Досмотреть остальные функции высшего порядка для коллекций
// Разобраться с литкодом. Две задачи
// по документации выписать темы которые НЕ чекали или не понятны

//Обработка ошибок
//Замыкания
//ARC
//Диспетчеризация
//Многопоточность



//MARK: - dropFirst и dropLast. Возвращает масссив без первых n и без последних n-элементов. По дефолту удаляет один элемент.

let dropFirst = gamers.dropFirst(3)
print(dropFirst)

let dropLast = gamers.dropLast(2)
print(dropLast)


//MARK: - prefix и suffix. Возвращает первые n- элементов массива и последние.
let prefixOfGamers = gamers.prefix(1)
print(prefixOfGamers)

let suffixOfGamers = gamers.suffix(3)
print(suffixOfGamers)


//MARK: - contains. enumerated

// contains. Проверяет, содержится ли определенный элемент в массиве

let searchOfGamers = gamers.contains(Gamer(name: "Alice", age: 25))
print(searchOfGamers)


//enumerated. Возвращает пары индекс и значение из массива.

for (index, gamer) in gamers.enumerated() {
    print("Индекс: \(index), игрок: \(gamer)")
}


//MARK: - removeAll(where:). Удаляет все элементы, соответствующие заданному условию.

gamers.removeAll { gamer in
    gamer.age < 22
}

gamers.forEach { gamer in
    print(gamer)
}

//MARK: - joined. Объединяет элементы коллекции в одну строку или массив по разделителю

var otherGamers = [
    Gamer(name: "Jack", age: 25),
    Gamer(name: "Peter", age: 20),
    Gamer(name: "Marina", age: 23),
    Gamer(name: "Ivan", age: 20)
]

let namesOfGamerss = otherGamers.map { $0.name}.joined(separator: ",")
print(namesOfGamerss)




//Sum of Two Numbers

func sumOfNumbers(firstNumber: Int, secondNumber: Int) -> Int {
    
    return firstNumber + secondNumber
    
}
print(sumOfNumbers(firstNumber: 5, secondNumber: 20))

//Check if a Number is Even

func checkNumber(_ number: Int) -> Bool {
    
    if number % 2 == 0 {
        return true
    } else {
        return false
    }
    
}
print(checkNumber(4))


//Convert Minutes to Seconds

func convertToSeconds(from minute: Int) -> Int {
    let result = minute * 60
    return result
}

convertToSeconds(from: 1)

//Find the Largest Number

func hightNumber(in numbers: [Int]) -> Int {
    
    var maxNumber = numbers[0]
    
    for number in numbers {
        if number > maxNumber {
            maxNumber = number
        }
    }
    
    return maxNumber
    
}


let maxNumber = hightNumber(in: [4,4,4,10,6])
print(maxNumber)


//Задача 5: Count Occurrences of a Character
//Условие задачи
//Напишите функцию, которая принимает строку и символ, и возвращает количество вхождений этого символа в строку.


func checkCharacter(stroke: String, char: Character) -> Int {
    var character = 0
    
    for c in stroke {
        if c.lowercased() == char.lowercased() { // не важен регистр
            character += 1
        }
    }
    
    return character
}

let occurrences = checkCharacter(stroke: "Easy", char: "a")
print(occurrences)


//Check if a String is Empty


func isEmptyStroke(stroke: String) -> Bool {
    if !stroke.isEmpty {
        return false
    } else {
        return true
    }
}

let chekStroke = isEmptyStroke(stroke: "")



//Find the Length of a String

func findOfLength(stroke: String) -> Int {
    
    return stroke.count
    
}

let lenghtStroke = findOfLength(stroke: "blyad")
print(lenghtStroke)



//  Convert the Temperature

func convertTemperature(_ celsius: Double) -> [Double] {
    
    [celsius + 273.15, celsius * 1.80 + 32.00]
    
}

convertTemperature(36.50)

//Given an array of integers nums, return the number of good pairs.
//
//A pair (i, j) is called good if nums[i] == nums[j] and i < j.


func numIdenticalPairs(_ nums: [Int]) -> Int {
    
    
    var sum = 0
    
    for index in 0..<nums.count {
        for j in 0..<index {
            if nums[index] == nums[j] {
                sum += 1
            }
        }
    }
    
    return sum
}


print(numIdenticalPairs([1,5,77,5,]))


// попробовать созать массив в массиве и пробежаться по нему
// задачки на вложенные циклы
// MVМM + coordinator
//MVVM+C
//
//MVVM + Coordinator
//
//POP
//
//protocol oriented programming
//
//protocol для чего нужны и использование в реальных примерам
//
//SOLID
//
//Dependency inversion
//
//GRASP
//
//Антипаттерны
//
//Паттерны программирования



// Protocol

protocol RecipeProtocol {
    
    var recipes: [String] { get set }
    
    func addNewRecipe(_ recipe: String) -> String
    func removeRecipe(_ recipe: String) -> String
    func updateRecipe(_ recipe: String) -> String
}


// ViewModel нижний уровень

final class RecipeViewModel: RecipeProtocol {
    
    var recipes: [String] = []
    
    init(recipes: [String]) {
        self.recipes = recipes
    }
    
    func addNewRecipe(_ recipe: String) -> String {
        return "Добавлен новый рецепт"
    }
    
    func removeRecipe(_ recipe: String) -> String {
        return "Рецепт удален"
    }
    
    func updateRecipe(_ recipe: String) -> String {
        return "Рецепт обновлен"
    }
    
    
}

// ViewModel нижний уровень

final class MockRecipeViewModel: RecipeProtocol {
    
    var recipes: [String] = []
    
    init(recipes: [String]) {
        self.recipes = recipes
    }
    
    func addNewRecipe(_ recipe: String) -> String {
        return "Добавлен новый тестовый рецепт"
    }
    
    func removeRecipe(_ recipe: String) -> String {
        return "Тестовый рецепт удален"
    }
    
    func updateRecipe(_ recipe: String) -> String {
        return "Тестовый рецепт обновлен"
    }
    
}

// ViewController верхний уровень

final class RecipeController: UIViewController {
    
    let recipeViewmodel: RecipeProtocol
    
    init(recipeViewmodel: RecipeProtocol) {
        self.recipeViewmodel = recipeViewmodel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

let recipeController = RecipeController(recipeViewmodel: RecipeViewModel(recipes: ["Рецепт 1", "Рецепт 2", "Рецепт 3"]))
recipeController.recipeViewmodel.addNewRecipe("Новый рецепт")

let mockRecipeController = RecipeController(recipeViewmodel: MockRecipeViewModel(recipes: ["Тестовый рецепт", "Тестовый рецепт 2"]))
mockRecipeController.recipeViewmodel.removeRecipe("Удалить рецепт")





func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    for i in 0..<nums.count {
        for j in i+1..<nums.count {
            if nums[i] + nums[j] == target {
                return [i, j]
            }
            
            print("i: \(nums[i])")
            print("j: \(nums[j])")
        }
    }
    return []
}

print(twoSum([1,2,3,4,5], 5))




func isPalindrome(_ x: Int) -> Bool {
       
    let str = String(x)
    

//    
//    if str == String(str.reversed()) {
//        return true
//    } else {
//        return false
//    }
//    
    
        return str == String(str.reversed())
    
    }

print(isPalindrome(121))


// Дизайн-паттерны
// Фабрика


final class VegetarianRecipeViewModel: RecipeProtocol {
    var recipes: [String] = []
    
    init(recipes: [String]) {
        self.recipes = recipes
    }
    
    func addNewRecipe(_ recipe: String) -> String {
        return "Добавлен новый вегетарианский рецепт"
    }
    
    func removeRecipe(_ recipe: String) -> String {
        return "Вегетарианский рецепт удален"
    }
    
    func updateRecipe(_ recipe: String) -> String {
        return "Вегетарианский рецепт обновлен"
    }
}

final class MeatLoverRecipeViewModel: RecipeProtocol {
    var recipes: [String] = []
    
    init(recipes: [String]) {
        self.recipes = recipes
    }
    
    func addNewRecipe(_ recipe: String) -> String {
        return "Добавлен новый рецепт для мясоедов"
    }
    
    func removeRecipe(_ recipe: String) -> String {
        return "Рецепт для мясоедов удален"
    }
    
    func updateRecipe(_ recipe: String) -> String {
        return "Рецепт для мясоедов обновлен"
    }
}

final class DessertRecipeViewModel: RecipeProtocol {
    var recipes: [String] = []
    
    init(recipes: [String]) {
        self.recipes = recipes
    }
    
    func addNewRecipe(_ recipe: String) -> String {
        return "Добавлен новый десерт"
    }
    
    func removeRecipe(_ recipe: String) -> String {
        return "Десерт удален"
    }
    
    func updateRecipe(_ recipe: String) -> String {
        return "Десерт обновлен"
    }
}

// создаем фабрику

enum RecipeType {
    
    case vegetarian
    case meatLover
    case dessert
}

class RecipeFactory {
    
    static func createRecipeViewModel(type: RecipeType, recipes: [String]) -> RecipeProtocol {
        switch type {
        case .vegetarian:
            return VegetarianRecipeViewModel(recipes: recipes)
        case .meatLover:
            return MeatLoverRecipeViewModel(recipes: recipes)
        case .dessert:
            return DessertRecipeViewModel(recipes: recipes)
        }
    }
}

// применение фабрики
// на главном экране при создании нового рецепта выбрали тип рецепта. В зависимости от выбранного типа создается нужная вьюмодель и передается на детальный экран с рецептом.

// этот код был бы внутри метода при выборе типа рецепта
let vegetarianViewModel = RecipeFactory.createRecipeViewModel(type: .vegetarian, recipes: ["Салат", "Овощное карри"])

let detailRecipeController = RecipeController(recipeViewmodel: vegetarianViewModel)


let meatLoverViewModel = RecipeFactory.createRecipeViewModel(type: .meatLover, recipes: ["Стейк", "Бургер"])
let dessertViewModel = RecipeFactory.createRecipeViewModel(type: .dessert, recipes: ["Тирамису", "Чизкейк"])

print(vegetarianViewModel.addNewRecipe("Новый вегетарианский рецепт"))
// Выведет: Добавлен новый вегетарианский рецепт

print(meatLoverViewModel.addNewRecipe("Новый рецепт для мясоедов"))
// Выведет: Добавлен новый рецепт для мясоедов

print(dessertViewModel.addNewRecipe("Новый десерт"))
// Выведет: Добавлен новый десерт



//Адаптер

//старая логика
class LegacyRecipeManager {
    
    private var legacyRecipes: [String] = []
    
    func add(recipe: String) {
        legacyRecipes.append(recipe)
    }
    
    func delete(recipe: String) -> Bool {
        if let index = legacyRecipes.firstIndex(of: recipe) {
            legacyRecipes.remove(at: index)
            return true
        }
        return false
    }
    
    func modify(recipe: String, newRecipe: String) -> Bool {
        if let index = legacyRecipes.firstIndex(of: recipe) {
            legacyRecipes[index] = newRecipe
            return true
        }
        return false
    }
    
    func getRecipes() -> [String] {
        return legacyRecipes
    }
}

//адаптер для адаптации к новой логике. Адаптер должен "перевести" вызовы методов из RecipeProtocol в вызовы методов LegacyRecipeManager, сохраняя при этом их логику.

class LegacyRecipeAdapter: RecipeProtocol {
    
    private var legacyManager: LegacyRecipeManager
    
    init(legacyManager: LegacyRecipeManager) {
        self.legacyManager = legacyManager
    }
    
    var recipes: [String] {
        get {
            return legacyManager.getRecipes()
        }
        set {
            // Заменяем старые рецепты новыми
            for recipe in newValue {
                if !legacyManager.getRecipes().contains(recipe) {
                    legacyManager.add(recipe: recipe)
                }
            }
        }
    }
    
    func addNewRecipe(_ recipe: String) -> String {
        legacyManager.add(recipe: recipe)
        return "Старый менеджер: добавлен рецепт \(recipe)"
    }
    
    func removeRecipe(_ recipe: String) -> String {
        let success = legacyManager.delete(recipe: recipe)
        return success ? "Старый менеджер: рецепт удален" : "Старый менеджер: рецепт не найден"
    }
    
    func updateRecipe(_ recipe: String) -> String {
        if let firstRecipe = legacyManager.getRecipes().first {
            let success = legacyManager.modify(recipe: firstRecipe, newRecipe: recipe)
            return success ? "Старый менеджер: рецепт обновлен" : "Старый менеджер: обновление не удалось"
        }
        return "Старый менеджер: рецепты отсутствуют"
    }
}


// применение

let legacyManager = LegacyRecipeManager()

// Создаем адаптер для старого менеджера
let legacyAdapter = LegacyRecipeAdapter(legacyManager: legacyManager)

// Используем адаптер как объект, соответствующий RecipeProtocol
legacyAdapter.addNewRecipe("Старый рецепт")
print(legacyAdapter.recipes) // ["Старый рецепт"]

legacyAdapter.removeRecipe("Старый рецепт")
print(legacyAdapter.recipes) // []


// в контроллере

let legacyController = RecipeController(recipeViewmodel: legacyAdapter)
legacyController.recipeViewmodel.addNewRecipe("Старый рецепт через адаптер добавлен")



//Given an integer n, return a string array answer (1-indexed) where:
// • answer[i] == "FizzBuzz" if i is divisible by 3 and 5.
// • answer[i] == "Fizz" if i is divisible by 3.
// • answer[i] == "Buzz" if i is divisible by 5.
// • answer[i] == i (as a string) if none of the above conditions are true.


//Example 1:
//Input: n = 3
//Output: ["1","2","Fizz"]
//Example 2:
//Input: n = 5
//Output: ["1","2","Fizz","4","Buzz"]
//Example 3:
//Input: n = 15
//Output: ["1","2","Fizz","4","Buzz","Fizz","7","8","Fizz","Buzz","11","Fizz","13","14","FizzBuzz"]

func fizzBuzz(_ n: Int) -> [String] {
    
    var result:[String] = []
    
    for i in 1...n {
        if i % 3 == 0 && i % 5 == 0 {
            result.append("FizzBuzz")
        } else if i % 3 == 0 {
            result.append("Fizz")
        } else if i % 5  == 0 {
            result.append("Buzz")
        } else {
            result.append(String(i))
        }
    }
    
    return result
}


print(fizzBuzz(15))


//func fizzBuzz(_ n: Int) -> [String] {
//        (1...n).map { number in
//            switch (number % 3, number % 5) {
//                case (0, 0): "FizzBuzz"
//                case (0, _): "Fizz"
//                case (_, 0): "Buzz"
//                default: "\(number)"
//            }
//        }
//    }


// Абстрактная фабрика

//протокол
protocol RecipeAbstractFactory {
    func createRecipeViewModel(recipes: [String]) -> RecipeProtocol
}

//создание
final class RecipeViewModelFactory: RecipeAbstractFactory {
    func createRecipeViewModel(recipes: [String]) -> RecipeProtocol {
        return RecipeViewModel(recipes: recipes)
    }
}

final class MockRecipeViewModelFactory: RecipeAbstractFactory {
    func createRecipeViewModel(recipes: [String]) -> RecipeProtocol {
        return MockRecipeViewModel(recipes: recipes)
    }
}

//применение
let factory: RecipeAbstractFactory = RecipeViewModelFactory()
let recipeViewModel = factory.createRecipeViewModel(recipes: ["Рецепт 1", "Рецепт 2"])
let controller = RecipeController(recipeViewmodel: recipeViewModel)

let mockFactory: RecipeAbstractFactory = MockRecipeViewModelFactory()
let mockRecipeViewModel = mockFactory.createRecipeViewModel(recipes: ["Тестовый рецепт"])
let mocController = RecipeController(recipeViewmodel: mockRecipeViewModel)



//Цепочка обязанностей

//протокол
protocol LoginHandler {
    var nextHandler: LoginHandler? { get set }
    func handle(request: (login: String, password: String)) -> String?
    func setNext(handler: LoginHandler) -> LoginHandler
}

//базовый класс проверки
class BaseLoginHandler: LoginHandler {
    var nextHandler: LoginHandler?

    //метод устанавливает следующий обработчик и возвращает его, что позволяет нам связывать обработчики в цепочку.
    func setNext(handler: LoginHandler) -> LoginHandler {
        self.nextHandler = handler
        return handler
    }
    
    //этот метод проверяет, есть ли следующий обработчик. Если да, то передает запрос ему. Если следующего обработчика нет, возвращает сообщение "Данные прошли все проверки".
    func handle(request: (login: String, password: String)) -> String? {
        if let next = nextHandler {
            return next.handle(request: request)
        } else {
            return "Данные прошли все проверки"
        }
    }
}

//дополнительные классы проверки
class EmptyLoginHandler: BaseLoginHandler {
    override func handle(request: (login: String, password: String)) -> String? {
        if request.login.isEmpty {
            return "Ошибка: Логин не может быть пустым"
        } else {
            return super.handle(request: request)
        }
    }
}

class EmptyPasswordHandler: BaseLoginHandler {
    override func handle(request: (login: String, password: String)) -> String? {
        if request.password.isEmpty {
            return "Ошибка: Пароль не может быть пустым"
        } else {
            return super.handle(request: request)
        }
    }
}

class CredentialsCheckHandler: BaseLoginHandler {
    override func handle(request: (login: String, password: String)) -> String? {
        // В этом примере логин - "user", пароль - "password"
        if request.login == "user" && request.password == "password" {
            return "Успешный вход"
        } else {
            return "Ошибка: Неверные логин или пароль"
        }
    }
}

//Примение

let emptyLoginHandler = EmptyLoginHandler()
let emptyPasswordHandler = EmptyPasswordHandler()
let credentialsCheckHandler = CredentialsCheckHandler()

// Выстраиваем цепочку: проверка логина -> проверка пароля -> проверка учетных данных
emptyLoginHandler.setNext(handler: emptyPasswordHandler).setNext(handler: credentialsCheckHandler)

// Пример использования цепочки для проверки данных пользователя
let userInput = (login: "user", password: "password")
let result = emptyLoginHandler.handle(request: userInput)
print(result ?? "Запрос не обработан")  // Выведет: "Успешный вход"


// climbStairs
func climbStairs(_ n: Int) -> Int {
    if n == 1 {
        return 1
    } else if n == 2 {
        return 2
    } else {
        return climbStairs(n - 1) + climbStairs(n - 2)
    }
}

print(climbStairs(3))


// plusOne

func plusOne(_ digits: [Int]) -> [Int] {
    var result = digits
    result[result.count - 1] += 1
    return result
}
print(plusOne([1,2,3,4,5]))
