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





