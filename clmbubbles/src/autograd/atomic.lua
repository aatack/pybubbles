require "util.strings"
require "util.functional"

--- Return an expression that picks a specific value from
-- its source table.
function pointer(location)
  local p = { path = splitstring(location, ".") }
  local index = nestedindexlambda(p.path)

  local one = constant(1)
  local zero = constant(0)

  --- Evaluate the pointer for a given source table.
  function p:evaluate(source)
    return index(source)
  end

  --- Return the derivative of the pointer's value with
  -- respect to some other value.
  function p:derivative(withrespectto)
    if self == withrespectto then
      return one
    else
      return zero
    end
  end

  return p
end

--- Return an expression describing a constant value.
function constant(x)
  local c = {}

  --- Evaluate the constant.
  function c:evaluate(_)
    return x
  end

  --- Return an expression representing the derivative
  -- of the constant with respect to another value, which
  -- is always zero.
  function c:derivative(_)
    return constant(0)
  end

  return c
end