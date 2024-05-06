//
//  ImageGridReponse.swift
//  AdvaitFoundationDemo
//
//  Created by Gopu on 04/05/24.
//

import Foundation



// MARK: - ImageGridResponseElement
struct ImageGridResponseElement: Codable {
    let id, title: String
    let language: Language
    let thumbnail: Thumbnail
    let mediaType: Int
    let coverageURL: String
    let publishedAt, publishedBy: String
    let backupDetails: BackupDetails?
}

// MARK: - BackupDetails
struct BackupDetails: Codable {
    let pdfLink: String
    let screenshotURL: String
}

enum Language: String, Codable {
    case english = "english"
    case hindi = "hindi"
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let id: String
    let version: Int
    let domain: String
    let basePath: String
    let key: String
    let qualities: [Int]
    let aspectRatio: Int
}

enum Key: String, Codable {
    case imageJpg = "image.jpg"
}

typealias ImageGridResponse = [ImageGridResponseElement]
