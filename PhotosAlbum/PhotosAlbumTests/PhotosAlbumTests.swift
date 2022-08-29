//
//  PhotosAlbumTests.swift
//  PhotosAlbumTests
//
//  Created by YEONGJIN JANG on 2022/08/25.
//

import XCTest
@testable import PhotosAlbum

class PhotosAlbumTests: XCTestCase {

    var repository: DoodleImageRepository?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.repository = DoodleImageRepositoryImplement()
    }

    override func tearDownWithError() throws {
        self.repository = nil
        try super.tearDownWithError() 
    }

    func testJsonData() throws {
        let array = repository?.convertDataToJson()
        guard let count = array?.count else { return }
        // The number of element in Doodle.json equal to 103
        XCTAssertEqual(count, 103)
    }
    
    func testAsyncImage() throws {
        let doodleUrl = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSmETnjE9_LGsbWjeNCwlRJ4Ox1ioqxEVtWd7Z4QCKHtI7PewxvEg"
  
        let expectation = self.expectation(description: "fetchImage")
        var fetchedImage: UIImage?
        
        repository?.loadAnImage(url: doodleUrl, completion: { result in
            fetchedImage = result
            
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNotNil(fetchedImage)
        
    }
    
    
}
