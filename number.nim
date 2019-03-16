import options, strutils

const
  MaxNumberVal = 10_000_000_000_000_000_000'u64 - 1
  MaxDigitsCount = 19

type
  Number* = object
    val: uint64
    next: Option[NumberRef]
  NumberRef* = ref Number

proc increment*(n: NumberRef) =
  var this = n
  while not isNil(this):
    if this.val == MaxNumberVal:
      this.val = 0
      if not this.next.isSome:
        this.next = option(new Number)
      this = this.next.get
    else:
      this.val += 1
      break

proc `$`*(n: NumberRef): string =
  var this = n
  while not isNil(this):
    let buffer = $this.val
    result = buffer & result
    this = this.next.get(nil)
    if not isNil(this):
      result = repeat('0', MaxDigitsCount - buffer.len) & result
