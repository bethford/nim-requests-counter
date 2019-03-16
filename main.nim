import jester, locks, number

var
  lock: Lock
  counter = createShared(NumberRef, 1)

counter[] = new Number
initLock lock

proc hit(): Future[string] {.async.} =
  withLock lock:
    counter[].increment()
    result = $counter[]

routes:
  get "/":
    resp Http200, [("Connection", "close")], await hit()
