expect = require('chai').expect
tags = require('../lib/tags.coffee')

describe( 'Tags', ()->
  describe( '#pase()', ()->
    it 'should parse long formed tags', ()->
      args = ['--depth=4','--hello=world']
      results = tags.parse(args)
      expect(results).to.have.a.property('depth',4)
      expect(results).to.have.a.property('hello','world')
    it 'should fallback to defaults', ()->
      args = ['--depth=4','--hello=world']
      defaults = {depth:2, foo:"bar"}
      results = tags.parse(args,defaults)
      expected =
        depth:4,
        foo:'bar',
        hello:'world'
      expect(results).to.deep.equal(expected)
    it 'should accept tags without values as a bool', ()->
      args = ['--searchContents']
      results = tags.parse(args)
      expect(results).to.have.a.property("searchContents", true)
    it 'should accept short formed tags', ()->
      args = ['-std=4', '-h']
      replacements =
        s:'searchContents',
        d:'depth',
        t:'tend'
        h:'hello'
      results = tags.parse args, {}, replacements
      expected =
        searchContents:true,
        depth : 4,
        tend :true,
        hello:true
      expect(results).to.deep.equal(expected)
  )
)
