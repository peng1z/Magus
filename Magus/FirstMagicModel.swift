//
//  FirstMagicModel.swift
//  Magus
//
//  Created by Peng Zhang on 4/27/23.
//

import Foundation
import OpenAIKit
import UIKit

class FirstMagicModel: ObservableObject{
    private var openai: OpenAI?
    func setup(){
        openai = OpenAI(Configuration(organizationId: "Personal", apiKey: "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"))
    }
    func generateImage(prompt: String) async -> UIImage?{
        guard let openai = openai else{
            return nil
        }
        do{
            let params = ImageParameters(
                prompt: prompt,
                resolution: .medium,
                responseFormat: .base64Json
            )
            let result = try await openai.createImage(parameters: params)
            let data = result.data[0].image
            let image = try openai.decodeBase64Image(data)
            return image
        }
        catch{
            print(String(describing: error))
            return nil
        }
    }
}
