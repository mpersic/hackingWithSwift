//
//  ViewController.swift
//  Project5
//
//  Created by COBE on 01/06/2021.
//

import UIKit

class ViewController: UITableViewController {
    
    var allWords = [String]()
    var usedWords = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(newGame))
        // Do any additional setup after loading the view.
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
        startGame()
    }
    
    @objc func newGame(){
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc func startGame(){
        let defaults = UserDefaults.standard
        if let savedTitleWord = defaults.object(forKey: "title") as? Data {
            let jsonDecoder = JSONDecoder()
            do {
                title = try jsonDecoder.decode(String.self, from: savedTitleWord)
            }
            catch {
                print("Failed to load title")
            }
        }
        if let savedWords = defaults.object(forKey: "usedWords") as? Data {
            let jsonDecoder = JSONDecoder()
            do {
                usedWords = try jsonDecoder.decode([String].self, from: savedWords)
            }
            catch {
                print("Failed to load used words")
            }
        }
        else {
            title = allWords.randomElement()
            usedWords.removeAll(keepingCapacity: true)
        }
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    @objc func promptForAnswer(){
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let submitAction = UIAlertAction(title: "Submit", style: .default){
            [weak self, weak ac] _ in  //avoid strong reference cycle
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()
        let errorTitle: String
        let errorMessage: String
        if isPossible(word: lowerAnswer) {
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    usedWords.insert(answer, at: 0)
                    save()
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    return
                }
                else {
                    errorTitle = "Word not recognized"
                    errorMessage = "You can't just make them up you know."
                }
            }
            else {
                errorTitle = "Word already used"
                errorMessage = "Be more original"
            }
        }
        else {
            errorTitle = "Word not possible"
            errorMessage = "You can't spell that word from \(title!.lowercased())"
        }
        showErrorMessage(errorTitle: errorTitle, errorMessage: errorMessage)
    }
    
    func showErrorMessage(errorTitle: String, errorMessage: String){
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        for letter in word {
            if let position = tempWord.firstIndex(of: letter){
                tempWord.remove(at: position)
            }
            else {
                return false
            }
        }
        return true
    }
    
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isReal(word: String) -> Bool {
        if word == title?.lowercased() {
            return false
        }
        else if word.count < 3 {
            return false
        }
        else {
            let checker = UITextChecker()
            let range = NSRange(location: 0, length: word.utf16.count)
            let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
            return misspelledRange.location == NSNotFound
        }
    }
    
    func save(){
        let jsonEncoder = JSONEncoder()
        if let savedTitleWord = try? jsonEncoder.encode(title){
            let defaults = UserDefaults.standard
            defaults.set(savedTitleWord, forKey: "title")
        }
        else {
            print("Failed to save title word")
        }
        if let savedGuessedWords = try? jsonEncoder.encode(usedWords){
            let defaults = UserDefaults.standard
            defaults.set(savedGuessedWords, forKey: "usedWords")
        }
        else {
            print ("Failed to save used words")
        }
    }
    
}


