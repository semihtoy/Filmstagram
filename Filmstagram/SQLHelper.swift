//  SQLHelper.swift
//  Filmstagram
//  Created by Xcode on 11.11.2019.
//  Copyright © 2019 Xcode. All rights reserved.
import Foundation
import SQLite3
class SQLHelper {
    init()
    {
        db = openDatabase()
        createTable()
    }
    let dbPath: String = "myDb.sqlite"
    var db:OpaquePointer?
    func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS Search(imdbID TEXT PRIMARY KEY,Title TEXT,Year TEXT, Poster TEXT, Type TEXT );"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("person table created.")
            } else {
                print("person table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    func insert(_search : Search)
    {
        let insertStatementString = "INSERT INTO Search (Title, imdbID, Poster, Year, Type) VALUES (?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (_search.title! as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (_search.imdbID! as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (_search.poster! as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (_search.year! as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (_search.type! as NSString).utf8String, -1, nil)
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                Message.show(messageTitle: "Film Eklenmiştir");
            } else {
                Message.show(messageTitle: "Bu  film zaten ekledir");
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    func read() -> [Search] {
        let queryStatementString = "SELECT * FROM Search"
        var queryStatement: OpaquePointer? = nil
        var _film : [Search] = [];
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                var getFilm = Search();
                let Title = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let imdbID = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
                let Poster = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let Year = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let Type = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                getFilm.imdbID = imdbID;
                getFilm.title=Title;
                getFilm.poster=Poster;
                getFilm.year=Year;
                getFilm.type=Type;
                _film.append(getFilm)
                print("Query Result:")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return _film
    }
    /*
     func insert(search: Search) -> Void {
     let DataBase = Firestore.firestore()
     var Referans : DocumentReference? = nil
     let post = ["Title" : search.title, "Year" : search.year, "Type" : search.type, "Poster" : search.poster, "imdbID" : search.imdbID] as [String : Any ]
     Referans = DataBase.collection("SearchData").addDocument(data: post, completion: { (error) in
     if error != nil {
     Message.show()
     }
     })
     }
     */
}
