/*
 Playing with Combine framework

 Goals:
 • Create a Combine pipeline that emits integers from 1 to 10.
 • Filter out odd numbers.
 • Multiply each remaining number by 10.
 • Sum the resulting values.
 • Publish the final sum and subscribe to print it.

 Bonus round:
 • If any multiplied value exceeds 80, throw an error and handle it by providing a default sum.
 */

import Foundation
import Combine
import PlaygroundSupport

// MARK: - Playground Setup

PlaygroundPage.current.needsIndefiniteExecution = true

// MARK: - Combine Task

func processNumbers() -> AnyPublisher<Int, Error> {
    // TODO: Implement the Combine pipeline.
    // Hint: Use Publishers.Sequence, filter, map, reduce, and catch to build the pipeline.
    fatalError("processNumbers() not implemented")
}

// MARK: - Testing

var subscriptions = Set<AnyCancellable>()

processNumbers()
    .sink(receiveCompletion: { completion in
        switch completion {
        case .finished:
            print("Pipeline completed successfully.")
        case .failure(let error):
            print("Pipeline failed with error: \(error)")
        }
    }, receiveValue: { sum in
        print("Final sum: \(sum)")
    })
    .store(in: &subscriptions)

