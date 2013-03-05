window.Wallet = class Wallet
  constructor: (@people = [], @lines = []) ->

Wallet.Person = class Person
  constructor: (@name) ->

Wallet.Line = class Line
  constructor: (@desc) ->
    @currency = 1  
    @bens  = []
    @payrs = []
    @date = null
    @group = null
    @shareMissing = false
    @reverse = false
    @divideAmongOthers = false

Wallet.Ben = class Ben
  constructor: (@person) ->
    @amount = null
    @offset = 0
    @multiply = 1
  
Wallet.Payr = class Payr
  constructor: (@person) ->
    @amount = 0