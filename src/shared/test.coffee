"use strict"

assert = require 'assert'

contentscript = require './contentscript'
{testcases} = require './testcases'

for testname, testcase of testcases
    if not testcase.test # placeholding tests
        console.log "skip #{testname}."
        continue

    faked = new contentscript.Faker(testcase.test).get()
    against = testcase.against

    for key in ["appVersion", "platform", "oscpu", "userAgent"]
        assert.strictEqual(faked[key], against[key], "#{testname}:#{key} failed.")
