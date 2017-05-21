//
//  ToDoTranslatorSpec.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/22/17.
//  Copyright © 2017 Takeshi Ihara. All rights reserved.
//

import Quick
import Nimble

@testable import Domain
@testable import Infrastructure

class ToDoTranslatorSpec: QuickSpec {
    override func spec() {
        describe("ToDoTranslator") {
            context("when translate") {
                var todo: Infrastructure.ToDo!

                beforeEach {
                    todo = ToDo(title: "title")
                }

                it("then get entity") {
                    let result = ToDoTranslator.translate(base: todo)
                    expect(result.id).to(equal(todo.id))
                    expect(result.title).to(equal(todo.title))
                }
            }
        }
    }
}
