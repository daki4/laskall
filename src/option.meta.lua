---@module 'option'
---@meta

---@class Option<T>: Adt
---@field private _state function Holds which variant this is (Some or None)
---@field private _value T|nil The wrapped value (exists if Some, nil if None)
---@field p
---@field private match fun(self: Option<T>, cases: { [function]: function }): any Pattern matching function that takes a table of handler functions

---Creates a Some variant of Option containing a value
---@generic T
---@param value T The value to wrap
---@return Option<T> Option containing the value, with methods:
---     - IsSome(): boolean # Returns true if Option is Some
---     - IsNone(): boolean # Returns true if Option is None
---     - IsSomeAnd(predicate: fun(value: T): boolean): boolean # Returns true if Some and predicate(value) is true
---     - IsNoneOr(predicate: fun(value: T): boolean): boolean # Returns true if None or predicate(value) is true
---     - Map<U>(mapper: fun(value: T): U): Option<U> # Transforms the contained value if Some
---     - MapOr<U>(default: U, mapper: fun(value: T): U): U # Returns mapped value or default
---     - MapOrElse<U>(default: fun(): U, mapper: fun(value: T): U): U # Returns mapped value or calls default()
---     - Unwrap(): T # Returns value or errors if None
---     - UnwrapOr(default: T): T # Returns value or default if None
---     - UnwrapOrElse(default: fun(): T): T # Returns value or calls default() if None
---     - Inspect(inspector: fun(value: T)): Option<T> # Calls inspector with value if Some
---     - OkOr<E>(error: E|fun(): E): Result<T, E> # Converts to Result (Ok if Some, Err if None)
---     - Filter(predicate: fun(value: T): boolean): Option<T> # Returns None if predicate fails
---     - Or(other: Option<T>): Option<T> # Returns self if Some, other if None
---     - OrElse(other: fun(): Option<T>): Option<T> # Returns self if Some, calls other() if None
---     - Xor(other: Option<T>): Option<T> # Returns Some if exactly one of self/other is Some
---     - And<U>(other: Option<U>): Option<U> # Returns other if self is Some, None if self is None
---     - AndThen<U>(f: fun(value: T): Option<U>): Option<U> # Returns f(value) if Some, None if None
---     - Expect(msg: string): T # Like unwrap but with custom error message
function Some(value) end

---Creates a None variant of Option
---@generic T
---@return Option<T> Empty Option with all the same methods as Some
function None() end

local optionFactory = BuildAdt("Option")

-- Register the variants with the ADT
optionFactory:Register(Some, "Some(T)", true)  -- Some holds a value
optionFactory:Register(None, "None", false)    -- None doesn't hold a value

-- All methods are added to optionFactory.baseState
-- They use pattern matching to handle Some and None cases appropriately
-- The implementation uses optionFactory:AdtCtor to create new instances
