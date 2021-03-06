describe 'SQL grammar', ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage('language-transact-sql')

    runs ->
      grammar = atom.grammars.grammarForScopeName('source.sql')

  it 'parses the grammar', ->
    expect(grammar).toBeTruthy()
    expect(grammar.scopeName).toBe 'source.sql'

  it 'tokenizes variables', ->
    {tokens} = grammar.tokenizeLine('@variable_name')
    expect(tokens[0]).toEqual value: '@variable_name', scopes: ['source.sql', 'variable']

  it 'tokenizes comments', ->
    {tokens} = grammar.tokenizeLine('-- comment')
    expect(tokens[0]).toEqual value: '-- comment', scopes: ['source.sql', 'comment']

  it 'tokenizes strings', ->
    {tokens} = grammar.tokenizeLine('\'Full String\'')
    expect(tokens[1]).toEqual value: 'Full String', scopes: ['source.sql', 'string']

  it 'tokenizes integers as numerics', ->
    {tokens} = grammar.tokenizeLine('10')
    expect(tokens[0]).toEqual value: '10', scopes: ['source.sql', 'numeric']

  it 'tokenizes decimals as numerics', ->
    {tokens} = grammar.tokenizeLine('500.00')
    expect(tokens[0]).toEqual value: '500.00', scopes: ['source.sql', 'numeric']

  it 'tokenizes null', ->
    {tokens} = grammar.tokenizeLine('null')
    expect(tokens[0]).toEqual value: 'null', scopes: ['source.sql', 'null']

  it 'tokenizes \'not null\'', ->
    {tokens} = grammar.tokenizeLine('not null')
    expect(tokens[0]).toEqual value: 'not null', scopes: ['source.sql', 'null']

  it 'tokenizes Data Types', ->
    {tokens} = grammar.tokenizeLine('declare @variable int')
    expect(tokens[3]).toEqual value: 'int', scopes: ['source.sql', 'data-type']

  it 'tokenizes Data Definition Language (DDL) keywords', ->
    {tokens} = grammar.tokenizeLine('create')
    expect(tokens[0]).toEqual value: 'create', scopes: ['source.sql', 'ddl']

  it 'tokenizes Data Manipulation Language (DML) keywords', ->
    {tokens} = grammar.tokenizeLine('select')
    expect(tokens[0]).toEqual value: 'select', scopes: ['source.sql', 'dml']

  it 'tokenizes Data Manipulation Language (DML) Clause keywords', ->
    {tokens} = grammar.tokenizeLine('from')
    expect(tokens[0]).toEqual value: 'from', scopes: ['source.sql', 'dml-clause']
