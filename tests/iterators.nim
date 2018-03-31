import unittest

suite "iterators":
    test "assign":
        iterator count2() : int {.closure.} =
            yield 1
            yield 2
        var it1 = count2
        doAssert(not finished(it1))
        doAssert(it1() == 1)
        # it1 and it2 are two references to the same iterator now
        var it2 = it1
        doAssert(it2() == 2)
        doAssert(not finished(it1))
        doAssert(it1() == 0)
        doAssert(finished(it1))
        doAssert(finished(it2))
        # it3 is distinct from it1 and it2
        var it3 = count2
        doAssert(it3() == 1)
    test "deepCopy":
        iterator count2() : int {.closure.} =
            yield 1
            yield 2
        var it1 = count2
        doAssert(not finished(it1))
        doAssert(it1() == 1)
        # you can deepCopy an iterator mid-iteration and it magically works, but that probably is not generally a good idea
        var it2: iterator(): int
        deepCopy(it2, it1)
        doAssert(it1() == 2)
        doAssert(not finished(it1))
        doAssert(it1() == 0)
        doAssert(finished(it1))

        doAssert(not finished(it2))
        doAssert(it2() == 2)
        doAssert(not finished(it2))
        doAssert(it2() == 0)
        doAssert(finished(it2))
