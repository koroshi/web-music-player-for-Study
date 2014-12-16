expect = require("chai").expect
search = require "../lib/search.coffee"
fs = require "fs"
describe "Search", ()->
  describe "#scan()", ()->
#   this test is lack of sort file(so the testcase  must be sorted by filename)
#    @timeout 5000
    before ()->
      if !(fs.existsSync ".test_files")
        fs.mkdirSync ".test_files"
        fs.writeFileSync ".test_files/a", ""
        fs.writeFileSync ".test_files/b", ""
        fs.mkdirSync ".test_files/dir"
        fs.writeFileSync ".test_files/dir/c", ""
        fs.mkdirSync ".test_files/dir2"
        fs.writeFileSync ".test_files/dir2/d", ""
        fs.mkdirSync ".test_files/dir2/dir3"
        fs.writeFileSync ".test_files/dir2/dir3/3", ""
        fs.mkdirSync ".test_files/dir2/dir3/dir4"
        fs.writeFileSync ".test_files/dir2/dir3/dir4/4", ""

    after ()->
      fs.unlinkSync ".test_files/dir/c"
      fs.rmdirSync ".test_files/dir"
      fs.unlinkSync ".test_files/dir2/dir3/dir4/4"
      fs.rmdirSync ".test_files/dir2/dir3/dir4"
      fs.unlinkSync ".test_files/dir2/dir3/3"
      fs.rmdirSync ".test_files/dir2/dir3"
      fs.unlinkSync ".test_files/dir2/d"
      fs.rmdirSync ".test_files/dir2"
      fs.unlinkSync ".test_files/a"
      fs.unlinkSync ".test_files/b"
      fs.rmdirSync ".test_files"

    it "should retrieve the files from a directory", (done)->
      search.scan ".test_files", 0 , (err,flist)->
        expect(flist).to.deep.equal [
          ".test_files/a",
          ".test_files/b",
          ".test_files/dir/c",
          ".test_files/dir2/d",
          ".test_files/dir2/dir3/3",
          ".test_files/dir2/dir3/dir4/4",
        ]
        done();
    it "should stop at a specified depth", (done)->
      search.scan ".test_files", 1 , (err,flist)->
        expect(flist).to.deep.equal [
          ".test_files/a",
          ".test_files/b"
        ]
        done();
    it "should stop at a specified depth 2", (done)->
      search.scan ".test_files", 2 , (err,flist)->
        expect(flist).to.deep.equal [
          ".test_files/a",
          ".test_files/b",
          ".test_files/dir/c",
          ".test_files/dir2/d",
        ]
        done();
    it "should stop at a specified depth 3", (done)->
      search.scan ".test_files", 3 , (err,flist)->
        expect(flist).to.deep.equal [
          ".test_files/a",
          ".test_files/b",
          ".test_files/dir/c",
          ".test_files/dir2/d",
          ".test_files/dir2/dir3/3",
        ]
        done();
    it "should stop at a specified depth 4", (done)->
      search.scan ".test_files", 4 , (err,flist)->
        expect(flist).to.deep.equal [
          ".test_files/a",
          ".test_files/b",
          ".test_files/dir/c",
          ".test_files/dir2/d",
          ".test_files/dir2/dir3/3",
          ".test_files/dir2/dir3/dir4/4",
        ]
        done();

