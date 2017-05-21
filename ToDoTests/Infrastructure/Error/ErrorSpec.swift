//
//  ErrorSpec.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/29/17.
//  Copyright © 2017 Takeshi Ihara. All rights reserved.
//

import Quick
import Nimble

@testable import Infrastructure
@testable import Domain

class ErrorSpec: QuickSpec {

    override func spec() {
        describe("Error") {
            var error: Swift.Error!

            context("when not infrastructure error") {
                beforeEach {
                    error = Domain.Error.unknown
                }

                it("then unknown") {
                    expect(Infrastructure.Error.create(with: error)).to(equal(Domain.Error.unknown))
                }
            }

            context("when infrastructure error") {
                context("when notFound error") {
                    beforeEach {
                        error = Infrastructure.Error.notFound
                    }

                    it("then not found") {
                        expect(Infrastructure.Error.create(with: error)).to(equal(Domain.Error.notFound))
                    }
                }

                context("when unknown error") {
                    beforeEach {
                        error = Infrastructure.Error.unknown
                    }

                    it("then unknown") {
                        expect(Infrastructure.Error.create(with: error)).to(equal(Domain.Error.unknown))
                    }
                }
            }
        }
    }
}
