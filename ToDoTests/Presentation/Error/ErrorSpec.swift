//
//  ErrorSpec.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/28/17.
//  Copyright © 2017 Takeshi Ihara. All rights reserved.
//

import Quick
import Nimble

@testable import Presentation
@testable import Domain

class ErrorSpec: QuickSpec {

    override func spec() {
        describe("Error") {
            var error: Swift.Error!

            context("when not domain error") {
                beforeEach {
                    error = Presentation.Error.unknown
                }

                it("then unknown") {
                    expect(Presentation.Error.create(with: error)).to(equal(Presentation.Error.unknown))
                }
            }

            context("when domain error") {
                context("when connection error") {
                    beforeEach {
                        error = Domain.Error.connection
                    }

                    it("then connection") {
                        expect(Presentation.Error.create(with: error)).to(equal(Presentation.Error.connection))
                    }
                }

                context("when translation error") {
                    beforeEach {
                        error = Domain.Error.translation
                    }

                    it("then unknown") {
                        expect(Presentation.Error.create(with: error)).to(equal(Presentation.Error.unknown))
                    }
                }

                context("when notFound error") {
                    beforeEach {
                        error = Domain.Error.notFound
                    }

                    it("then not found") {
                        expect(Presentation.Error.create(with: error)).to(equal(Presentation.Error.response(message: "リソースが見つかりませんでした")))
                    }
                }

                context("when unknown error") {
                    beforeEach {
                        error = Domain.Error.unknown
                    }

                    it("then unknown") {
                        expect(Presentation.Error.create(with: error)).to(equal(Presentation.Error.unknown))
                    }
                }
            }
        }
    }
}
