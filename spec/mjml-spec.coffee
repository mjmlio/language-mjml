describe 'mjml grammar', ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage('language-mjml')

    waitsForPromise ->
      atom.packages.activatePackage('language-coffee-script')

    runs ->
      grammar = atom.grammars.grammarForScopeName('text.mjml.basic')

  it 'parses the grammar', ->
    expect(grammar).toBeTruthy()
    expect(grammar.scopeName).toBe 'text.mjml.basic'

  describe 'meta.scope.outside-tag scope', ->
    it 'tokenizes an empty file', ->
      lines = grammar.tokenizeLines ''
      expect(lines[0][0]).toEqual value: '', scopes: ['text.mjml.basic']

    it 'tokenizes a single < as without freezing', ->
      lines = grammar.tokenizeLines '<'
      expect(lines[0][0]).toEqual value: '<', scopes: ['text.mjml.basic']

      lines = grammar.tokenizeLines ' <'
      expect(lines[0][0]).toEqual value: ' <', scopes: ['text.mjml.basic']

    it 'tokenizes <? without locking up', ->
      lines = grammar.tokenizeLines '<?'
      expect(lines[0][0]).toEqual value: '<?', scopes: ['text.mjml.basic']

    it 'tokenizes >< as mjml without locking up', ->
      lines = grammar.tokenizeLines '><'
      expect(lines[0][0]).toEqual value: '><', scopes: ['text.mjml.basic']

    it 'tokenizes < after tags without locking up', ->
      lines = grammar.tokenizeLines '<span><'
      expect(lines[0][3]).toEqual value: '<', scopes: ['text.mjml.basic']

  describe 'template script tags', ->
    it 'tokenizes the content inside the tag as mjml', ->
      lines = grammar.tokenizeLines '''
        <script id='id' type='text/template'>
          <div>test</div>
        </script>
      '''

      expect(lines[0][0]).toEqual value: '<', scopes: ['text.mjml.basic', 'punctuation.definition.tag.mjml']
      expect(lines[1][0]).toEqual value: '  ', scopes: ['text.mjml.basic', 'text.embedded.mjml']
      expect(lines[1][1]).toEqual value: '<', scopes: ['text.mjml.basic', 'text.embedded.mjml', 'meta.tag.block.any.mjml', 'punctuation.definition.tag.begin.mjml']

  describe 'CoffeeScript script tags', ->
    it 'tokenizes the content inside the tag as CoffeeScript', ->
      lines = grammar.tokenizeLines '''
        <script id='id' type='text/coffeescript'>
          -> console.log 'hi'
        </script>
      '''

      expect(lines[0][0]).toEqual value: '<', scopes: ['text.mjml.basic', 'punctuation.definition.tag.mjml']
      expect(lines[1][0]).toEqual value: '  ', scopes: ['text.mjml.basic', 'source.coffee.embedded.mjml']
      expect(lines[1][1]).toEqual value: '->', scopes: ['text.mjml.basic', 'source.coffee.embedded.mjml', 'storage.type.function.coffee']

  describe 'JavaScript script tags', ->
    beforeEach ->
      waitsForPromise -> atom.packages.activatePackage('language-javascript')

    it 'tokenizes the content inside the tag as JavaScript', ->
      lines = grammar.tokenizeLines '''
        <script id='id' type='text/javascript'>
          var hi = 'hi'
        </script>
      '''

      expect(lines[0][0]).toEqual value: '<', scopes: ['text.mjml.basic', 'punctuation.definition.tag.mjml']

      expect(lines[1][0]).toEqual value: '  ', scopes: ['text.mjml.basic', 'source.js.embedded.mjml']
      expect(lines[1][1]).toEqual value: 'var', scopes: ['text.mjml.basic', 'source.js.embedded.mjml', 'storage.type.var.js']

  describe "comments", ->
    it "tokenizes -- as an error", ->
      {tokens} = grammar.tokenizeLine '<!-- some comment --->'

      expect(tokens[0]).toEqual value: '<!--', scopes: ['text.mjml.basic', 'comment.block.mjml', 'punctuation.definition.comment.mjml']
      expect(tokens[1]).toEqual value: ' some comment -', scopes: ['text.mjml.basic', 'comment.block.mjml']
      expect(tokens[2]).toEqual value: '-->', scopes: ['text.mjml.basic', 'comment.block.mjml', 'punctuation.definition.comment.mjml']

      {tokens} = grammar.tokenizeLine '<!-- -- -->'

      expect(tokens[0]).toEqual value: '<!--', scopes: ['text.mjml.basic', 'comment.block.mjml', 'punctuation.definition.comment.mjml']
      expect(tokens[1]).toEqual value: ' ', scopes: ['text.mjml.basic', 'comment.block.mjml']
      expect(tokens[2]).toEqual value: '--', scopes: ['text.mjml.basic', 'comment.block.mjml', 'invalid.illegal.bad-comments-or-CDATA.mjml']
      expect(tokens[3]).toEqual value: ' ', scopes: ['text.mjml.basic', 'comment.block.mjml']
      expect(tokens[4]).toEqual value: '-->', scopes: ['text.mjml.basic', 'comment.block.mjml', 'punctuation.definition.comment.mjml']
