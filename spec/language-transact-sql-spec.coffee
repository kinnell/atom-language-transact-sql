describe "SQL grammar", ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage("language-transact-sql")

    runs ->
      grammar = atom.syntax.grammarForScopeName("source.sql")

  it "parses the grammar", ->
    expect(grammar).toBeTruthy()
    expect(grammar.scopeName).toBe "source.sql"
